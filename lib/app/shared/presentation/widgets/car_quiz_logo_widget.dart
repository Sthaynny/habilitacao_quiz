import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class CarQuizLogoWidget extends StatelessWidget {
  const CarQuizLogoWidget({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    final height = size ?? 70;
    final cacheHeight =
        (height * MediaQuery.devicePixelRatioOf(context)).round();

    return Image.asset(
      AppImages.logo,
      height: height,
      cacheHeight: cacheHeight,
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
    );
  }
}
