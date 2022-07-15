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

  Color get _selectedColorRight => AppColors.verdeEscuro;

  Color get _selectedBorderRight => AppColors.cinza;

  Color get _selectedColorCardRight => AppColors.cinzaSuperClaro;

  Color get _selectedBorderCardRight => AppColors.cinza;

  IconData get _selectedIconRight => Icons.close;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(resposta);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppSpacingStack.xxxSmall.value, vertical: 4),
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        decoration: BoxDecoration(
          color: isSelected ? _selectedColorCardRight : AppColors.branco,
          borderRadius: BorderRadius.circular(10),
          border: Border.fromBorderSide(
            BorderSide(
              color: isSelected ? _selectedBorderCardRight : AppColors.border,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.only(right: AppSpacingStack.nano.value),
              decoration: BoxDecoration(
                color: isSelected ? _selectedColorRight : AppColors.branco,
                borderRadius: BorderRadius.circular(12),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: isSelected ? _selectedBorderRight : AppColors.border,
                  ),
                ),
              ),
              child: isSelected
                  ? Icon(
                      _selectedIconRight,
                      color: AppColors.branco,
                      size: 16,
                    )
                  : null,
            ),
            Expanded(
              child: Text(
                resposta.titulo.primeiraLetraMaiuscula,
                style: AppTextStyles.notoSansRegular(
                  color: AppColors.cinza,
                  fontSize: 13,
                ),
              ),
            ),
          ],
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
