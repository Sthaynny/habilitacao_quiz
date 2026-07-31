import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_markdown_styles.dart';
import 'package:markdown/markdown.dart' as md;

/// Markdown de leitura longa com cabeçalhos anunciáveis para leitores de tela.
class LearningMarkdownBody extends StatelessWidget {
  const LearningMarkdownBody({
    super.key,
    required this.data,
    this.styleSheet,
  });

  final String data;
  final MarkdownStyleSheet? styleSheet;

  static final Map<String, MarkdownElementBuilder> _headingBuilders = {
    for (final tag in const ['h1', 'h2', 'h3'])
      tag: _HeadingSemanticsBuilder(),
  };

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,
      styleSheet: styleSheet ?? LearningMarkdownStyles.sheet(),
      builders: _headingBuilders,
      shrinkWrap: true,
      fitContent: true,
    );
  }
}

class _HeadingSemanticsBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    final label = element.textContent.trim();
    if (label.isEmpty) return null;

    return Semantics(
      header: true,
      label: label,
      child: ExcludeSemantics(
        child: Text(
          label,
          style: preferredStyle,
          softWrap: true,
        ),
      ),
    );
  }
}
