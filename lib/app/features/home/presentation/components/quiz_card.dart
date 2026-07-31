import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class QuizCardWidget extends StatelessWidget {
  const QuizCardWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.image,
    this.subtitle,
    this.badge,
    this.highlighted = false,
  });

  final String title;
  final String? subtitle;
  final String? badge;
  final bool highlighted;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final semanticsLabel = subtitle == null ? title : '$title. $subtitle';
    final focusLabel =
        highlighted ? '$semanticsLabel. ${Strings.proStudyFocoMateria}' : semanticsLabel;

    return Semantics(
      button: true,
      label: focusLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Container(
          padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                color: highlighted ? AppColors.primary : AppColors.border,
                width: highlighted ? 2 : 1,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
            color: highlighted
                ? AppColors.primary.withValues(alpha: 0.04)
                : AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    image,
                    width: 48,
                    height: 48,
                    cacheWidth: _imageCachePx(context, 48),
                    cacheHeight: _imageCachePx(context, 48),
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                  if (badge != null || highlighted) ...[
                    const Spacer(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacingStack.quarck.value,
                          vertical: 2,
                        ),
                        child: Text(
                          badge ?? Strings.proStudyFocoMateria,
                          style: AppFontStyle.caption12Regular.setColor(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: AppSpacingStack.nano.value),
              Text(
                title,
                style: AppFontStyle.body16Medium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                SizedBox(height: AppSpacingStack.quarck.value),
                Text(
                  subtitle!,
                  style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
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
