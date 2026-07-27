import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_markdown_styles.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_section_card.dart';
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
  bool _missingContent = false;

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
      if (mounted) {
        setState(() {
          _loading = false;
          _missingContent = true;
        });
      }
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
      _missingContent = resumo.trim().isEmpty && artigo.trim().isEmpty;
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
    final markdownStyle = LearningMarkdownStyles.sheet();

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppFontStyle.headline20Bold),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _missingContent
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
                    child: Text(
                      Strings.aprenderConteudoIndisponivel,
                      style: AppFontStyle.body16Regular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          AppSpacingStack.xxxSmall.value,
                          AppSpacingStack.xxxSmall.value,
                          AppSpacingStack.xxxSmall.value,
                          AppSpacingStack.nano.value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LearningSectionCard(
                              overline: Strings.aprenderResumo,
                              child: MarkdownBody(
                                data: _resumo ?? '',
                                styleSheet: markdownStyle,
                              ),
                            ),
                            SizedBox(height: AppSpacingStack.xxxSmall.value),
                            LearningSectionCard(
                              overline: Strings.aprenderArtigo,
                              child: MarkdownBody(
                                data: _artigo ?? '',
                                styleSheet: markdownStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        border: Border(
                          top: BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.all(
                            AppSpacingStack.xxxSmall.value,
                          ),
                          child: AppButton.primary(
                            Strings.aprenderPraticarTema,
                            onPressed: _praticarTema,
                          ),
                        ),
                      ),
                    ),
                  ],
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
