import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/resultado_para_historico.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/simulado_weekly_analytics.dart';
import 'package:habilitacao_quiz/core/analytics/simulados_periodo.dart';

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
  SalvarHistoricoUsecase(
    this._repository,
    this._proGate,
    this._simuladoWeeklyAnalytics,
  );

  final IHistoricoRepository _repository;
  final ProGate _proGate;
  final SimuladoWeeklyAnalytics _simuladoWeeklyAnalytics;

  Future<SalvarHistoricoOutcome> registrarResultado(
    HistoricoEntity historico,
    ResultadoEntity resultado,
  ) async {
    final max = _proGate.maxResultadosHistorico;
    final countBefore = historico.resutados.length;
    final paraSalvar = resultadoParaPersistenciaHistorico(
      resultado,
      isPro: _proGate.isPro,
    );
    historico.add(paraSalvar, maxResultados: max);
    final removeuMaisAntigo =
        max != null && countBefore >= max;
    final persistido = await _repository.salvarHistorico(historico);
    if (paraSalvar.isSimulado) {
      final count7d = countSimuladosUltimosDias(historico.resutados);
      _simuladoWeeklyAnalytics.logSimuladoCompleted(
        simuladosNaUltimos7Dias: count7d,
        isPro: _proGate.isPro,
      );
    }
    return SalvarHistoricoOutcome(
      persistido: persistido,
      removeuMaisAntigoPorLimiteFree: removeuMaisAntigo,
    );
  }

}
