import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/presentation/controller/home_controller.dart';
import 'package:quiz_car/core/i_injection_conetiner.dart';

class HomeInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut(() => DirecaoDefesivaQuizUsercase(Get.find()));
    Get.lazyPut<HomeController>(
      () => HomeController(
        direcaoDefesivaQuizUsercase: Get.find(),
      ),
    );
  }
}
