import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/car_quiz_logo_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class CarQuizWidget extends StatelessWidget {
  const CarQuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 350,
          maxHeight: 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CarQuizLogoWidget(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                Strings.logoApp,
                style: AppTextStyles.notoSansExtraBold(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
