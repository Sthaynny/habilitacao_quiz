import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/utils/semantics_announce.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

const _ctaMinSize = Size(48, 48);

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
      style: TextButton.styleFrom(minimumSize: _ctaMinSize),
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

/// Snackbar + CTA quando o Free salva o 11º resultado (FIFO remove o mais antigo).
void showHistoricoLimiteFreeSnackbarIfNeeded(SalvarHistoricoOutcome outcome) {
  if (!outcome.removeuMaisAntigoPorLimiteFree) return;
  showHistoricoLimiteFreeSnackbar();
}

void showHistoricoLimiteFreeSnackbar() {
  announceForAccessibility(Strings.historicoLimiteFreeSnackbar);
  Get.snackbar(
    Strings.historico,
    Strings.historicoLimiteFreeSnackbar,
    snackPosition: SnackPosition.BOTTOM,
    mainButton: TextButton(
      style: TextButton.styleFrom(minimumSize: _ctaMinSize),
      onPressed: () {
        Get.find<PromoFunnelAnalytics>().logClick(
          PromoSurface.gateHistoricoLimite,
          PromoClickTarget.openPlusScreen,
        );
        Get.toNamed(Routes.habilitacaoQuizPlus);
      },
      child: Semantics(
        button: true,
        label: Strings.historicoDesbloquearCompleto,
        hint: Strings.plusBannerHint,
        child: Text(Strings.historicoDesbloquearCompleto),
      ),
    ),
  );
}
