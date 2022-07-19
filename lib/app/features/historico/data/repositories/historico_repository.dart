import 'package:habilitacao_quiz/app/features/historico/data/datasources/historico_datasource.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';

class HistoricoRepository implements IHistoricoRepository {
  final HistoricoDatasource _datasource;

  HistoricoRepository(this._datasource);
  @override
  Future<List<HistoricoEntity>> getHistorico() async {
    return await _datasource.getHistorico();
  }

  @override
  Future<bool?> salvarHistorico(List<HistoricoEntity> list) {
    return _datasource.saveHistorico(list);
  }
}
