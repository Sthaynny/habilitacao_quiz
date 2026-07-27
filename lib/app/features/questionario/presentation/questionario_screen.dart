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

  @override
  void didChangeDependencies() {
    controller.init(quizEntity: quiz);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
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
          tempoLimite: quiz.tempoLimite,
          onTempoEsgotado: controller.finalizarPorTempoEsgotado,
        ),
        body: Obx(
          () {
            final index = controller.indexPergunta;
            return QuizWidget(
              key: ValueKey(index),
              scrollController: scrollController,
              controller: controller,
              pergunta: controller.perguntaAtual,
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacingStack.xSmall.value,
              vertical: AppSpacingStack.xxxSmall.value,
            ),
            child: Row(
              children: [
                Obx(
                  () => controller.indexPergunta != 0
                      ? Flexible(
                          child: AppButton.primaryOutline(
                            Strings.voltar,
                            onPressed: () {
                              controller.voltarPergunta;
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.indexPergunta != 0
                      ? SizedBox(width: AppSpacingStack.nano.value)
                      : const SizedBox.shrink(),
                ),
                Flexible(
                  child: Obx(
                    () => AppButton.secundary(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
