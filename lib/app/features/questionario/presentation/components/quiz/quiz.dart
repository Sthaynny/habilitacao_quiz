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
      child: Column(
        children: [
          SizedBox(
            height: AppSpacingStack.large.value,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppSpacingStack.xxxSmall.value),
            child: Text(
              pergunta.titulo,
              style: AppTextStyles.notoSansBold(
                color: AppColors.preto,
                fontSize: 18,
              ),
            ),
          ),
          if (pergunta.imagemB64 != null)
            Container(
              margin: EdgeInsets.symmetric(
                vertical: AppSpacingStack.nano.value,
              ),
              child: Image.memory(pergunta.imagemB64!),
            ),
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
