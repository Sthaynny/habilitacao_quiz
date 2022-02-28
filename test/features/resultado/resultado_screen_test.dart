import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/resultado/resultado_args.dart';
import 'package:habilitacao_quiz/app/features/resultado/resultado_screen.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/primary_button_widget.dart';

void main() {
  Widget makeTestable(Widget widget) => GetMaterialApp(
        home: widget,
      );
  testWidgets(
    'Resultado Screen inicializar tela',
    (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(const ResultadoScreen(
        args: ResultadoArgs(
          titulo: 'Tituo',
          totalPerguntas: 10,
          percentual: 70.0,
          result: true,
          totalRespostasCorretas: 7,
        ),
      )));

      final Finder scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      final Finder imageAsset = find.byType(Image);
      expect(imageAsset, findsOneWidget);

      final Finder textSpanFinder = find.byType(Text);
      expect(textSpanFinder, findsWidgets);

      final nextButtonFindder = find.byType(PrimaryButtonWidget);
      expect(nextButtonFindder, findsNWidgets(2));
    },
  );
}
