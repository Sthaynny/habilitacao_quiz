import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/app_bar_questionario.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/quiz/quiz.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/questionario_screen.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/core/components/button.dart';

import '../../../utils/utils.dart';

void main() {
  Widget makeTestable(Widget widget) => GetMaterialApp(
        home: widget,
      );
  testWidgets(
    'Questionario Screen inicializar tela',
    (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(QuestionarioScreen(
        quizEntity: QuizModel.fromMap(tMapQuizModel),
        controller: QuestionarioController(),
      )));

      final Finder appBarQuestionarioWidgetFinder =
          find.byType(AppBarQuestionarioWidget);
      expect(appBarQuestionarioWidgetFinder, findsOneWidget);

      final Finder quizFinder = find.byType(QuizWidget);
      expect(quizFinder, findsOneWidget);

      final nextButtonFindder = find.byType(AppButton);
      expect(nextButtonFindder, findsWidgets);
    },
  );
}
