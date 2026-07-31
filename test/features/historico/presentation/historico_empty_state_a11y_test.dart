import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/widgets/historico_empty_state.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('empty state expõe semantics nos CTAs', (tester) async {
    Get.put<ProGate>(StubProGate());

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: HistoricoEmptyState(onIniciarQuiz: _noop),
        ),
      ),
    );

    final quizCta = tester.getSemantics(
      find.text(Strings.historicoEmptyCtaQuiz),
    );
    expect(quizCta.label, Strings.historicoEmptyCtaQuiz);

    final plusCta = tester.getSemantics(
      find.text(Strings.historicoEmptyCtaPlus),
    );
    expect(plusCta.hint, Strings.plusBannerHint);
  });
}

void _noop() {}
