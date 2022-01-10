import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/resposta/resposta_widget.dart';
import 'package:quiz_car/app/features/shared/domain/entities/pergunta_entity.dart';
import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';
import 'package:quiz_car/core/styles/app_styles.dart';

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
          const SizedBox(
            height: 64,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              pergunta.titulo,
              style: AppTextStyles.notoSansBold(
                color: AppColors.preto,
                fontSize: 18.ssp,
              ),
            ),
          ),
          if (pergunta.imagemB64 != null)
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 5.h,
              ),
              child: Image.memory(pergunta.imagemB64!),
            ),
          SizedBox(
            height: 15.h,
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
