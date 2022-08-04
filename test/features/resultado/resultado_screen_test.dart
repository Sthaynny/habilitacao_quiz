import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/presentation/resultado_screen.dart';
import 'package:habilitacao_quiz/core/components/button.dart';

void main() {
  Widget makeTestable(Widget widget) => GetMaterialApp(
        home: widget,
      );
  testWidgets(
    'Resultado Screen inicializar tela',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestable(
          const ResultadoScreen(
            args: ResultadoEntity(
              titulo: 'Tituo',
              totalPerguntas: 10,
              percentual: 70.0,
              result: true,
              totalRespostasCorretas: 7,
            ),
          ),
        ),
      );

      final Finder scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      final Finder imageAsset = find.byType(Image);
      expect(imageAsset, findsOneWidget);

      final Finder textSpanFinder = find.byType(Text);
      expect(textSpanFinder, findsWidgets);

      final nextButtonFindder = find.byType(AppButton);
      expect(nextButtonFindder, findsNWidgets(2));
    },
  );
}
