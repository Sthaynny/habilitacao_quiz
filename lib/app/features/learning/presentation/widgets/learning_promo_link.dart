import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// CTA Quiz+ com alvo ≥ 48dp e semantics para leitores de tela.
class LearningPromoLink extends StatelessWidget {
  const LearningPromoLink({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: Strings.plusVerNaLoja,
      hint: Strings.plusBannerHint,
      excludeSemantics: true,
      child: AppButton.link(
        Strings.plusVerNaLoja,
        onPressed: onPressed,
      ),
    );
  }
}
