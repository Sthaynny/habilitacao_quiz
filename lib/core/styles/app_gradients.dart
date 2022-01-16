import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_car/core/styles/app_colors.dart';

abstract class AppGradients {
  static const linear = LinearGradient(colors: [
    AppColors.azulClaro,
    AppColors.verde,
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}
