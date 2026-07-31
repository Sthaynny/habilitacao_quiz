import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/app/features/onboarding/data/onboarding_datasource.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Bottom sheet F01 — escolha opcional da matéria de foco (1ª sessão).
class OnboardingMateriaSheet extends StatelessWidget {
  const OnboardingMateriaSheet({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final datasource = Get.find<OnboardingDatasource>();
    if (await datasource.materiaOnboardingConcluido()) {
      final foco = await datasource.lerMateriaFoco();
      if (foco != null) {
        Get.find<HomeController>().definirMateriaFoco(
          LearningThemeIdMapper.fromFolderId(foco)?.quizEnum,
        );
      }
      return;
    }
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const OnboardingMateriaSheet(),
    );
  }

  static const _opcoes = <({String themeId, String titulo, QuizEnum quiz})>[
    (
      themeId: 'legislacao',
      titulo: Strings.legislacao,
      quiz: QuizEnum.legislacao,
    ),
    (
      themeId: 'direcao_defensiva',
      titulo: Strings.direcaoDefesiva,
      quiz: QuizEnum.direcaoDefensiva,
    ),
    (
      themeId: 'mecanica_basica',
      titulo: Strings.mecanicaBasica,
      quiz: QuizEnum.mecanicaBasica,
    ),
    (
      themeId: 'primeiros_socorros',
      titulo: Strings.primeirosSocorros,
      quiz: QuizEnum.primeirosSocorros,
    ),
    (
      themeId: 'meio_ambiente',
      titulo: Strings.meioAmbiente,
      quiz: QuizEnum.meioAmbiente,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final datasource = Get.find<OnboardingDatasource>();
    final home = Get.find<HomeController>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacingStack.xxxSmall.value,
          0,
          AppSpacingStack.xxxSmall.value,
          AppSpacingStack.xxxSmall.value,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                Strings.onboardingMateriaTitulo,
                style: AppFontStyle.headline20Bold,
              ),
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              Strings.onboardingMateriaSubtitulo,
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            for (final opcao in _opcoes) ...[
              Semantics(
                button: true,
                label: opcao.titulo,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(opcao.titulo, style: AppFontStyle.body16Medium),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.grey),
                  onTap: () async {
                    await datasource.salvarMateriaFoco(opcao.themeId);
                    home.definirMateriaFoco(opcao.quiz);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
            ],
            SizedBox(height: AppSpacingStack.nano.value),
            AppButton.link(
              Strings.onboardingMateriaPular,
              onPressed: () async {
                await datasource.pularOnboardingMateria();
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
