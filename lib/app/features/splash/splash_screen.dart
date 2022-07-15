import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(
            child: Image.asset(
          AppImages.splash,
        )),
      ),
    );
  }
}
