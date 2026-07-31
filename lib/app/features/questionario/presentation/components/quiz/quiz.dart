import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/resposta/resposta_widget.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({
    super.key,
    required this.pergunta,
    required this.controller,
    this.scrollController,
  });

  final PerguntaEntity pergunta;
  final QuestionarioController controller;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            label: pergunta.titulo,
            child: ExcludeSemantics(
              child: Text(
                pergunta.titulo,
                style: AppFontStyle.body16Medium.setColor(AppColors.black),
              ),
            ),
          ),
          if (pergunta.imagemB64 != null) ...[
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            Semantics(
              label: Strings.questaoImagemIlustracao,
              image: true,
              child: Image.memory(pergunta.imagemB64!),
            ),
          ],
          SizedBox(height: AppSpacingStack.xxxSmall.value),
          Obx(
            () {
              final respostaSelected = controller.respostaSelecionada;
              return Column(
                children: [
                  for (final elemento in pergunta.respostas)
                    RespostaWidget(
                      key: ValueKey(elemento.titulo),
                      onTap: (resposta) =>
                          controller.setRespostaSelecionada = resposta,
                      resposta: elemento,
                      isSelected: respostaSelected == elemento,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
