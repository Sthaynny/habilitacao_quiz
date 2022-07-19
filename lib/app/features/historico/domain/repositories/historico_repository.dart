import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';

abstract class IHistoricoRepository {
  Future<HistoricoEntity> getHistorico();
  Future<bool?> salvarHistorico(HistoricoEntity historico);
}
