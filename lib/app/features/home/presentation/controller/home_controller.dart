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
    homeState = Rx<HomeState>(HomeState.init);
    _direcaoDefesivaQuizUsercase = direcaoDefesivaQuizUsercase;
    _quizEntity = Rx<QuizEntity?>(null);
  }
  late Rx<HomeState> homeState;
  late final DirecaoDefesivaQuizUsercase _direcaoDefesivaQuizUsercase;
  late Rx<QuizEntity?> _quizEntity;

  Future<void> irParaPagina(QuizEnum quiz) async {
    switch (quiz) {
      case QuizEnum.direcaoDefensiva:
        await getQuiz(quiz);
        if (_quizEntity.value != null) {
          Get.to(
            QuestionarioScreen(
              quizEntity: _quizEntity.value!.copyWith(
                perguntas: _quizEntity.value!.perguntas.sublist(0, 30),
              ),
            ),
            transition: Transition.fade,
          );
        }
        break;
      default:
    }
  }

  Future<void> getQuiz(QuizEnum quiz) async {
    homeState.value = HomeState.carregando;
    switch (quiz) {
      case QuizEnum.direcaoDefensiva:
        final result = await _direcaoDefesivaQuizUsercase();
        result.fold(
          (_) {
            homeState.value = HomeState.erro;
          },
          (quiz) {
            homeState.value = HomeState.carregado;
            _quizEntity.value = quiz;
          },
        );
        break;
      default:
    }
  }
}
