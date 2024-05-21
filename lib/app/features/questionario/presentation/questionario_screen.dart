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
    Key? key,
    required this.quizEntity,
    required this.controller,
  }) : super(key: key);

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
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvoked: (_) => controller.fecharQuestionario(),
        child: Scaffold(
          appBar: AppBarQuestionarioWidget(
            onClosed: () {
              controller.fecharQuestionario();
            },
            paginaAtual: controller.indexPerguntaUsuario,
            tamanhoQuiz: controller.tamanhoQuiz,
          ),
          body: QuizWidget(
            scrollController: scrollController,
            onSelected: (value) {
              controller.setRespostaSelecionada = value;
            },
            pergunta: controller.perguntaAtual,
            respostaSelected: controller.respotaSelecionada,
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacingStack.xSmall.value,
                vertical: AppSpacingStack.xxxSmall.value,
              ),
              child: Row(
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
                  )),
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
        SizedBox(
          width: AppSpacingStack.nano.value,
        ),
      ];
}
