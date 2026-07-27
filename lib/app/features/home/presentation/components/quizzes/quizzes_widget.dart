import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quiz_card.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class QuizzesWidget extends StatelessWidget {
  const QuizzesWidget({
    super.key,
    required this.controller,
    required this.topPromo,
  });

  final QuizzesController controller;
  final Widget topPromo;

  static const int _crossAxisCount = 2;
  static const double _childAspectRatio = 0.9;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSpacingStack.xxxSmall.value;
    final gridSpacing = AppSpacingStack.nano.value;

    final entries = <({QuizEnum quiz, String image, String title})>[
      (
        quiz: QuizEnum.legislacao,
        image: AppImages.legislacao,
        title: Strings.legislacao,
      ),
      (
        quiz: QuizEnum.direcaoDefensiva,
        image: AppImages.direcaoDefensiva,
        title: Strings.direcaoDefesiva,
      ),
      (
        quiz: QuizEnum.mecanicaBasica,
        image: AppImages.mecanica,
        title: Strings.mecanicaBasica,
      ),
      (
        quiz: QuizEnum.primeirosSocorros,
        image: AppImages.primeirosSocorros,
        title: Strings.primeirosSocorros,
      ),
      (
        quiz: QuizEnum.meioAmbiente,
        image: AppImages.meioAmbiente,
        title: Strings.meioAmbiente,
      ),
      (
        quiz: QuizEnum.simulado,
        image: AppImages.simulado,
        title: Strings.simulado,
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: gridSpacing),
              child: topPromo,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              childAspectRatio: _childAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final entry = entries[index];
                return QuizCardWidget(
                  onTap: () => controller.irParaPagina(entry.quiz),
                  image: entry.image,
                  title: entry.title,
                );
              },
              childCount: entries.length,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: AppSpacingStack.xxxSmall.value),
                AppButton.secundary(
                  Strings.modoProva,
                  onPressed: controller.iniciarModoProva,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
