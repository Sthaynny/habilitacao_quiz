import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/car_quiz_logo_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class CarQuizWidget extends StatelessWidget {
  const CarQuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacingStack.nano.value,
        horizontal: AppSpacingStack.nano.value,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350,
          maxHeight: 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CarQuizLogoWidget(),
            Padding(
              padding: EdgeInsets.all(AppSpacingStack.nano.value),
              child: Text(Strings.logoApp, style: AppFontStyle.headline20Bold),
            ),
          ],
        ),
      ),
    );
  }
}
