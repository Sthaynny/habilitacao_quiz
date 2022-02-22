import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/legislacao_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/meio_ambiente_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/primeiros_socorros_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/simulado_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';

class HomeController extends GetxController {
  HomeController({
    required DirecaoDefesivaQuizUsercase direcaoDefesivaQuizUsercase,
    required LegislacaoQuizUsercase legislacaoQuizUsercase,
    required MeioAmbienteQuizUsercase meioAmbienteQuizUsercase,
    required PrimeirosSocorrosQuizUsercase primeirosSocorrosQuizUsercase,
    required MecanicaBasicaQuizUsercase mecanicaBasicaQuizUsercase,
    required SimuladoQuizUsercase simuladoQuizUsercase,
  }) {
    _direcaoDefesivaQuizUsercase = direcaoDefesivaQuizUsercase;
    _legislacaoQuizUsercase = legislacaoQuizUsercase;
    _primeirosSocorrosQuizUsercase = primeirosSocorrosQuizUsercase;
    _meioAmbienteQuizUsercase = meioAmbienteQuizUsercase;
    _mecanicaBasicaQuizUsercase = mecanicaBasicaQuizUsercase;
    _simuladoQuizUsercase = simuladoQuizUsercase;
  }
  late final DirecaoDefesivaQuizUsercase _direcaoDefesivaQuizUsercase;
  late final LegislacaoQuizUsercase _legislacaoQuizUsercase;
  late final MeioAmbienteQuizUsercase _meioAmbienteQuizUsercase;
  late final PrimeirosSocorrosQuizUsercase _primeirosSocorrosQuizUsercase;
  late final MecanicaBasicaQuizUsercase _mecanicaBasicaQuizUsercase;
  late final SimuladoQuizUsercase _simuladoQuizUsercase;

  final Rx<RxStatus> _status = RxStatus.empty().obs;
  final Rx<QuizEntity?> _quizEntity = QuizEntity.empty().obs;

  Future<void> irParaPagina(QuizEnum quiz) async {
    await _getQuiz(quiz);
    if (_quizEntity.value != null) {
      Get.toNamed(
        Routes.questionario,
        arguments: _quizEntity.value,
      );
    }
  }

  Future<void> _getQuiz(QuizEnum quiz) async {
    _status.value = RxStatus.loading();
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
      case QuizEnum.similado:
        final result = await _simuladoQuizUsercase();
        _emitirEstado(result);
        break;
      default:
        _quizEntity.value = null;
    }
  }

  void _emitirEstado(Either<ExceptionErro, QuizEntity> result) {
    result.fold(
      (_) {
        _status.value = RxStatus.error();
      },
      (quiz) {
        _quizEntity.value = quiz;

        _status.value = RxStatus.success();
      },
    );
  }
}

extension HomeContrrollerGets on HomeController {
  bool get isSuccess => _status.value.isSuccess;
  bool get isLoading => _status.value.isLoading;
  bool get isError => _status.value.isError;
}
