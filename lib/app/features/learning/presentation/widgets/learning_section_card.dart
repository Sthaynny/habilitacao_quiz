import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class LearningSectionCard extends StatelessWidget {
  const LearningSectionCard({
    super.key,
    required this.overline,
    required this.child,
  });

  final String overline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(border12Radius),
        border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                overline,
                style: AppFontStyle.subtitle14Medium
                    .setColor(AppColors.primary),
              ),
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            child,
          ],
        ),
      ),
    );
  }
}
