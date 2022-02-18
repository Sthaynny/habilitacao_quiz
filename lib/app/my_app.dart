import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quiz_car/app/features/home/presentation/home_screen.dart';
import 'package:quiz_car/app/features/questionario/presentation/questionario_screen.dart';
import 'package:quiz_car/app/features/resultado/resultado_screen.dart';
import 'package:quiz_car/app/features/routes/routes.dart';
import 'package:quiz_car/app/features/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.init,
      getPages: [
        GetPage(
          name: Routes.init,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: Routes.resultado,
          page: () => ResultadoScreen(
            args: Get.arguments,
          ),
          transition: Transition.fade,
        ),
        GetPage(
          name: Routes.questionario,
          page: () => QuestionarioScreen(
            quizEntity: Get.arguments,
          ),
        ),
        GetPage(
          name: Routes.home,
          page: () => const HomeScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(seconds: 2),
          showCupertinoParallax: false,
        ),
      ],
    );
  }
}
