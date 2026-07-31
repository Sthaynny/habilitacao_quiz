import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

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
      hint: isSelected
          ? Strings.respostaSelecionadaA11y
          : Strings.respostaToqueSelecionarA11y,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(resposta),
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: double.maxFinite,
            constraints: BoxConstraints(
              minHeight: AppSpacingStack.medium.value,
            ),
            margin:
                EdgeInsets.symmetric(vertical: AppSpacingStack.quarck.value),
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
              child: ExcludeSemantics(
                child: Text(
                  resposta.titulo.primeiraLetraMaiuscula,
                  style: AppFontStyle.body16Medium.setColor(
                    isSelected ? AppColors.darkGreen : AppColors.black,
                  ),
                ),
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
