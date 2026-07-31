import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/components/section_header_a11y.dart';

class HistoricoFiltroChip extends StatelessWidget {
  const HistoricoFiltroChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChipA11y(
      label: label,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
