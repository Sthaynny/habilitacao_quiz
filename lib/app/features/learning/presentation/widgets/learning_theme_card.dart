import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class LearningThemeCard extends StatelessWidget {
  const LearningThemeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String imageAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $subtitle',
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Padding(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imageAsset,
                    width: 48,
                    height: 48,
                    cacheWidth: _imageCachePx(context, 48),
                    cacheHeight: _imageCachePx(context, 48),
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                  SizedBox(height: AppSpacingStack.nano.value),
                  Text(
                    title,
                    style: AppFontStyle.body16Medium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacingStack.quarck.value),
                  Text(
                    subtitle,
                    style: AppFontStyle.caption12Regular
                        .setColor(AppColors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
