import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

/// Resultado de registrar um item no histórico persistido.
class SalvarHistoricoOutcome {
  const SalvarHistoricoOutcome({
    required this.persistido,
    required this.removeuMaisAntigoPorLimiteFree,
  });

  final bool? persistido;
  final bool removeuMaisAntigoPorLimiteFree;
}

class SalvarHistoricoUsecase {
  SalvarHistoricoUsecase(this._repository, this._proGate);

  final IHistoricoRepository _repository;
  final ProGate _proGate;

  Future<SalvarHistoricoOutcome> registrarResultado(
    HistoricoEntity historico,
    ResultadoEntity resultado,
  ) async {
    final max = _proGate.maxResultadosHistorico;
    final countBefore = historico.resutados.length;
    historico.add(resultado, maxResultados: max);
    final removeuMaisAntigo =
        max != null && countBefore >= max;
    final persistido = await _repository.salvarHistorico(historico);
    return SalvarHistoricoOutcome(
      persistido: persistido,
      removeuMaisAntigoPorLimiteFree: removeuMaisAntigo,
    );
  }

}
