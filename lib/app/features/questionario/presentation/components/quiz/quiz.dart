import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/resposta/resposta_widget.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({
    Key? key,
    required this.pergunta,
    required this.onSelected,
    this.respostaSelected,
    this.scrollController,
  }) : super(key: key);
  final PerguntaEntity pergunta;
  final ValueChanged<RespostaEntity> onSelected;
  final RespostaEntity? respostaSelected;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pergunta.titulo,
              style: AppFontStyle.body16Medium.setColor(AppColors.black)),
          if (pergunta.imagemB64 != null) Image.memory(pergunta.imagemB64!),
          SizedBox(
            height: AppSpacingStack.xxxSmall.value,
          ),
          ...pergunta.respostas
              .map(
                (elemento) => RespostaWidget(
                  onTap: onSelected,
                  resposta: elemento,
                  isSelected: respostaSelected == elemento,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
