import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

/// [FilterChip] com alvo de toque ≥ 48dp e semantics para leitores de tela.
class FilterChipA11y extends StatelessWidget {
  const FilterChipA11y({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.semanticHint,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final String? semanticHint;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      hint: semanticHint,
      child: SizedBox(
        height: 48,
        child: FilterChip(
          label: Text(label),
          selected: selected,
          onSelected: (_) => onSelected(),
          showCheckmark: false,
          selectedColor: AppColors.primary.withValues(alpha: 0.15),
          labelStyle: AppFontStyle.body14Regular.copyWith(
            color: selected ? AppColors.primary : AppColors.black,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacingStack.nano.value,
          ),
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
    );
  }
}

/// Título de seção com papel de cabeçalho para TalkBack/VoiceOver.
class SectionHeaderA11y extends StatelessWidget {
  const SectionHeaderA11y({
    super.key,
    required this.title,
    this.subtitle,
    this.style,
  });

  final String title;
  final String? subtitle;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final label = subtitle == null ? title : '$title. $subtitle';

    return Semantics(
      header: true,
      label: label,
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: style ?? AppFontStyle.body16Bold,
            ),
            if (subtitle != null) ...[
              SizedBox(height: AppSpacingStack.quarck.value),
              Text(
                subtitle!,
                style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
