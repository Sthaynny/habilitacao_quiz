import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// F03 — empty state do histórico com CTA para iniciar estudo.
class HistoricoEmptyState extends StatelessWidget {
  const HistoricoEmptyState({
    super.key,
    required this.onIniciarQuiz,
    this.showBackup = false,
    this.backupSection,
  });

  final VoidCallback onIniciarQuiz;
  final bool showBackup;
  final Widget? backupSection;

  @override
  Widget build(BuildContext context) {
    final exibirPromo = Get.find<ProGate>().exibirPromoPlus;

    return Column(
      children: [
        SizedBox(height: AppSpacingStack.xxLarge.value),
        Semantics(
          header: true,
          child: Text(
            Strings.historico,
            style: AppFontStyle.headline24Bold,
          ),
        ),
        SizedBox(height: AppSpacingStack.small.value),
        ExcludeSemantics(
          child: Icon(
            Icons.insights_outlined,
            size: 64,
            color: AppColors.primary.withValues(alpha: 0.35),
          ),
        ),
        SizedBox(height: AppSpacingStack.xxxSmall.value),
        Semantics(
          label:
              '${Strings.historicoEmptyTitulo}. ${Strings.historicoEmptyCorpo}',
          child: ExcludeSemantics(
            child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacingStack.xxxSmall.value,
            ),
            child: Column(
              children: [
                Text(
                  Strings.historicoEmptyTitulo,
                  style: AppFontStyle.body16Bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacingStack.nano.value),
                Text(
                  Strings.historicoEmptyCorpo,
                  style: AppFontStyle.body14Regular.setColor(AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ),
        ),
        SizedBox(height: AppSpacingStack.xxxSmall.value),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacingStack.xxxSmall.value,
          ),
          child: Semantics(
            button: true,
            label: Strings.historicoEmptyCtaQuiz,
            excludeSemantics: true,
            child: AppButton.primary(
              Strings.historicoEmptyCtaQuiz,
              onPressed: onIniciarQuiz,
            ),
          ),
        ),
        if (showBackup && backupSection != null) ...[
          SizedBox(height: AppSpacingStack.small.value),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacingStack.xxxSmall.value,
            ),
            child: backupSection!,
          ),
        ],
        if (exibirPromo) ...[
          SizedBox(height: AppSpacingStack.xxxSmall.value),
          Semantics(
            button: true,
            label: Strings.historicoEmptyCtaPlus,
            hint: Strings.plusBannerHint,
            excludeSemantics: true,
            child: AppButton.link(
              Strings.historicoEmptyCtaPlus,
              onPressed: () => Get.toNamed(Routes.habilitacaoQuizPlus),
            ),
          ),
        ],
      ],
    );
  }
}
