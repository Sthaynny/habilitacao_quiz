import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/my_app.dart';
import 'package:habilitacao_quiz/global_injection_container.dart';

void main() {
  GlobalInjectionContainer.setInjection();
  runApp(const MyApp());
}
