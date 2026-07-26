import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningFichasScreen extends StatefulWidget {
  const LearningFichasScreen({super.key});

  @override
  State<LearningFichasScreen> createState() => _LearningFichasScreenState();
}

class _LearningFichasScreenState extends State<LearningFichasScreen> {
  List<LearningFichaEntity> _fichas = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final manifest = await Get.find<GetLearningManifestUsecase>()();
    if (!mounted) return;
    setState(() {
      _fichas = manifest.fichas;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final proGate = Get.find<ProGate>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.aprenderFichas,
          style: AppFontStyle.headline20Bold,
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              itemCount: _fichas.length,
              itemBuilder: (context, index) {
                final ficha = _fichas[index];
                final locked =
                    ficha.proOnly && !proGate.podeFichasProLearning;
                return ListTile(
                  title: Text(ficha.title, style: AppFontStyle.body16Regular),
                  subtitle: locked
                      ? Text(
                          Strings.aprenderFichaPro,
                          style: AppFontStyle.body14Regular
                              .setColor(AppColors.grey),
                        )
                      : null,
                  trailing: locked
                      ? const Icon(Icons.lock_outline)
                      : const Icon(Icons.chevron_right),
                  onTap: () {
                    if (locked) {
                      Get.toNamed(Routes.habilitacaoQuizPlus);
                      return;
                    }
                    Get.toNamed(Routes.aprenderFicha, arguments: ficha.id);
                  },
                );
              },
            ),
    );
  }
}

class LearningFichaScreen extends StatefulWidget {
  const LearningFichaScreen({super.key, required this.fichaId});

  final String fichaId;

  @override
  State<LearningFichaScreen> createState() => _LearningFichaScreenState();
}

class _LearningFichaScreenState extends State<LearningFichaScreen> {
  String? _markdown;
  String _title = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final manifest = await Get.find<GetLearningManifestUsecase>()();
    final ficha = manifest.fichas
        .where((f) => f.id == widget.fichaId)
        .firstOrNull;
    if (ficha == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final body = await Get.find<LoadLearningMarkdownUsecase>()(ficha.path);
    if (!mounted) return;
    setState(() {
      _title = ficha.title;
      _markdown = body;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: AppFontStyle.headline20Bold),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              child: MarkdownBody(data: _markdown ?? ''),
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
