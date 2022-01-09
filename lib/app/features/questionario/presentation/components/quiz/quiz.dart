import 'dart:typed_data';

import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:quiz_car/app/features/questionario/presentation/components/awnser/resposta_widget.dart';
import 'package:quiz_car/app/features/shared/domain/entities/pergunta_entity.dart';
import 'package:quiz_car/core/styles/app_styles.dart';
import 'package:quiz_car/core/utils/keys.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget(
      {Key? key,
      required this.pergunta,
      required this.onSelected,
      this.indexSelected,
      this.imageQuestion})
      : super(key: key);
  final PerguntaEntity pergunta;
  final ValueChanged<Map<String, dynamic>> onSelected;
  final int? indexSelected;
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
          for (var index = 0; index < pergunta.respostas.length; index++)
            RespostaWidget(
              onTap: (value) {
                onSelected(
                  {
                    Keys.index: index,
                  },
                );
              },
              disabled: indexSelected != null,
              respota: pergunta.respostas[index],
              isSelected: indexSelected == index,
            ),
        ],
      ),
    );
  }
}
