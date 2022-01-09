import 'dart:typed_data';

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
    this.imageQuestion,
  }) : super(key: key);
  final PerguntaEntity pergunta;
  final ValueChanged<RespostaEntity> onSelected;
  final RespostaEntity? respostaSelected;
  final Uint8List? imageQuestion;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          if (imageQuestion != null)
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 5.h,
              ),
              height: 300.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(imageQuestion!),
                ),
              ),
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
