import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class CarQuizLogoWidget extends StatelessWidget {
  const CarQuizLogoWidget({Key? key, this.size}) : super(key: key);
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      width: size ?? 70.w,
    );
  }
}
