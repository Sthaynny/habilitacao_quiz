import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';

abstract class AppGradients {
  static const linear = LinearGradient(colors: [
    AppColors.blue,
    AppColors.purple,
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}
