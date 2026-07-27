import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

abstract final class LearningMarkdownStyles {
  static MarkdownStyleSheet sheet() {
    return MarkdownStyleSheet(
      h1: AppFontStyle.headline20Bold,
      h2: AppFontStyle.body16Bold,
      h3: AppFontStyle.body16Medium,
      p: AppFontStyle.body16Regular,
      listBullet: AppFontStyle.body16Regular,
      strong: AppFontStyle.body16Bold,
      blockSpacing: AppSpacingStack.nano.value,
      listIndent: AppSpacingStack.xxxSmall.value,
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
    );
  }
}
