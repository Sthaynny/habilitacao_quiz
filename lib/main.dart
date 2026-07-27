import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habilitacao_quiz/app/my_app.dart';
import 'package:habilitacao_quiz/global_injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  GlobalInjectionContainer.setInjection();
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  });
}
