import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';
import 'package:habilitacao_quiz/core/styles/app_font_size.dart';
import 'package:habilitacao_quiz/core/styles/font_weight.dart';

class AppTextStyles {
  static TextStyle notoSansRegular({
    Color? color,
    double? fontSize,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSans(
      color: color ?? AppColors.branco,
      fontSize: fontSize ?? 12,
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
      fontSize: fontSize ?? 12,
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
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w900,
      letterSpacing: letterSpacing,
    );
  }
}

abstract class AppFontStyle {
  ///Retorna o estilo ROBOTO podendo o passar todas as configuraçoes do textstyle convencional
  static TextStyle notoSans({
    Color? color,
    Color? backgroundColor,
    AppFontSize fontSize = AppFontSize.xxxSmall,
    AppFontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) =>
      GoogleFonts.notoSans(
        color: color ?? AppColors.black,
        backgroundColor: backgroundColor,
        fontSize: fontSize.value,
        fontWeight: fontWeight?.value,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );

  static TextStyle get headline32Black => AppFontStyle.notoSans(
        fontSize: AppFontSize.large,
        fontWeight: AppFontWeight.black,
      );

  static TextStyle get headline24Bold => AppFontStyle.notoSans(
        fontSize: AppFontSize.medium,
        fontWeight: AppFontWeight.bold,
      );

  static TextStyle get headline24Regular => AppFontStyle.notoSans(
        fontSize: AppFontSize.medium,
        fontWeight: AppFontWeight.regular,
      );
  static TextStyle get headline20Bold => AppFontStyle.notoSans(
        fontSize: AppFontSize.small,
        fontWeight: AppFontWeight.bold,
      );

  static TextStyle get subtitle16Regular => AppFontStyle.notoSans(
        fontSize: AppFontSize.xSmall,
        fontWeight: AppFontWeight.regular,
      );

  static TextStyle get subtitle14Medium => AppFontStyle.notoSans(
        fontSize: AppFontSize.xxSmall,
        fontWeight: AppFontWeight.medium,
      );

  static TextStyle get body16Bold => AppFontStyle.notoSans(
        fontSize: AppFontSize.xSmall,
        fontWeight: AppFontWeight.bold,
      );

  static TextStyle get body16Regular => AppFontStyle.notoSans(
        fontSize: AppFontSize.xSmall,
        fontWeight: AppFontWeight.regular,
      );

  static TextStyle get body14Regular => AppFontStyle.notoSans(
        fontSize: AppFontSize.xxSmall,
        fontWeight: AppFontWeight.regular,
      );

  static TextStyle get button16Bold => AppFontStyle.notoSans(
        fontSize: AppFontSize.xSmall,
        fontWeight: AppFontWeight.bold,
      );

  static TextStyle get caption12Regular => AppFontStyle.notoSans(
        fontSize: AppFontSize.xxxSmall,
        fontWeight: AppFontWeight.regular,
      );
}

extension TextStyleExt on TextStyle {
  TextStyle setColor(Color? color) => copyWith(color: color);
}
