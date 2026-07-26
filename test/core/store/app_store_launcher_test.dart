import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/constants/app_store_constants.dart';
import 'package:habilitacao_quiz/core/store/app_store_launcher.dart';

class _RecordingPromoAnalytics implements PromoFunnelAnalytics {
  int storeClicks = 0;

  @override
  void logClick(PromoSurface surface, PromoClickTarget target) {
    if (target == PromoClickTarget.openStore) {
      storeClicks++;
    }
  }

  @override
  void logImpression(PromoSurface surface) {}
}

void main() {
  tearDown(Get.reset);

  testWidgets(
    'openHabilitacaoQuizPlusStore snackbar quando !isProPublished',
    (tester) async {
      Get.testMode = true;
      final analytics = _RecordingPromoAnalytics();
      Get.put<PromoFunnelAnalytics>(analytics);

      await tester.pumpWidget(
        const GetMaterialApp(home: Scaffold(body: SizedBox.shrink())),
      );

      await openHabilitacaoQuizPlusStore();
      await tester.pump();

      expect(analytics.storeClicks, 1);
      expect(Get.isSnackbarOpen, isTrue);
    },
    skip: AppStoreConstants.isProPublished,
  );
}
