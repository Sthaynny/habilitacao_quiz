import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/car_quiz_logo_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> opacity;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    opacity = Tween<double>(begin: 0, end: -1000.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            controller.reverse();
          });
        }
        if (status == AnimationStatus.dismissed) {
          Get.offNamed(Routes.home);
        }
      });
    controller.forward();
    super.initState();
  }

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
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: FadeTransition(
              opacity: controller,
              child: Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: CarQuizLogoWidget(
                  size: 100.w,
                ),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: controller,
              child: Lottie.asset(
                AppAnimation.carSplash,
                width: double.maxFinite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
