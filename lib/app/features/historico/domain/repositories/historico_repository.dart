import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';

abstract class IHistoricoRepository {
  Future<List<HistoricoEntity>> getHistorico();
  Future<bool?> salvarHistorico(List<HistoricoEntity> list);
}
