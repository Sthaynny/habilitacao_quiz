import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_export_file_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_export_format.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/i_historico_export_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/historico_export_content_builder.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

enum ExportHistoricoFailure {
  proRequired,
  empty,
  ioError,
}

class ExportHistoricoResult {
  const ExportHistoricoResult._({
    this.file,
    this.failure,
  });

  final HistoricoExportFileEntity? file;
  final ExportHistoricoFailure? failure;

  factory ExportHistoricoResult.success(HistoricoExportFileEntity file) =>
      ExportHistoricoResult._(file: file);

  factory ExportHistoricoResult.failure(ExportHistoricoFailure failure) =>
      ExportHistoricoResult._(failure: failure);
}

class ExportHistoricoUsecase {
  ExportHistoricoUsecase(
    this._proGate,
    this._exportRepository,
    this._contentBuilder,
  );

  final ProGate _proGate;
  final IHistoricoExportRepository _exportRepository;
  final HistoricoExportContentBuilder _contentBuilder;

  Future<ExportHistoricoResult> call({
    required List<ResultadoEntity> resultados,
    required HistoricoExportFormat format,
    DateTime? exportedAt,
  }) async {
    if (!_proGate.isPro) {
      return ExportHistoricoResult.failure(ExportHistoricoFailure.proRequired);
    }
    if (resultados.isEmpty) {
      return ExportHistoricoResult.failure(ExportHistoricoFailure.empty);
    }

    final at = exportedAt ?? DateTime.now();
    final isPdf = format == HistoricoExportFormat.pdf;
    try {
      final bytes = _contentBuilder.buildBytes(
        resultados: resultados,
        isPdf: isPdf,
      );
      final filename = _contentBuilder.filenameFor(isPdf: isPdf, exportedAt: at);
      final path = await _exportRepository.writeTempFile(
        filename: filename,
        bytes: bytes,
      );
      return ExportHistoricoResult.success(
        HistoricoExportFileEntity(path: path, filename: filename),
      );
    } catch (_) {
      return ExportHistoricoResult.failure(ExportHistoricoFailure.ioError);
    }
  }
}
