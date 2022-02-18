import 'package:flutter/material.dart';
import 'package:quiz_car/core/styles/app_gradients.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: AppGradients.linear,
      ),
      child: const Center(
        child: Text('data'),
      ),
    );
  }
}
