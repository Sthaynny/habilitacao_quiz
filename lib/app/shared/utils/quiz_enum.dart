import 'package:flutter/material.dart';

enum QuizEnum {
  mecanicaBasica,
  primeirosSocorros,
  legislacao,
  direcaoDefensiva,
  meioAmbiente,
  simulado,
}

extension KeysExt on QuizEnum {
  ValueKey get converteKey => ValueKey(name);
}
