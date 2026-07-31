import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

final EdgeInsetsGeometry _padding = EdgeInsets.symmetric(
  vertical: AppSpacingStack.nano.value,
  horizontal: AppSpacingStack.nano.value,
);

final BorderRadius _buttonBorderRadius = BorderRadius.circular(border12Radius);

Color? _colorBorderPrimery(bool isAble) =>
    isAble ? AppColors.primary : AppColors.lightGrey;

Color? _colorTextPrimery(bool isAble) =>
    isAble ? AppColors.white : AppColors.grey;

Color? _colorBorderSecundary(bool isAble) =>
    isAble ? AppColors.secondary : AppColors.lightGrey;

Color? _colorTextSecundary(bool isAble) =>
    isAble ? AppColors.white : AppColors.grey;

Color? _colorButtonOutline(bool isAble) =>
    isAble ? AppColors.white : AppColors.lightGrey;

class AppButton extends StatelessWidget {
  const AppButton({
    required this.child,
    super.key,
    this.onPressed,
    this.buttonStyle,
    this.margin,
    this.semanticLabel,
  });
  final VoidCallback? onPressed;
  final Widget child;
  final BoxDecoration? buttonStyle;
  final EdgeInsetsGeometry? margin;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final button = Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        pressedOpacity: 0.7,
        child: Container(
          decoration: buttonStyle,
          child: child,
        ),
      ),
    );

    final label = semanticLabel;
    if (label == null) {
      return button;
    }

    return Semantics(
      button: true,
      label: label,
      enabled: onPressed != null,
      child: button,
    );
  }

  factory AppButton.primary(
    String title, {
    TextStyle? style,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? margin,
    bool expanded = false,
    Color? cor,
  }) {
    return AppButton(
      onPressed: onPressed,
      margin: margin,
      semanticLabel: title,
      buttonStyle: BoxDecoration(
        color: cor ?? _colorBorderPrimery(onPressed != null),
        borderRadius: _buttonBorderRadius,
      ),
      child: Container(
        width: expanded ? double.maxFinite : null,
        alignment: Alignment.center,
        height: 48,
        padding: _padding,
        child: Text(
          title.capitalFirstLetter,
          textAlign: TextAlign.center,
          style: (style ?? AppFontStyle.body16Bold).copyWith(
            color: _colorTextPrimery(onPressed != null),
          ),
        ),
      ),
    );
  }

  factory AppButton.primaryOutline(
    String title, {
    TextStyle? style,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? margin,
    bool expanded = false,
    Color? color,
  }) {
    return AppButton(
      onPressed: onPressed,
      margin: margin,
      semanticLabel: title,
      buttonStyle: BoxDecoration(
        color: _colorButtonOutline(onPressed != null),
        borderRadius: _buttonBorderRadius,
        border: Border.all(
          width: 1,
          color: color ?? AppColors.lightGrey,
        ),
      ),
      child: Container(
        width: expanded ? double.maxFinite : null,
        alignment: Alignment.center,
        height: 48,
        child: Text(
          title.capitalFirstLetter,
          textAlign: TextAlign.center,
          style: (style ?? AppFontStyle.body16Bold)
              .copyWith(color: color ?? AppColors.lightGrey),
        ),
      ),
    );
  }
  factory AppButton.link(
    String title, {
    TextStyle? style,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? margin,
    bool expanded = false,
    Color? color,
  }) {
    return AppButton(
      onPressed: onPressed,
      margin: margin,
      semanticLabel: title,
      buttonStyle: BoxDecoration(
        color: Colors.transparent,
        borderRadius: _buttonBorderRadius,
      ),
      child: Container(
        width: expanded ? double.maxFinite : null,
        alignment: Alignment.center,
        height: 48,
        child: Text(
          title.capitalFirstLetter,
          textAlign: TextAlign.center,
          style: (style ?? AppFontStyle.body16Bold)
              .copyWith(color: color ?? AppColors.grey),
        ),
      ),
    );
  }

  factory AppButton.secundary(
    String title, {
    TextStyle? style,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? margin,
    bool expanded = false,
    Color? cor,
  }) {
    return AppButton(
      onPressed: onPressed,
      margin: margin,
      semanticLabel: title,
      buttonStyle: BoxDecoration(
        color: cor ?? _colorBorderSecundary(onPressed != null),
        borderRadius: _buttonBorderRadius,
      ),
      child: Container(
        width: expanded ? double.maxFinite : null,
        alignment: Alignment.center,
        height: 48,
        padding: _padding,
        child: Text(
          title.capitalFirstLetter,
          textAlign: TextAlign.center,
          style: (style ?? AppFontStyle.body16Bold).copyWith(
            color: _colorTextSecundary(onPressed != null),
          ),
        ),
      ),
    );
  }
}

extension _StringExt on String {
  String get capitalFirstLetter {
    final string = this;
    return string[0].toUpperCase() + string.substring(1);
  }
}
