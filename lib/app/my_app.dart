import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/home_screen.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/questionario_screen.dart';
import 'package:habilitacao_quiz/app/features/resultado/presentation/resultado_screen.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/features/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Habilitação Quiz',
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
            controller: Get.find(),
            quizEntity: Get.arguments,
          ),
        ),
        GetPage(
          name: Routes.home,
          page: () => HomeScreen(
            controller: Get.find(),
            quizzesController: Get.find(),
          ),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(seconds: 2),
          showCupertinoParallax: false,
        ),
      ],
    );
  }
}
