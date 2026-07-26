import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_export_format.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/i_historico_export_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/historico_export_content_builder.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/export_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class _FakeExportRepo implements IHistoricoExportRepository {
  String? lastFilename;
  List<int>? lastBytes;

  @override
  Future<String> writeTempFile({
    required String filename,
    required List<int> bytes,
  }) async {
    lastFilename = filename;
    lastBytes = bytes;
    return '/tmp/$filename';
  }
}

ResultadoEntity _resultado() => ResultadoEntity(
      id: 'r1',
      tipo: TipoResultado.simulado,
      realizadoEm: DateTime.utc(2026, 7, 26),
      titulo: Strings.simulado,
      totalPerguntas: 15,
      result: true,
      totalRespostasCorretas: 12,
      percentual: 80,
    );

void main() {
  test('Free não exporta', () async {
    final usecase = ExportHistoricoUsecase(
      StubProGate(isPro: false),
      _FakeExportRepo(),
      const HistoricoExportContentBuilder(),
    );
    final result = await usecase(
      resultados: [_resultado()],
      format: HistoricoExportFormat.csv,
    );
    expect(result.failure, ExportHistoricoFailure.proRequired);
  });

  test('Pro gera arquivo CSV compartilhável', () async {
    final repo = _FakeExportRepo();
    final usecase = ExportHistoricoUsecase(
      StubProGate(isPro: true),
      repo,
      const HistoricoExportContentBuilder(),
    );
    final result = await usecase(
      resultados: [_resultado()],
      format: HistoricoExportFormat.csv,
      exportedAt: DateTime.utc(2026, 7, 26, 10, 0),
    );
    expect(result.failure, isNull);
    expect(result.file?.filename, endsWith('.csv'));
    expect(result.file?.path, contains('habilitacao_quiz_historico_'));
    expect(repo.lastBytes, isNotEmpty);
  });

  test('lista vazia retorna empty', () async {
    final usecase = ExportHistoricoUsecase(
      StubProGate(isPro: true),
      _FakeExportRepo(),
      const HistoricoExportContentBuilder(),
    );
    final result = await usecase(
      resultados: [],
      format: HistoricoExportFormat.pdf,
    );
    expect(result.failure, ExportHistoricoFailure.empty);
  });
}
