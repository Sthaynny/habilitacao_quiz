import 'package:flutter/material.dart';

enum KeysEnum {
  direcaoDefenciva,
}

extension KeysExt on KeysEnum {
  Key get converteKey => Key(name);
}
