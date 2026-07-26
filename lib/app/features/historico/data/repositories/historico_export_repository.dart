import 'package:habilitacao_quiz/app/features/historico/data/datasources/historico_export_datasource.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/i_historico_export_repository.dart';

class HistoricoExportRepository implements IHistoricoExportRepository {
  HistoricoExportRepository(this._datasource);

  final HistoricoExportDatasource _datasource;

  @override
  Future<String> writeTempFile({
    required String filename,
    required List<int> bytes,
  }) {
    return _datasource.writeTempFile(filename: filename, bytes: bytes);
  }
}
