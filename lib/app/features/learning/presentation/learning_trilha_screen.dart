import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/controller/learning_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_promo_link.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningTrilhaScreen extends StatefulWidget {
  const LearningTrilhaScreen({super.key});

  @override
  State<LearningTrilhaScreen> createState() => _LearningTrilhaScreenState();
}

class _LearningTrilhaScreenState extends State<LearningTrilhaScreen> {
  LearningTrilhaEntity? _basica;
  LearningTrilhaEntity? _completa;
  Set<String> _progressoBasica = {};
  Set<String> _progressoCompleta = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final controller = Get.find<LearningController>();
    final basica = await controller.loadTrilhaBasica();
    final progressoBasica =
        await controller.loadTrilhaProgresso(basica.id);
    LearningTrilhaEntity? completa;
    Set<String> progressoCompleta = {};
    if (controller.proGate.podeTrilhaCompletaLearning) {
      completa = await controller.loadTrilhaCompleta();
      progressoCompleta =
          await controller.loadTrilhaProgresso(completa.id);
    }
    if (!mounted) return;
    setState(() {
      _basica = basica;
      _completa = completa;
      _progressoBasica = progressoBasica;
      _progressoCompleta = progressoCompleta;
      _loading = false;
    });
  }

  Future<void> _onStepTap(
    LearningTrilhaStepEntity step,
    LearningTrilhaEntity trilha,
    Set<String> progresso,
  ) async {
    await Get.find<SalvarPassoTrilhaUsecase>()(
      trilhaId: trilha.id,
      stepId: step.id,
    );
    if (!mounted) return;
    setState(() => progresso.add(step.id));

    switch (step.kind) {
      case LearningTrilhaStepKind.readResumo:
      case LearningTrilhaStepKind.readArtigo:
        if (step.themeId != null) {
          Get.toNamed(Routes.aprenderTema, arguments: step.themeId);
        }
        break;
      case LearningTrilhaStepKind.quiz:
        final theme = LearningThemeIdMapper.fromFolderId(step.themeId);
        if (theme != null) {
          await Get.find<QuizzesController>().irParaPagina(theme.quizEnum);
        }
        break;
      case LearningTrilhaStepKind.ficha:
        if (step.fichaId != null) {
          Get.toNamed(Routes.aprenderFicha, arguments: step.fichaId);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final proGate = Get.find<ProGate>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.aprenderTrilha,
          style: AppFontStyle.headline20Bold,
        ),
      ),
      body: _loading
          ? Semantics(
              label: 'Carregando trilha de estudos',
              child: const Center(child: CircularProgressIndicator()),
            )
          : ListView(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              children: [
                if (_basica != null)
                  _TrilhaSection(
                    trilha: _basica!,
                    progresso: _progressoBasica,
                    onStepTap: (s) => _onStepTap(s, _basica!, _progressoBasica),
                  ),
                SizedBox(height: AppSpacingStack.xxxSmall.value),
                if (proGate.podeTrilhaCompletaLearning && _completa != null)
                  _TrilhaSection(
                    trilha: _completa!,
                    progresso: _progressoCompleta,
                    onStepTap: (s) =>
                        _onStepTap(s, _completa!, _progressoCompleta),
                  )
                else
                  Semantics(
                    container: true,
                    label: Strings.aprenderTrilhaCompletaPreview,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(border12Radius),
                        border: const Border.fromBorderSide(
                          BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExcludeSemantics(
                              child: Text(
                                Strings.aprenderTrilhaCompletaPreview,
                                style: AppFontStyle.body14Regular
                                    .setColor(AppColors.grey),
                              ),
                            ),
                            SizedBox(height: AppSpacingStack.nano.value),
                            LearningPromoLink(
                              onPressed: () =>
                                  Get.toNamed(Routes.habilitacaoQuizPlus),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _TrilhaSection extends StatelessWidget {
  const _TrilhaSection({
    required this.trilha,
    required this.progresso,
    required this.onStepTap,
  });

  final LearningTrilhaEntity trilha;
  final Set<String> progresso;
  final ValueChanged<LearningTrilhaStepEntity> onStepTap;

  @override
  Widget build(BuildContext context) {
    final total = trilha.steps.length;
    final doneCount =
        trilha.steps.where((s) => progresso.contains(s.id)).length;

    return Semantics(
      container: true,
      label: '${trilha.title}. $doneCount de $total passos',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(border12Radius),
          border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExcludeSemantics(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(trilha.title, style: AppFontStyle.body16Bold),
                    SizedBox(height: AppSpacingStack.quarck.value),
                    Text(
                      '$doneCount de $total passos',
                      style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
                    ),
                    SizedBox(height: AppSpacingStack.nano.value),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: total == 0 ? 0 : doneCount / total,
                        minHeight: 6,
                        backgroundColor: AppColors.border,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: AppSpacingStack.nano.value),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: trilha.steps.length,
              separatorBuilder: (_, _) =>
                  SizedBox(height: AppSpacingStack.quarck.value),
              itemBuilder: (context, index) {
                final step = trilha.steps[index];
                final done = progresso.contains(step.id);
                final stepLabel =
                    done ? 'Concluído: ${step.title}' : step.title;
                return Semantics(
                  button: true,
                  label: stepLabel,
                  excludeSemantics: true,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onStepTap(step),
                      borderRadius: BorderRadius.circular(8),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacingStack.nano.value,
                          ),
                          child: Row(
                            children: [
                              ExcludeSemantics(
                                child: Icon(
                                  done
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color:
                                      done ? AppColors.primary : AppColors.grey,
                                ),
                              ),
                              SizedBox(width: AppSpacingStack.nano.value),
                              Expanded(
                                child: Text(
                                  step.title,
                                  style: AppFontStyle.body16Regular,
                                  softWrap: true,
                                ),
                              ),
                              const ExcludeSemantics(
                                child: Icon(
                                  Icons.chevron_right,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
