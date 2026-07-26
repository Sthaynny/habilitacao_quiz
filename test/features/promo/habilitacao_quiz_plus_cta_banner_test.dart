import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('banner Free exibe título do Plus', (tester) async {
    Get.put<ProGate>(StubProGate());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: HabilitacaoQuizPlusCtaBanner(),
        ),
      ),
    );

    expect(find.text(Strings.plusBannerSubtitle), findsNothing);
    expect(find.byIcon(Icons.workspace_premium_outlined), findsOneWidget);
  });
}
