import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/constants/app_store_constants.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';
import 'package:habilitacao_quiz/core/store/app_store_launcher.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HabilitacaoQuizPlusScreen extends StatelessWidget {
  const HabilitacaoQuizPlusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsPro) {
      return const _PlusProAutoPop();
    }

    final proGate = Get.find<ProGate>();
    if (!proGate.exibirPromoPlus) {
      return const Scaffold(body: SizedBox.shrink());
    }

    return const _PlusScreenImpression(
      child: _HabilitacaoQuizPlusContent(),
    );
  }
}

/// Fecha a tela uma vez após o primeiro frame (edição Pro).
class _PlusProAutoPop extends StatefulWidget {
  const _PlusProAutoPop();

  @override
  State<_PlusProAutoPop> createState() => _PlusProAutoPopState();
}

class _PlusProAutoPopState extends State<_PlusProAutoPop> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (Get.key.currentState?.canPop() ?? false) {
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox.shrink());
  }
}

class _PlusScreenImpression extends StatefulWidget {
  const _PlusScreenImpression({required this.child});

  final Widget child;

  @override
  State<_PlusScreenImpression> createState() => _PlusScreenImpressionState();
}

class _PlusScreenImpressionState extends State<_PlusScreenImpression> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Get.find<PromoFunnelAnalytics>().logImpression(PromoSurface.plusScreen);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _HabilitacaoQuizPlusContent extends StatelessWidget {
  const _HabilitacaoQuizPlusContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStoreConstants.plusProductName,
          style: AppFontStyle.headline20Bold,
        ),
        leading: Semantics(
          button: true,
          label: Strings.fechar,
          child: IconButton(
            icon: const Icon(Icons.close),
            tooltip: Strings.fechar,
            onPressed: Get.back,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        constraints.maxWidth > 600 ? 560 : double.infinity,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          Strings.plusScreenTitle,
                          style: AppFontStyle.headline24Bold,
                        ),
                      ),
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                      Text(
                        Strings.plusScreenIntro,
                        style: AppFontStyle.body14Regular
                            .setColor(AppColors.grey),
                      ),
                      SizedBox(height: AppSpacingStack.small.value),
                      ...Strings.plusBenefits.map(
                        (benefit) => _PlusBenefitRow(benefit: benefit),
                      ),
                      SizedBox(height: AppSpacingStack.large.value),
                      AppButton.primary(
                        AppStoreConstants.isProPublished
                            ? Strings.plusVerNaLoja
                            : Strings.plusEmBreve,
                        expanded: true,
                        onPressed: () => openHabilitacaoQuizPlusStore(
                          useUtm: true,
                          surface: PromoSurface.plusScreen,
                        ),
                      ),
                      SizedBox(height: AppSpacingStack.xxSmall.value),
                      AppButton.link(
                        Strings.voltar,
                        expanded: true,
                        onPressed: Get.back,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlusBenefitRow extends StatelessWidget {
  const _PlusBenefitRow({required this.benefit});

  final String benefit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppSpacingStack.nano.value,
      ),
      child: Semantics(
        label: benefit,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExcludeSemantics(
              child: Icon(
                Icons.check_circle_outline,
                color: AppColors.green,
                size: 22,
              ),
            ),
            SizedBox(width: AppSpacingStack.nano.value),
            Expanded(
              child: Text(
                benefit,
                style: AppFontStyle.body14Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
