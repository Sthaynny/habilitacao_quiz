import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/utils/semantics_announce.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Snackbar de limite Free com anúncio acessível e CTA Quiz+.
void showSimuladoLimiteDiarioSnackbar({
  PromoSurface surface = PromoSurface.gateSimuladoDiario,
}) {
  announceForAccessibility(Strings.simuladoLimiteDiario);
  Get.snackbar(
    Strings.atencao,
    Strings.simuladoLimiteDiario,
    snackPosition: SnackPosition.BOTTOM,
    mainButton: TextButton(
      onPressed: () {
        Get.find<PromoFunnelAnalytics>().logClick(
          surface,
          PromoClickTarget.openPlusScreen,
        );
        Get.toNamed(Routes.habilitacaoQuizPlus);
      },
      child: Semantics(
        button: true,
        label: Strings.plusVerNaLoja,
        hint: Strings.plusBannerHint,
        child: Text(Strings.plusVerNaLoja),
      ),
    ),
  );
}
