import 'package:flutter/material.dart';

class AlignedGrid extends StatefulWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const AlignedGrid({
    Key? key,
    required this.children,
    this.spacing = 4,
    this.runSpacing = 4,
  }) : super(key: key);

  @override
  State<AlignedGrid> createState() => _AlignedGridState();
}

class _AlignedGridState extends State<AlignedGrid> {
  late final int listSize;

  @override
  void didChangeDependencies() {
    listSize = widget.children.length;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: widget.runSpacing,
        spacing: widget.spacing,
        alignment: WrapAlignment.center,
        children: List.generate(listSize, (index) {
          return widget.children[index];
        }),
      ),
    );
  }
}
