import 'package:flutter/material.dart';

class AlignedGrid extends StatelessWidget {
  const AlignedGrid({
    super.key,
    required this.children,
    this.spacing = 4,
    this.runSpacing = 4,
  });

  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: runSpacing,
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: children,
      ),
    );
  }
}
