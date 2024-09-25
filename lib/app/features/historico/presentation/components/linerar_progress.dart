import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  const LinearProgressIndicatorWidget({super.key, required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: AppColors.secondary,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.lightGrey),
    );
  }
}
