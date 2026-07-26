import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Rodapé fixo na lista de histórico (Free): copy dos últimos 10 + CTA Quiz+.
class HistoricoFreeLimiteFooter extends StatelessWidget {
  const HistoricoFreeLimiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsPro) {
      return const SizedBox.shrink();
    }
    final proGate = Get.find<ProGate>();
    if (!proGate.exibirPromoPlus) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacingStack.xxxSmall.value,
        bottom: AppSpacingStack.small.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              Strings.historicoFreeUltimosDez,
              style: AppFontStyle.body16Medium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          Text(
            Strings.historicoPlusRodape,
            style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacingStack.xxxSmall.value),
          AppButton.primary(
            Strings.historicoDesbloquearCompleto,
            onPressed: () {
              Get.find<PromoFunnelAnalytics>().logClick(
                PromoSurface.historicoFooter,
                PromoClickTarget.openPlusScreen,
              );
              Get.toNamed(Routes.habilitacaoQuizPlus);
            },
          ),
        ],
      ),
    );
  }
}
