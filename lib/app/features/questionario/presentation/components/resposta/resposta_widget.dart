import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class RespostaWidget extends StatelessWidget {
  const RespostaWidget({
    required this.resposta,
    required this.onTap,
    super.key,
    this.isSelected = false,
  });
  final RespostaEntity resposta;
  final bool isSelected;
  final ValueChanged<RespostaEntity> onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: resposta.titulo,
      child: GestureDetector(
        onTap: () => onTap(resposta),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: double.maxFinite,
          constraints: BoxConstraints(
            minHeight: AppSpacingStack.medium.value,
          ),
          margin: EdgeInsets.symmetric(vertical: AppSpacingStack.quarck.value),
          padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.lightGreen : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.green : AppColors.border,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              resposta.titulo.primeiraLetraMaiuscula,
              style: AppFontStyle.body16Medium.setColor(
                isSelected ? AppColors.darkGreen : AppColors.black,
              ),
            ),
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
