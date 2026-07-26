import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('banner Free exibe ícone e respeita altura mínima 48dp',
      (tester) async {
    Get.put<ProGate>(StubProGate());
    Get.put<PromoFunnelAnalytics>(const DebugPromoFunnelAnalytics());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: HabilitacaoQuizPlusCtaBanner(),
        ),
      ),
    );

    expect(find.text(Strings.plusBannerSubtitle), findsNothing);
    expect(find.byIcon(Icons.workspace_premium_outlined), findsOneWidget);

    final semantics = tester.getSemantics(find.byType(InkWell));
    expect(semantics.label, contains(Strings.plusBannerSemantics));
    expect(semantics.hint, Strings.plusBannerHint);

    final box = tester.renderObject<RenderBox>(
      find.byType(ConstrainedBox).first,
    );
    expect(box.size.height, greaterThanOrEqualTo(48));
  });
}
