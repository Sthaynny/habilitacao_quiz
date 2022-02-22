import 'package:flutter/material.dart';

enum KeysEnum {
  direcaoDefenciva,
  legislacao,
}

extension KeysExt on KeysEnum {
  Key get converteKey => Key(name);
}
