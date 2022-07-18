import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class RespostaWidget extends StatelessWidget {
  const RespostaWidget({
    required this.resposta,
    required this.onTap,
    Key? key,
    this.isSelected = false,
  }) : super(key: key);
  final RespostaEntity resposta;
  final bool isSelected;
  final ValueChanged<RespostaEntity> onTap;

  Color get _selectedColorCardRight => AppColors.lightGreen;

  Color get _selectedBorderCardRight => AppColors.green;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(resposta);
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(vertical: AppSpacingStack.quarck.value),
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        decoration: BoxDecoration(
          color: isSelected ? _selectedColorCardRight : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.fromBorderSide(
            BorderSide(
              color: isSelected ? _selectedBorderCardRight : AppColors.border,
            ),
          ),
        ),
        child: Expanded(
          child: Text(
            resposta.titulo.primeiraLetraMaiuscula,
            style: AppFontStyle.body16Medium
                .setColor(isSelected ? AppColors.darkGreen : AppColors.black),
          ),
        ),
      ),
    );
  }
}

extension StringExt on String {
  String get primeiraLetraMaiuscula {
    final string = this;
    return string[0].toUpperCase() + string.substring(1);
  }
}
