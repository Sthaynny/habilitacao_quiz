import 'package:flutter/material.dart';

enum AppFontWeight {
  ///$font-weight-black
  ///w900
  black(FontWeight.w900),

  ///$font-weight-bold
  ///700
  bold(FontWeight.w700),

  ///$font-weight-Medium
  ///500
  medium(FontWeight.w500),

  ///$font-weight-regular
  ///400
  regular(FontWeight.w400),

  ///$font-weight-light
  ///200
  light(FontWeight.w200);

  final FontWeight value;
  const AppFontWeight(this.value);
}
