import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';

class SalvarHistoricoUsecase {
  final IHistoricoRepository _repository;

  SalvarHistoricoUsecase(this._repository);

  Future<bool?> call(HistoricoEntity historico) {
    return _repository.salvarHistorico(historico);
  }
}
