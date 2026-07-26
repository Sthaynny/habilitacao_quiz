import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/core/analytics/simulado_weekly_analytics.dart';

void main() {
  test('DebugSimuladoWeeklyAnalytics registra conclusão sem lançar', () {
    const analytics = DebugSimuladoWeeklyAnalytics();
    expect(
      () {
        analytics.logSimuladoCompleted(
          simuladosNaUltimos7Dias: 2,
          isPro: true,
        );
      },
      returnsNormally,
    );
  });
}
