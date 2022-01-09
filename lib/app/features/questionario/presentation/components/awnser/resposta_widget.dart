import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';
import 'package:quiz_car/core/styles/app_styles.dart';

class RespostaWidget extends StatelessWidget {
  const RespostaWidget({
    required this.respota,
    required this.onTap,
    Key? key,
    this.isSelected = false,
    this.disabled = false,
  }) : super(key: key);
  final RespostaEntity respota;
  final bool isSelected;
  final ValueChanged<bool> onTap;
  final bool disabled;

  Color get _selectedColorRight => AppColors.verdeEscuro;

  Color get _selectedBorderRight => AppColors.verdeClaro;

  Color get _selectedColorCardRight => AppColors.verdeClaro;

  Color get _selectedBorderCardRight => AppColors.verde;

  IconData get _selectedIconRight => Icons.check;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: GestureDetector(
        onTap: () => onTap(respota.correta),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
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
              Expanded(
                child: Text(
                  respota.titulo,
                  style: AppTextStyles.notoSansRegular(
                    color: AppColors.cinza,
                    fontSize: 13.ssp,
                  ),
                ),
              ),
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: isSelected ? _selectedColorRight : AppColors.branco,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color:
                          isSelected ? _selectedBorderRight : AppColors.border,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
