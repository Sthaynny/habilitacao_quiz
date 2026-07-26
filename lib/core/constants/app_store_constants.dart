/// URLs e flags da loja para o app **Habilitação Quiz+**.
abstract final class AppStoreConstants {
  static const isProPublished = bool.fromEnvironment(
    'HABILITACAO_QUIZ_PRO_PUBLISHED',
    defaultValue: false,
  );

  static const androidPackagePro = 'br.com.sthaynny.habilitacao_quiz.pro';

  static const playStoreListingUrl =
      'https://play.google.com/store/apps/details?id=$androidPackagePro';

  static const playStoreListingUrlWithUtm =
      '$playStoreListingUrl&utm_source=app_free&utm_medium=cta';

  static const appStoreIosUrl = 'https://apps.apple.com/app/id0000000000';

  static const plusProductName = 'Habilitação Quiz+';
}
