import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/legislacao_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/meio_ambiente_quiz_usercase.dart';
import 'package:quiz_car/app/features/home/domain/usecases/primeiros_socorros_quiz_usercase.dart';
import 'package:quiz_car/app/features/questionario/presentation/questionario_screen.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/utils/quiz_enum.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

enum HomeState {
  init,
  carregando,
  erro,
  carregado,
}

class HomeController extends GetxController {
  HomeController(
      {required DirecaoDefesivaQuizUsercase direcaoDefesivaQuizUsercase,
      required LegislacaoQuizUsercase legislacaoQuizUsercase,
      required MeioAmbienteQuizUsercase meioAmbienteQuizUsercase,
      required PrimeirosSocorrosQuizUsercase primeirosSocorrosQuizUsercase,
      required MecanicaBasicaQuizUsercase mecanicaBasicaQuizUsercase}) {
    homeState = Rx<HomeState>(HomeState.init);
    _direcaoDefesivaQuizUsercase = direcaoDefesivaQuizUsercase;
    _legislacaoQuizUsercase = legislacaoQuizUsercase;
    _primeirosSocorrosQuizUsercase = primeirosSocorrosQuizUsercase;
    _meioAmbienteQuizUsercase = meioAmbienteQuizUsercase;
    _mecanicaBasicaQuizUsercase = mecanicaBasicaQuizUsercase;
    _quizEntity = Rx<QuizEntity?>(null);
  }
  late Rx<HomeState> homeState;
  late final DirecaoDefesivaQuizUsercase _direcaoDefesivaQuizUsercase;
  late final LegislacaoQuizUsercase _legislacaoQuizUsercase;
  late final MeioAmbienteQuizUsercase _meioAmbienteQuizUsercase;
  late final PrimeirosSocorrosQuizUsercase _primeirosSocorrosQuizUsercase;
  late final MecanicaBasicaQuizUsercase _mecanicaBasicaQuizUsercase;
  late Rx<QuizEntity?> _quizEntity;

  Future<void> irParaPagina(QuizEnum quiz) async {
    await _getQuiz(quiz);
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
  }

  Future<void> _getQuiz(QuizEnum quiz) async {
    homeState.value = HomeState.carregando;
    switch (quiz) {
      case QuizEnum.direcaoDefensiva:
        final result = await _direcaoDefesivaQuizUsercase();
        _emitirEstado(result);
        break;
      case QuizEnum.legislacao:
        final result = await _legislacaoQuizUsercase();
        _emitirEstado(result);
        break;
      case QuizEnum.meioAmbiente:
        final result = await _meioAmbienteQuizUsercase();
        _emitirEstado(result);
        break;
      case QuizEnum.primeirosSocorros:
        final result = await _primeirosSocorrosQuizUsercase();
        _emitirEstado(result);
        break;
      case QuizEnum.mecanicaBasica:
        final result = await _mecanicaBasicaQuizUsercase();
        _emitirEstado(result);
        break;
      default:
        _quizEntity.value = null;
    }
  }

  void _emitirEstado(Either<ExceptionErro, QuizEntity> result) {
    result.fold(
      (_) {
        homeState.value = HomeState.erro;
      },
      (quiz) {
        homeState.value = HomeState.carregado;
        _quizEntity.value = quiz;
      },
    );
  }
}
