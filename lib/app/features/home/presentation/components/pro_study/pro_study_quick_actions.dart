import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Atalhos de estudo Pro na aba Quizzes (offline, sem custo).
class ProStudyQuickActions extends StatelessWidget {
  const ProStudyQuickActions({super.key, required this.controller});

  final QuizzesController controller;

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacingStack.nano.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.proStudyAcessoRapido,
          style: AppFontStyle.body16Bold,
        ),
        SizedBox(height: spacing),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - spacing) / 2;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: _ProStudyActionCard(
                    label: Strings.modoProva,
                    subtitle: Strings.proStudyModoProvaSubtitulo,
                    icon: Icons.timer_outlined,
                    accent: AppColors.primary,
                    onTap: controller.iniciarModoProva,
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ProStudyActionCard(
                    label: Strings.simulado,
                    subtitle: Strings.proStudySimuladoSubtitulo,
                    icon: Icons.assignment_outlined,
                    accent: AppColors.blue,
                    onTap: () => controller.irParaPagina(QuizEnum.simulado),
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ProStudyActionCard(
                    label: Strings.revisarErrosUltimoTeste,
                    subtitle: Strings.revisaoEspacadaDescricao,
                    icon: Icons.replay_outlined,
                    accent: AppColors.purple,
                    onTap: () => Get.toNamed(Routes.aprenderRevisao),
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: _ProStudyActionCard(
                    label: Strings.aprenderMapa,
                    subtitle: Strings.aprenderMapaSubtitulo,
                    icon: Icons.insights_outlined,
                    accent: AppColors.darkGreen,
                    onTap: () => Get.toNamed(Routes.aprenderMapa),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ProStudyActionCard extends StatelessWidget {
  const _ProStudyActionCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label. $subtitle',
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border12Radius),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 88),
            child: Padding(
              padding: EdgeInsets.all(AppSpacingStack.nano.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacingStack.quarck.value),
                      child: Icon(icon, color: accent, size: 22),
                    ),
                  ),
                  SizedBox(height: AppSpacingStack.quarck.value),
                  Text(
                    label,
                    style: AppFontStyle.body14Bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
