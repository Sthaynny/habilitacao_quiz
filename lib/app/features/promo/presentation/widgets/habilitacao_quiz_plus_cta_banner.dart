import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/constants/app_store_constants.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/consts.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Banner compacto promovendo o **Habilitação Quiz+** (somente Free).
class HabilitacaoQuizPlusCtaBanner extends StatelessWidget {
  const HabilitacaoQuizPlusCtaBanner({
    super.key,
    this.compact = true,
    this.onTap,
    this.analyticsSurface = PromoSurface.homeBanner,
  });

  final bool compact;
  final VoidCallback? onTap;
  final PromoSurface analyticsSurface;

  void _onTap() {
    Get.find<PromoFunnelAnalytics>().logClick(
      analyticsSurface,
      PromoClickTarget.openPlusScreen,
    );
    if (onTap != null) {
      onTap!();
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

    return _PromoBannerImpression(
      surface: analyticsSurface,
      child: _HabilitacaoQuizPlusCtaBannerBody(
        compact: compact,
        onTap: _onTap,
      ),
    );
  }
}

class _PromoBannerImpression extends StatefulWidget {
  const _PromoBannerImpression({
    required this.surface,
    required this.child,
  });

  final PromoSurface surface;
  final Widget child;

  @override
  State<_PromoBannerImpression> createState() => _PromoBannerImpressionState();
}

class _PromoBannerImpressionState extends State<_PromoBannerImpression> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Get.find<PromoFunnelAnalytics>().logImpression(widget.surface);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _HabilitacaoQuizPlusCtaBannerBody extends StatelessWidget {
  const _HabilitacaoQuizPlusCtaBannerBody({
    required this.compact,
    required this.onTap,
  });

  static const _borderRadius =
      BorderRadius.all(Radius.circular(border12Radius));

  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: Strings.plusBannerSemantics,
      hint: Strings.plusBannerHint,
      child: Material(
        color: AppColors.lightPurple.withValues(alpha: 0.2),
        borderRadius: _borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: _borderRadius,
          child: _PromoBannerTapTarget(
            compact: compact,
          ),
        ),
      ),
    );
  }
}

class _PromoBannerTapTarget extends StatelessWidget {
  const _PromoBannerTapTarget({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacingStack.xxxSmall.value,
          vertical: AppSpacingStack.nano.value,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.workspace_premium_outlined,
              color: AppColors.purple,
            ),
            SizedBox(width: AppSpacingStack.nano.value),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStoreConstants.plusProductName,
                    style:
                        AppFontStyle.body16Bold.setColor(AppColors.purple),
                  ),
                  if (!compact) ...[
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
    );
  }
}
