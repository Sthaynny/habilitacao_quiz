import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/legislacao_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/meio_ambiente_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/primeiros_socorros_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/presentation/controller/home_controller.dart';
import 'package:quiz_car/core/i_injection_conetiner.dart';

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

    Get.lazyPut<HomeController>(
      () => HomeController(
        direcaoDefesivaQuizUsercase: Get.find(),
        legislacaoQuizUsercase: Get.find(),
      ),
      fenix: true,
    );
  }
}
