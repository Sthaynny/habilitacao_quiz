import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class QuizCardWidget extends StatelessWidget {
  const QuizCardWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.image,
  });
  final String title;
  final String image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppSpacingStack.nano.value,
            horizontal: AppSpacingStack.xxxSmall.value),
        margin: EdgeInsets.all(AppSpacingStack.quarck.value),
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(
            BorderSide(
              color: AppColors.border,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacingStack.xxxSmall.value),
              child: Image.asset(
                image,
                width: 48,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              margin: EdgeInsets.only(bottom: AppSpacingStack.nano.value),
              child: Text(
                title,
                style: AppFontStyle.body16Medium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
