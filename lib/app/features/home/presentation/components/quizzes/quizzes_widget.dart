import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quiz_card.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class QuizzesWidget extends StatelessWidget {
  const QuizzesWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final QuizzesController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacingStack.xxxSmall.value),
      child: GridView.count(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: [
          QuizCardWidget(
            onTap: () => controller.irParaPagina(QuizEnum.legislacao),
            image: AppImages.legislacao,
            title: Strings.legislacao,
          ),
          QuizCardWidget(
            onTap: () {
              controller.irParaPagina(QuizEnum.direcaoDefensiva);
            },
            image: AppImages.direcaoDefensiva,
            title: Strings.direcaoDefesiva,
          ),
          QuizCardWidget(
            onTap: () {
              controller.irParaPagina(QuizEnum.mecanicaBasica);
            },
            image: AppImages.mecanica,
            title: Strings.mecanicaBasica,
          ),
          QuizCardWidget(
            onTap: () {
              controller.irParaPagina(QuizEnum.primeirosSocorros);
            },
            image: AppImages.primeirosSocorros,
            title: Strings.primeirosSocorros,
          ),
          QuizCardWidget(
            onTap: () {
              controller.irParaPagina(QuizEnum.meioAmbiente);
            },
            image: AppImages.meioAmbiente,
            title: Strings.meioAmbiente,
          ),
          QuizCardWidget(
            onTap: () {
              controller.irParaPagina(QuizEnum.simulado);
            },
            image: AppImages.simulado,
            title: Strings.simulado,
          ),
        ],
      ),
    );
  }
}
