import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/app_bar_questionario.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/primary_button_widget.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/quiz/quiz.dart';
import 'package:quiz_car/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';

class QuestionarioScreen extends StatefulWidget {
  const QuestionarioScreen({Key? key, required this.quizEntity})
      : super(key: key);
  final QuizEntity quizEntity;
  @override
  _QuestionarioScreenState createState() => _QuestionarioScreenState();
}

class _QuestionarioScreenState extends State<QuestionarioScreen> {
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
        return Scaffold(
          appBar: AppBarQuestionarioWidget(
            onClosed: () {},
            paginaAtual: controller.indexPergunta,
            tamanhoQuiz: controller.quiz.value.perguntas.length,
          ),
          body: QuizWidget(
            onSelected: (value) {
              controller.perguntaSelecionada = value;
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
                  Flexible(
                      child: PrimaryButtonWidget.branco(
                    label: 'voltar',
                    onTap: () {},
                  )),
                  Flexible(
                      child: PrimaryButtonWidget.azul(
                    label: 'avançar',
                    onTap: () {},
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
