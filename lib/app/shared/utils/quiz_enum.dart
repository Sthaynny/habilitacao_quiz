import 'package:flutter/material.dart';

enum QuizEnum {
  mecanicaBasica,
  primeirosSocorros,
  legislacao,
  direcaoDefensiva,
  meioAmbiente,
  similado,
}

extension KeysExt on QuizEnum {
  Key get converteKey => Key(name);
}
