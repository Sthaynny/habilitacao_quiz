import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/features/resultado/presentation/resultado_screen.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('Free simulado 15q mostra copy e banner Quiz+',
      (tester) async {
    Get.put<ProGate>(StubProGate());
    Get.put<PromoFunnelAnalytics>(const DebugPromoFunnelAnalytics());

    const args = ResultadoEntity(
      id: 'r1',
      tipo: TipoResultado.simulado,
      realizadoEm: null,
      titulo: Strings.simulado,
      totalPerguntas: 15,
      totalRespostasCorretas: 12,
      result: true,
      percentual: 80,
    );

    await tester.pumpWidget(
      const GetMaterialApp(
        home: ResultadoScreen(args: args),
      ),
    );
    await tester.pump();

    expect(find.text(Strings.resultadoSimuladoFreeCta), findsOneWidget);
    expect(find.byType(HabilitacaoQuizPlusCtaBanner), findsOneWidget);
  });

  testWidgets('Free tema não mostra CTA de simulado', (tester) async {
    Get.put<ProGate>(StubProGate());
    Get.put<PromoFunnelAnalytics>(const DebugPromoFunnelAnalytics());

    const args = ResultadoEntity(
      id: 'r2',
      tipo: TipoResultado.tema,
      realizadoEm: null,
      titulo: 'Legislação',
      totalPerguntas: 15,
      totalRespostasCorretas: 10,
      result: false,
      percentual: 66.67,
    );

    await tester.pumpWidget(
      const GetMaterialApp(
        home: ResultadoScreen(args: args),
      ),
    );
    await tester.pump();

    expect(find.text(Strings.resultadoSimuladoFreeCta), findsNothing);
    expect(find.byType(HabilitacaoQuizPlusCtaBanner), findsNothing);
  });
}
