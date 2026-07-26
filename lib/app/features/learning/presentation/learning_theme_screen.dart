import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningThemeScreen extends StatefulWidget {
  const LearningThemeScreen({super.key, required this.themeId});

  final String themeId;

  @override
  State<LearningThemeScreen> createState() => _LearningThemeScreenState();
}

class _LearningThemeScreenState extends State<LearningThemeScreen> {
  String? _resumo;
  String? _artigo;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final manifest = await Get.find<GetLearningManifestUsecase>()();
    final content = manifest.themes
        .where((t) => t.id == widget.themeId)
        .firstOrNull;
    if (content == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final markdown = Get.find<LoadLearningMarkdownUsecase>();
    final resumo = await markdown(content.resumoPath);
    final artigo = await markdown(content.artigoPath);
    if (!mounted) return;
    setState(() {
      _resumo = resumo;
      _artigo = artigo;
      _loading = false;
    });
  }

  Future<void> _praticarTema() async {
    final theme = LearningThemeIdMapper.fromFolderId(widget.themeId);
    if (theme == null) return;
    await Get.find<QuizzesController>().irParaPagina(theme.quizEnum);
  }

  @override
  Widget build(BuildContext context) {
    final title =
        LearningThemeIdMapper.fromFolderId(widget.themeId)?.displayTitle ??
            widget.themeId;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppFontStyle.headline20Bold),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Strings.aprenderResumo,
                    style: AppFontStyle.body16Bold,
                  ),
                  MarkdownBody(data: _resumo ?? ''),
                  SizedBox(height: AppSpacingStack.xxxSmall.value),
                  Text(
                    Strings.aprenderArtigo,
                    style: AppFontStyle.body16Bold,
                  ),
                  MarkdownBody(data: _artigo ?? ''),
                  SizedBox(height: AppSpacingStack.xxxSmall.value),
                  AppButton.primary(
                    Strings.aprenderPraticarTema,
                    onPressed: _praticarTema,
                  ),
                ],
              ),
            ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    return iterator.current;
  }
}
