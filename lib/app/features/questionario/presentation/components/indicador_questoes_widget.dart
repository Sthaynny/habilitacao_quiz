import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/linear_progress_indicator.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class IndicadorQuestoesWidget extends StatelessWidget {
  const IndicadorQuestoesWidget({
    Key? key,
    required this.currentPage,
    required this.length,
  }) : super(key: key);
  final int currentPage;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Questão $currentPage',
                style: AppTextStyles.notoSansRegular(
                  color: AppColors.cinza,
                  fontSize: 13,
                ),
              ),
              Text(
                'de $length',
                style: AppTextStyles.notoSansRegular(
                  color: AppColors.cinza,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicatorWidget(
            value: currentPage / length,
          ),
        ],
      ),
    );
  }
}
