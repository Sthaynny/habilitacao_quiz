import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_limite_free_feedback.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('não exibe snackbar sem remoção por limite Free', (tester) async {
    Get.testMode = true;
    Get.put<PromoFunnelAnalytics>(const DebugPromoFunnelAnalytics());

    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: SizedBox.shrink())),
    );

    showHistoricoLimiteFreeSnackbarIfNeeded(
      const SalvarHistoricoOutcome(
        persistido: true,
        removeuMaisAntigoPorLimiteFree: false,
      ),
    );
    await tester.pump();

    expect(Get.isSnackbarOpen, isFalse);
  });

  testWidgets('exibe snackbar no 11º save Free', (tester) async {
    Get.testMode = true;
    Get.put<PromoFunnelAnalytics>(const DebugPromoFunnelAnalytics());

    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: SizedBox.shrink())),
    );

    showHistoricoLimiteFreeSnackbarIfNeeded(
      const SalvarHistoricoOutcome(
        persistido: true,
        removeuMaisAntigoPorLimiteFree: true,
      ),
    );
    await tester.pump();

    expect(Get.isSnackbarOpen, isTrue);
    Get.closeAllSnackbars();
    await tester.pump();
  });
}
