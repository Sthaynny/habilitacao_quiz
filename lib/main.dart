import 'package:flutter/material.dart';
import 'package:quiz_car/app/my_app.dart';
import 'package:quiz_car/global_injection_container.dart';

void main() {
  GlobalInjectionContainer.setInjection();
  runApp(const MyApp());
}
