import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';

class GetHistoricoUsecase {
  final IHistoricoRepository _repository;

  GetHistoricoUsecase(this._repository);

  Future<List<HistoricoEntity>> call() {
    return _repository.getHistorico();
  }
}
