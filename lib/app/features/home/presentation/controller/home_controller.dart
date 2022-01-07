import 'package:get/get.dart';
import 'package:quiz_car/app/features/questionario/presentation/questionario_screen.dart';
import 'package:quiz_car/app/features/shared/utils/quiz_enum.dart';

enum HomeState {
  carregando,
  erro,
  carregado,
}

class HomeController {
  


  void irParaPagina(QuizEnum quiz) {
    switch (quiz) {
      case QuizEnum.direcaoDefensiva:
        Get.to(
          const QuestionarioScreen(),
          transition: Transition.fade,
        );
        break;
      default:
    }
  }
}
