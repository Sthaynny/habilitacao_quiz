///DSSpacingStack é responsavel para o mapeamento dos tamanhos para inserção dos espaçamentos em pilha de acordo
///com a definição do [DS](https://www.figma.com/file/aJgNRR363n9ptJ2gky9Mvl/DS---Est%C3%BAdio-Banese?node-id=6%3A101). Para usar:
///
///Example:
///```dart
/// Padding(padding: EdgeInsets.onl(DSSpacingStack.quarck.apply),),
///```
///
enum AppSpacingStack {
  ///$spacing-stack-quarck
  ///4px
  quarck(4),

  ///$spacing-stack-nano
  ///8px
  nano(8),

  ///$spacing-stack-xxxsmall
  ///16px
  xxxSmall(16),

  ///$spacing-stack-xxxsmall
  ///24px
  xxSmall(24),

  ///$spacing-stack-xsmall
  ///32px
  xSmall(32),

  ///$spacing-stack-small
  ///40px
  small(40),

  ///$spacing-stack-medium
  ///48px
  medium(48),

  ///$spacing-stack-large
  ///66px
  large(64),

  ///$spacing-stack-xlarge
  ///72px
  xLarge(72),

  ///$spacing-stack-xxlarge
  ///80px
  xxLarge(80),

  ///$spacing-stack-xxxlarge
  ///120px
  xxxLarge(120),

  ///$spacing-stack-hoge
  ///160px
  hoge(160),

  ///$spacing-stack-giant
  ///200px
  giant(200);

  ///Será o valor do esçamento em `double`
  final double value;

  const AppSpacingStack(this.value);
}
