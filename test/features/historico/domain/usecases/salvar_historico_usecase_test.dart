import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

class _FakeHistoricoRepo implements IHistoricoRepository {
  HistoricoEntity? lastSaved;

  @override
  Future<HistoricoEntity> getHistorico() async =>
      lastSaved ?? HistoricoEntity(resutados: []);

  @override
  Future<bool?> salvarHistorico(HistoricoEntity historico) async {
    lastSaved = historico;
    return true;
  }
}

ResultadoEntity _resultado(String titulo) => ResultadoEntity(
      id: 'test_$titulo',
      tipo: TipoResultado.tema,
      realizadoEm: DateTime.utc(2026, 7, 26),
      titulo: titulo,
      totalPerguntas: 10,
      result: true,
      totalRespostasCorretas: 8,
      percentual: 80,
    );

void main() {
  group('SalvarHistoricoUsecase', () {
    test('Free aplica FIFO ao 11º e sinaliza remoção', () async {
      final repo = _FakeHistoricoRepo();
      final usecase = SalvarHistoricoUsecase(repo, StubProGate());
      final historico = HistoricoEntity(resutados: []);
      for (var i = 0; i < 10; i++) {
        await usecase.registrarResultado(historico, _resultado('q$i'));
      }
      final outcome =
          await usecase.registrarResultado(historico, _resultado('q10'));
      expect(historico.resutados.length, 10);
      expect(historico.resutados.first.titulo, 'q1');
      expect(outcome.removeuMaisAntigoPorLimiteFree, isTrue);
      expect(outcome.persistido, isTrue);
    });

    test('Pro mantém 15 resultados sem FIFO (T21)', () async {
      final repo = _FakeHistoricoRepo();
      final usecase =
          SalvarHistoricoUsecase(repo, StubProGate(isPro: true));
      final historico = HistoricoEntity(resutados: []);
      SalvarHistoricoOutcome? lastOutcome;
      for (var i = 0; i < 15; i++) {
        lastOutcome =
            await usecase.registrarResultado(historico, _resultado('p$i'));
      }
      expect(historico.resutados.length, 15);
      expect(historico.resutados.first.titulo, 'p0');
      expect(historico.resutados.last.titulo, 'p14');
      expect(lastOutcome?.removeuMaisAntigoPorLimiteFree, isFalse);
      expect(lastOutcome?.persistido, isTrue);
      expect(repo.lastSaved?.resutados.length, 15);
    });
  });
}
