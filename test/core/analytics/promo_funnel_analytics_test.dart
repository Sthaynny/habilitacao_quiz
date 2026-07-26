import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';

void main() {
  test('DebugPromoFunnelAnalytics registra impressão e clique sem lançar',
      () {
    const analytics = DebugPromoFunnelAnalytics();
    expect(
      () {
        analytics.logImpression(PromoSurface.homeBanner);
        analytics.logClick(
          PromoSurface.plusScreen,
          PromoClickTarget.openStore,
        );
      },
      returnsNormally,
    );
  });
}
