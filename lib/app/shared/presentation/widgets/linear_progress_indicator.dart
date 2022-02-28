import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  const LinearProgressIndicatorWidget({Key? key, required this.value})
      : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: AppColors.cinzaSuperClaro,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.verde),
    );
  }
}
