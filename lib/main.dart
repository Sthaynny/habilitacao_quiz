import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habilitacao_quiz/app/my_app.dart';
import 'package:habilitacao_quiz/global_injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  GlobalInjectionContainer.setInjection();
  runApp(const MyApp());
}
