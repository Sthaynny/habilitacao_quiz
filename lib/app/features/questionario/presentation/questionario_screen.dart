import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/app_bar_questionario.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/quiz/quiz.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class QuestionarioScreen extends StatefulWidget {
  const QuestionarioScreen({
    super.key,
    required this.quizEntity,
    required this.controller,
  });

  final QuestionarioController controller;
  final QuizEntity quizEntity;
  @override
  State<QuestionarioScreen> createState() => _QuestionarioScreenState();
}

class _QuestionarioScreenState extends State<QuestionarioScreen>
    with PopUpMixin {
  QuestionarioController get controller => widget.controller;
  QuizEntity get quiz => widget.quizEntity;
  final scrollController = ScrollController();
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void didChangeDependencies() {
    controller.init(quizEntity: quiz);
    _startTimerIfNeeded();
    super.didChangeDependencies();
  }

  void _startTimerIfNeeded() {
    final limit = quiz.tempoLimite;
    if (limit == null) return;
    _remaining = limit;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _remaining -= const Duration(seconds: 1);
        if (_remaining <= Duration.zero) {
          _timer?.cancel();
          controller.finalizarPorTempoEsgotado();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.fecharQuestionario();
        }
      },
      child: Scaffold(
        appBar: AppBarQuestionarioWidget(
          controller: controller,
          onClosed: controller.fecharQuestionario,
          timerLabel: quiz.tempoLimite != null ? _formatTimer(_remaining) : null,
        ),
        body: Obx(
          () => QuizWidget(
            scrollController: scrollController,
            onSelected: (value) {
              controller.setRespostaSelecionada = value;
            },
            pergunta: controller.perguntaAtual,
            respostaSelected: controller.respotaSelecionada,
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacingStack.xSmall.value,
              vertical: AppSpacingStack.xxxSmall.value,
            ),
            child: Obx(
              () => Row(
                children: [
                  if (controller.indexPergunta != 0) ...getButaoVoltar,
                  Flexible(
                    child: AppButton.secundary(
                      controller.ultimaPergunta
                          ? Strings.finalizar
                          : Strings.avancar,
                      onPressed: controller.respostaSelecionada != null
                          ? () {
                              controller.proximoPergunta;
                              scrollController.jumpTo(0.0);
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get getButaoVoltar => [
    Flexible(
      child: AppButton.primaryOutline(
        Strings.voltar,
        onPressed: () {
          controller.voltarPergunta;
        },
      ),
    ),
    SizedBox(width: AppSpacingStack.nano.value),
  ];

  String _formatTimer(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
