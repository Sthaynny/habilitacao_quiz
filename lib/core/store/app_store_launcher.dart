import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/constants/app_store_constants.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:habilitacao_quiz/core/utils/url_launcher_helper.dart';

/// Abre a ficha do **+** na loja quando publicado; caso contrário avisa o usuário.
Future<void> openHabilitacaoQuizPlusStore({
  bool useUtm = false,
  PromoSurface surface = PromoSurface.plusScreen,
}) async {
  Get.find<PromoFunnelAnalytics>().logClick(
    surface,
    PromoClickTarget.openStore,
  );

  if (!AppStoreConstants.isProPublished) {
    Get.snackbar(
      Strings.atencao,
      Strings.plusEmBreve,
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }

  final url = useUtm
      ? AppStoreConstants.playStoreListingUrlWithUtm
      : AppStoreConstants.playStoreListingUrl;

  final opened = await openExternalUrl(url);
  if (!opened) {
    Get.snackbar(
      Strings.erroPadrao,
      Strings.plusLojaIndisponivel,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

void navigateToHabilitacaoQuizPlusScreen() {
  Get.toNamed(Routes.habilitacaoQuizPlus);
}
