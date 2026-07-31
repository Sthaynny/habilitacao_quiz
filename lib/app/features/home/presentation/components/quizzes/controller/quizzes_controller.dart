import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/legislacao_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/meio_ambiente_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/primeiros_socorros_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/simulado_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/simulado_quota_service.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:habilitacao_quiz/core/utils/gate_limit_feedback.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class QuizzesController extends GetxController {
  QuizzesController({
    required DirecaoDefesivaQuizUsercase direcaoDefesivaQuizUsercase,
    required LegislacaoQuizUsercase legislacaoQuizUsercase,
    required MeioAmbienteQuizUsercase meioAmbienteQuizUsercase,
    required PrimeirosSocorrosQuizUsercase primeirosSocorrosQuizUsercase,
    required MecanicaBasicaQuizUsercase mecanicaBasicaQuizUsercase,
    required SimuladoQuizUsercase simuladoQuizUsercase,
    required SimuladoQuotaService simuladoQuotaService,
  }) {
    _direcaoDefesivaQuizUsercase = direcaoDefesivaQuizUsercase;
    _legislacaoQuizUsercase = legislacaoQuizUsercase;
    _primeirosSocorrosQuizUsercase = primeirosSocorrosQuizUsercase;
    _meioAmbienteQuizUsercase = meioAmbienteQuizUsercase;
    _mecanicaBasicaQuizUsercase = mecanicaBasicaQuizUsercase;
    _simuladoQuizUsercase = simuladoQuizUsercase;
    _simuladoQuotaService = simuladoQuotaService;
  }
  late final DirecaoDefesivaQuizUsercase _direcaoDefesivaQuizUsercase;
  late final LegislacaoQuizUsercase _legislacaoQuizUsercase;
  late final MeioAmbienteQuizUsercase _meioAmbienteQuizUsercase;
  late final PrimeirosSocorrosQuizUsercase _primeirosSocorrosQuizUsercase;
  late final MecanicaBasicaQuizUsercase _mecanicaBasicaQuizUsercase;
  late final SimuladoQuizUsercase _simuladoQuizUsercase;
  late final SimuladoQuotaService _simuladoQuotaService;
  ValueChanged<RxStatus>? onStatus;

  QuizEntity? _quizEntity = QuizEntity.empty();

  Future<void> irParaPagina(QuizEnum quiz) async {
    if (quiz == QuizEnum.simulado) {
      final pode = await _simuladoQuotaService.podeIniciarSimuladoHoje();
      if (!pode) {
        showSimuladoLimiteDiarioSnackbar();
        return;
      }
    }

    await _getQuiz(quiz);
    final quizEntity = _quizEntity;
    if (quizEntity != null && !quizEntity.isEmpty) {
      if (quiz == QuizEnum.simulado) {
        await _simuladoQuotaService.registrarInicioSimulado();
      }
      Get.toNamed(
        Routes.questionario,
        arguments: _quizEntity,
      );
    }
  }

  void _setStatus(RxStatus status) {
    if (onStatus != null) {
      onStatus!(status);
    }
  }

  Future<void> _getQuiz(QuizEnum quiz) async {
    _setStatus(RxStatus.loading());
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
      case QuizEnum.simulado:
        final result = await _simuladoQuizUsercase();
        _emitirEstado(result);
        break;
    }
  }

  void _emitirEstado(Either<ExceptionErro, QuizEntity> result) {
    result.fold(
      (_) {
        _setStatus(RxStatus.error());
      },
      (quiz) {
        _quizEntity = quiz;

        _setStatus(RxStatus.success());
      },
    );
  }

  Future<void> iniciarModoProva() async {
    final proGate = Get.find<ProGate>();
    if (!proGate.podeModoProva) {
      Get.toNamed(Routes.habilitacaoQuizPlus);
      return;
    }
    final pode = await _simuladoQuotaService.podeIniciarSimuladoHoje();
    if (!pode) {
      showSimuladoLimiteDiarioSnackbar();
      return;
    }
    await _getQuiz(QuizEnum.simulado);
    final base = _quizEntity;
    if (base == null || base.isEmpty) return;
    await _simuladoQuotaService.registrarInicioSimulado();
    final modoProva = base.copyWith(
      titulo: Strings.modoProva,
      tempoLimite: const Duration(minutes: 40),
      modoProva: true,
    );
    Get.toNamed(Routes.questionario, arguments: modoProva);
  }
}
