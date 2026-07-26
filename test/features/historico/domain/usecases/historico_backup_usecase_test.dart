import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/data/models/historico_backup_model.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/export_historico_backup_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/restaurar_historico_backup_usecase.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class _MemoryHistoricoRepo implements IHistoricoRepository {
  HistoricoEntity stored = HistoricoEntity(resutados: []);

  @override
  Future<HistoricoEntity> getHistorico() async => stored;

  @override
  Future<bool?> salvarHistorico(HistoricoEntity historico) async {
    stored = HistoricoEntity(resutados: List.from(historico.resutados));
    return true;
  }

  @override
  String encodeBackup(HistoricoEntity historico) {
    return HistoricoBackupModel.fromEntity(historico).toJson();
  }

  @override
  HistoricoEntity decodeBackup(String jsonContent) {
    return HistoricoBackupModel.fromJson(jsonContent).historico;
  }
}

ResultadoEntity _resultado(String titulo) => ResultadoEntity(
      id: 'id_$titulo',
      tipo: TipoResultado.tema,
      realizadoEm: DateTime.utc(2026, 7, 26),
      titulo: titulo,
      totalPerguntas: 10,
      result: true,
      totalRespostasCorretas: 7,
      percentual: 70,
    );

void main() {
  group('ExportHistoricoBackupUsecase', () {
    test('Free retorna erro Pro only', () {
      final usecase = ExportHistoricoBackupUsecase(
        _MemoryHistoricoRepo(),
        StubProGate(),
      );
      final result = usecase.call(HistoricoEntity(resutados: []));
      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e.menssagem, Strings.historicoBackupProOnly),
        (_) => fail('expected left'),
      );
    });

    test('Pro gera JSON de backup', () {
      final repo = _MemoryHistoricoRepo();
      final usecase = ExportHistoricoBackupUsecase(
        repo,
        StubProGate(isPro: true),
      );
      final historico = HistoricoEntity(resutados: [_resultado('A')]);
      final result = usecase.call(historico);
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('expected right'),
        (json) => expect(json.contains('backupVersion'), isTrue),
      );
    });
  });

  group('RestaurarHistoricoBackupUsecase', () {
    test('Pro restaura e atualiza memória', () async {
      final repo = _MemoryHistoricoRepo();
      final export = ExportHistoricoBackupUsecase(
        repo,
        StubProGate(isPro: true),
      );
      final backupJson = export
          .call(
            HistoricoEntity(resutados: [_resultado('backup')]),
          )
          .getOrElse(() => '');

      final memoria = HistoricoEntity(resutados: [_resultado('local')]);
      final restaurar = RestaurarHistoricoBackupUsecase(
        repo,
        StubProGate(isPro: true),
      );
      final result = await restaurar.call(
        jsonContent: backupJson,
        historicoEmMemoria: memoria,
      );

      expect(result.isRight(), isTrue);
      expect(memoria.resutados.length, 1);
      expect(memoria.resutados.first.titulo, 'backup');
      expect(repo.stored.resutados.first.titulo, 'backup');
    });

    test('JSON inválido retorna erro', () async {
      final restaurar = RestaurarHistoricoBackupUsecase(
        _MemoryHistoricoRepo(),
        StubProGate(isPro: true),
      );
      final result = await restaurar.call(
        jsonContent: '{',
        historicoEmMemoria: HistoricoEntity(resutados: []),
      );
      expect(result.isLeft(), isTrue);
      result.fold(
        (e) => expect(e.menssagem, Strings.historicoBackupArquivoInvalido),
        (_) => fail('expected left'),
      );
    });
  });
}
