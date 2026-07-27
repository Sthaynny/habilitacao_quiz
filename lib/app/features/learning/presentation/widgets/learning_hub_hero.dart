import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningHubHero extends StatelessWidget {
  const LearningHubHero({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.linear,
        borderRadius: BorderRadius.circular(border12Radius),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.aprenderHubTitulo,
              style: AppFontStyle.headline20Bold.setColor(AppColors.white),
            ),
            SizedBox(height: AppSpacingStack.quarck.value),
            Text(
              Strings.aprenderHubSubtitulo,
              style: AppFontStyle.body14Regular.setColor(
                AppColors.white.withValues(alpha: 0.92),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
