import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_free_limite_footer.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('Free exibe copy últimos 10 e CTA desbloquear', (tester) async {
    Get.put<ProGate>(StubProGate());
    Get.put<PromoFunnelAnalytics>(const DebugPromoFunnelAnalytics());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: HistoricoFreeLimiteFooter(),
        ),
      ),
    );

    expect(find.text(Strings.historicoFreeUltimosDez), findsOneWidget);
    expect(find.text(Strings.historicoPlusRodape), findsOneWidget);
    expect(find.text(Strings.historicoDesbloquearCompleto), findsOneWidget);
  });
}
