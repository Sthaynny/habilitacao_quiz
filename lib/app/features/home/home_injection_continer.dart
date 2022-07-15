import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/legislacao_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/meio_ambiente_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/primeiros_socorros_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/simulado_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class HomeInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut(
      () => DirecaoDefesivaQuizUsercase(Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => LegislacaoQuizUsercase(Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => MeioAmbienteQuizUsercase(Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => PrimeirosSocorrosQuizUsercase(Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => MecanicaBasicaQuizUsercase(Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => SimuladoQuizUsercase(Get.find()),
      fenix: true,
    );

    Get.lazyPut<QuizzesController>(
      () => QuizzesController(
        direcaoDefesivaQuizUsercase: Get.find(),
        legislacaoQuizUsercase: Get.find(),
        meioAmbienteQuizUsercase: Get.find(),
        primeirosSocorrosQuizUsercase: Get.find(),
        mecanicaBasicaQuizUsercase: Get.find(),
        simuladoQuizUsercase: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}
