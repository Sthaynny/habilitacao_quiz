import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Banner compacto no topo da aba Quizzes (somente Pro).
class ProStudyHero extends StatelessWidget {
  const ProStudyHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      header: true,
      label:
          '${Strings.proStudyHubTitulo}. ${Strings.proStudyHubSubtitulo}',
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.linear,
            borderRadius: BorderRadius.circular(border12Radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacingStack.nano.value),
                    child: const Icon(
                      Icons.school_outlined,
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(width: AppSpacingStack.nano.value),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.proStudyHubTitulo,
                        style:
                            AppFontStyle.body16Bold.setColor(AppColors.white),
                      ),
                      SizedBox(height: AppSpacingStack.quarck.value),
                      Text(
                        Strings.proStudyHubSubtitulo,
                        style: AppFontStyle.caption12Regular.setColor(
                          AppColors.white.withValues(alpha: 0.92),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
