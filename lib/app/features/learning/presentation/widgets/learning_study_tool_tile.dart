import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningStudyToolTile extends StatelessWidget {
  const LearningStudyToolTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.accentColor = AppColors.primary,
    this.trailingLocked = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;
  final bool trailingLocked;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $subtitle',
      hint: trailingLocked ? Strings.plusBannerHint : null,
      child: ExcludeSemantics(
        child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border12Radius),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacingStack.xxxSmall.value,
                vertical: AppSpacingStack.nano.value,
              ),
              child: Row(
                children: [
                  ExcludeSemantics(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacingStack.nano.value),
                        child: Icon(icon, color: accentColor, size: 24),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacingStack.nano.value),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFontStyle.body16Medium,
                          softWrap: true,
                        ),
                        SizedBox(height: AppSpacingStack.quarck.value),
                        Text(
                          subtitle,
                          style: AppFontStyle.caption12Regular
                              .setColor(AppColors.grey),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  ExcludeSemantics(
                    child: Icon(
                      trailingLocked
                          ? Icons.lock_outline
                          : Icons.chevron_right,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
