import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class QuestionarioInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<QuestionarioController>(
      () => QuestionarioController(),
      fenix: true,
    );
  }
}
