import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Rodapé da lista de histórico: copy Quiz+ e banner promocional.
class HistoricoListPlusFooter extends StatelessWidget {
  const HistoricoListPlusFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacingStack.xxxSmall.value,
        bottom: AppSpacingStack.small.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Strings.historicoPlusRodape,
            style:
                AppFontStyle.caption12Regular.setColor(AppColors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          const HabilitacaoQuizPlusCtaBanner(
            compact: false,
            analyticsSurface: PromoSurface.historicoFooter,
          ),
        ],
      ),
    );
  }
}
