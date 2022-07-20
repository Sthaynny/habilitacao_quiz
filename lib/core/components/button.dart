import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

EdgeInsetsGeometry get _padding => EdgeInsets.symmetric(
    vertical: AppSpacingStack.nano.value,
    horizontal: AppSpacingStack.nano.value);

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
    Key? key,
    this.onPressed,
    this.buttonStyle,
    this.margin,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final BoxDecoration? buttonStyle;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
      buttonStyle: BoxDecoration(
        color: cor ?? _colorBorderPrimery(onPressed != null),
        borderRadius: BorderRadius.circular(border12Radius),
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
      buttonStyle: BoxDecoration(
        color: _colorButtonOutline(onPressed != null),
        borderRadius: BorderRadius.circular(border12Radius),
        border: Border.all(
          width: 1,
          color: color ?? AppColors.lightGrey,
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
      buttonStyle: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(border12Radius),
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
      buttonStyle: BoxDecoration(
        color: cor ?? _colorBorderSecundary(onPressed != null),
        borderRadius: BorderRadius.circular(border12Radius),
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
