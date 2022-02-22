import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';

class AppTextStyles {
  static TextStyle notoSansRegular({
    Color? color,
    double? fontSize,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSans(
      color: color ?? AppColors.branco,
      fontSize: fontSize ?? 12.ssp,
      fontWeight: FontWeight.w400,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle notoSansBold({
    Color? color,
    double? fontSize,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSans(
      color: color ?? AppColors.branco,
      fontSize: fontSize ?? 12.ssp,
      fontWeight: FontWeight.w600,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle notoSansExtraBold({
    Color? color,
    double? fontSize,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSans(
      color: color ?? AppColors.branco,
      fontSize: fontSize ?? 12.ssp,
      fontWeight: FontWeight.w900,
      letterSpacing: letterSpacing,
    );
  }
}
