/// Edição do app definida em compile-time (`--dart-define=HABILITACAO_QUIZ_PRO=true`).
abstract final class AppEditionNames {
  static const free = 'Habilitação Quiz';
  static const pro = 'Habilitação Quiz+';
}

const bool kIsPro = bool.fromEnvironment(
  'HABILITACAO_QUIZ_PRO',
  defaultValue: false,
);

String get kAppDisplayName => kIsPro ? AppEditionNames.pro : AppEditionNames.free;
