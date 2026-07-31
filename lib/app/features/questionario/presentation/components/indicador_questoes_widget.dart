import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/linear_progress_indicator.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class IndicadorQuestoesWidget extends StatelessWidget {
  const IndicadorQuestoesWidget({
    super.key,
    required this.currentPage,
    required this.length,
  });
  final int currentPage;
  final int length;

  @override
  Widget build(BuildContext context) {
    final percentual = length == 0 ? 0 : (currentPage / length * 100).round();

    return Semantics(
      label: Strings.questaoIndicadorA11y(currentPage, length),
      value: Strings.questaoProgressoA11y(percentual),
      child: ExcludeSemantics(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacingStack.xxxSmall.value,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Questão $currentPage',
                    style: AppFontStyle.body16Regular.setColor(AppColors.grey),
                  ),
                  Text(
                    'de $length',
                    style: AppFontStyle.body16Regular.setColor(AppColors.grey),
                  ),
                ],
              ),
              SizedBox(height: AppSpacingStack.xxxSmall.value),
              LinearProgressIndicatorWidget(
                value: length == 0 ? 0 : currentPage / length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
