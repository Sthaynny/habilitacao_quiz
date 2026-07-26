import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/constants/app_store_constants.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';

/// Banner compacto promovendo o **Habilitação Quiz+** (somente Free).
class HabilitacaoQuizPlusCtaBanner extends StatefulWidget {
  const HabilitacaoQuizPlusCtaBanner({
    super.key,
    this.compact = true,
    this.onTap,
    this.analyticsSurface = PromoSurface.homeBanner,
  });

  final bool compact;
  final VoidCallback? onTap;
  final PromoSurface analyticsSurface;

  @override
  State<HabilitacaoQuizPlusCtaBanner> createState() =>
      _HabilitacaoQuizPlusCtaBannerState();
}

class _HabilitacaoQuizPlusCtaBannerState
    extends State<HabilitacaoQuizPlusCtaBanner> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (kIsPro) return;
      final proGate = Get.find<ProGate>();
      if (!proGate.exibirPromoPlus) return;
      Get.find<PromoFunnelAnalytics>()
          .logImpression(widget.analyticsSurface);
    });
  }

  void _onTap() {
    Get.find<PromoFunnelAnalytics>().logClick(
      widget.analyticsSurface,
      PromoClickTarget.openPlusScreen,
    );
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      Get.toNamed(Routes.habilitacaoQuizPlus);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsPro) {
      return const SizedBox.shrink();
    }

    final proGate = Get.find<ProGate>();
    if (!proGate.exibirPromoPlus) {
      return const SizedBox.shrink();
    }

    return Semantics(
      button: true,
      label: Strings.plusBannerSemantics,
      hint: Strings.plusBannerHint,
      child: Material(
        color: AppColors.lightPurple.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: _onTap,
          borderRadius: BorderRadius.circular(12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacingStack.xxxSmall.value,
                vertical: AppSpacingStack.nano.value,
              ),
              child: Row(
                children: [
                  const Icon(Icons.workspace_premium_outlined,
                      color: AppColors.purple),
                  SizedBox(width: AppSpacingStack.nano.value),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStoreConstants.plusProductName,
                          style: AppFontStyle.body16Bold
                              .setColor(AppColors.purple),
                        ),
                        if (!widget.compact) ...[
                          SizedBox(height: AppSpacingStack.quarck.value),
                          Text(
                            Strings.plusBannerSubtitle,
                            style: AppFontStyle.caption12Regular
                                .setColor(AppColors.grey),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.purple),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
