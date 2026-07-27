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
    return Semantics(
      button: true,
      label: title,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Container(
          padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
          decoration: BoxDecoration(
            border: const Border.fromBorderSide(
              BorderSide(color: AppColors.border),
            ),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    image,
                    width: 48,
                    height: 48,
                    cacheWidth: _imageCachePx(context, 48),
                    cacheHeight: _imageCachePx(context, 48),
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
              SizedBox(height: AppSpacingStack.nano.value),
              Text(
                title,
                style: AppFontStyle.body16Medium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  static int _imageCachePx(BuildContext context, double logicalSize) {
    return (logicalSize * MediaQuery.devicePixelRatioOf(context)).round();
  }
}
