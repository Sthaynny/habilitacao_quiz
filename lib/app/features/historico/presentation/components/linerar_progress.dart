import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  const LinearProgressIndicatorWidget({Key? key, required this.value})
      : super(key: key);
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
