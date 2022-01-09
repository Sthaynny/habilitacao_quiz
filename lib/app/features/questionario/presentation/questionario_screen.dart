import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/app_bar_questionario.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/quiz/quiz.dart';
import 'package:quiz_car/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/presentation/widgets/primary_button_widget.dart';
import 'package:quiz_car/core/mixins/pop_up_mixin.dart';
import 'package:quiz_car/core/utils/strings.dart';

class QuestionarioScreen extends StatefulWidget {
  const QuestionarioScreen({Key? key, required this.quizEntity})
      : super(key: key);
  final QuizEntity quizEntity;
  @override
  _QuestionarioScreenState createState() => _QuestionarioScreenState();
}

class _QuestionarioScreenState extends State<QuestionarioScreen>
    with PopUpMixin {
  late final QuestionarioController controller;
  QuizEntity get quiz => widget.quizEntity;

  @override
  void didChangeDependencies() {
    controller = Get.find();
    controller.init(quizEntity: quiz);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionarioController>(
      init: controller,
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.fecharQuestionario();
            return false;
          },
          child: Scaffold(
            appBar: AppBarQuestionarioWidget(
              onClosed: () {
                controller.fecharQuestionario();
              },
              paginaAtual: controller.indexPerguntaUsuario,
              tamanhoQuiz: controller.tamanhoQuiz,
            ),
            body: QuizWidget(
              onSelected: (value) {
                controller.setRespostaSelecionada = value;
              },
              pergunta: controller.perguntaAtual,
              respostaSelected: controller.respotaSelecionada,
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                child: Row(
                  children: [
                    if (controller.indexPergunta != 0) ...getButaoVoltar,
                    Flexible(
                        child: PrimaryButtonWidget.azul(
                      label: controller.ultimaPergunta
                          ? Strings.finalizar
                          : Strings.avancar,
                      onTap: controller.respostaSelecionada != null
                          ? () {
                              controller.proximoPergunta;
                            }
                          : null,
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> get getButaoVoltar => [
        Flexible(
          child: PrimaryButtonWidget.branco(
            label: Strings.voltar,
            onTap: () {
              controller.voltarPergunta;
            },
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
      ];
}
