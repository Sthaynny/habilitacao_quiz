import 'package:get/get.dart';
import 'package:quiz_car/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:quiz_car/core/i_injection_conetiner.dart';

class QuestionarioInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<QuestionarioController>(
      () => QuestionarioController(),
    );
  }
}
