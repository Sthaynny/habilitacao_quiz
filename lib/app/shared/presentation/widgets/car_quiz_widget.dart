import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/car_quiz_logo_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class CarQuizWidget extends StatelessWidget {
  const CarQuizWidget({super.key});

  /// [AppSpacingStack.nano] (8px).
  static const _padding = EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: Strings.logoApp.replaceAll('\n', ' '),
      header: true,
      child: ExcludeSemantics(
        child: Padding(
          padding: _padding,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 350,
              maxHeight: 100,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CarQuizLogoWidget(),
                Padding(
                  padding: _padding,
                  child: _CarQuizTitle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CarQuizTitle extends StatelessWidget {
  const _CarQuizTitle();

  @override
  Widget build(BuildContext context) {
    return Text(Strings.logoApp, style: AppFontStyle.headline20Bold);
  }
}
