import 'package:flutter/foundation.dart';

/// Eventos de simulados concluídos (janela de 7 dias; Firebase opcional no futuro).
abstract interface class SimuladoWeeklyAnalytics {
  /// [simuladosNaUltimos7Dias] inclui o simulado recém-registrado no histórico.
  void logSimuladoCompleted({
    required int simuladosNaUltimos7Dias,
    required bool isPro,
  });
}

/// Implementação padrão: log em debug; no-op em release até integrar Firebase.
final class DebugSimuladoWeeklyAnalytics implements SimuladoWeeklyAnalytics {
  const DebugSimuladoWeeklyAnalytics();

  @override
  void logSimuladoCompleted({
    required int simuladosNaUltimos7Dias,
    required bool isPro,
  }) {
    if (kDebugMode) {
      debugPrint(
        '[hist] simulado_completed '
        'count_7d=$simuladosNaUltimos7Dias pro=$isPro',
      );
    }
  }
}
