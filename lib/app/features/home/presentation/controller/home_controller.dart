import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:quiz_car/app/features/questionario/presentation/questionario_screen.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/utils/quiz_enum.dart';

enum HomeState {
  init,
  carregando,
  erro,
  carregado,
}

class HomeController extends GetxController {
  HomeController(
      {required DirecaoDefesivaQuizUsercase direcaoDefesivaQuizUsercase}) {
    homeState = HomeState.init;
    _direcaoDefesivaQuizUsercase = direcaoDefesivaQuizUsercase;
  }
  late HomeState homeState;
  late final DirecaoDefesivaQuizUsercase _direcaoDefesivaQuizUsercase;
  QuizEntity? _quizEntity;

  Future<void> irParaPagina(QuizEnum quiz) async {
    switch (quiz) {
      case QuizEnum.direcaoDefensiva:
        await getQuiz(quiz);
        if (_quizEntity != null) {
          Get.to(
            QuestionarioScreen(quizEntity: _quizEntity!),
            transition: Transition.fade,
          );
        }
        break;
      default:
    }
  }

  Future<void> getQuiz(QuizEnum quiz) async {
    homeState = HomeState.carregando;
    switch (quiz) {
      case QuizEnum.direcaoDefensiva:
        final result = await _direcaoDefesivaQuizUsercase();
        result.fold(
          (_) {
            homeState = HomeState.erro;
          },
          (quiz) {
            homeState = HomeState.carregado;
            _quizEntity = quiz;
          },
        );
        break;
      default:
    }
  }
}
