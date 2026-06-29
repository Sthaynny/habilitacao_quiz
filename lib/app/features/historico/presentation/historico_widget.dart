import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/ad_helper.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HistoricoWidget extends StatefulWidget {
  const HistoricoWidget({
    super.key,
    required this.historico,
  });
  final HistoricoEntity historico;

  @override
  State<HistoricoWidget> createState() => _HistoricoWidgetState();
}

class _HistoricoWidgetState extends State<HistoricoWidget> {
  HistoricoEntity get historico => widget.historico;
  final ValueNotifier<BannerAd?> bannerAdNotifier = ValueNotifier(null);

  @override
  void initState() {
    BannerAd(
      adUnitId: AdHelper.bannerTest,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAdNotifier.value = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
  }

  @override
  void dispose() {
    bannerAdNotifier.value?.dispose();
    bannerAdNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacingStack.xSmall.value),
      child: historico.resutados.isEmpty
          ? _buildEmptyState()
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.historico,
                        style: AppFontStyle.headline24Bold,
                      ),
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildResultCard(
                      historico.resutados[index],
                    ),
                    childCount: historico.resutados.length,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: AppSpacingStack.xxxLarge.value),
        Text(
          Strings.historico,
          style: AppFontStyle.headline24Bold,
        ),
        SizedBox(height: AppSpacingStack.xxxLarge.value),
        Center(
          child: Text(
            Strings.comeceEstudosVizualizarProgresso,
            style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(ResultadoEntity element) {
    final percentualLabel = Strings.percentualHistorico(
      percentual: element.percentual.toPrecision(2).toString(),
    );

    return Container(
      padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
      margin: EdgeInsets.symmetric(vertical: AppSpacingStack.nano.value),
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(
          BorderSide(color: AppColors.border),
        ),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '${element.titulo}\n',
                style: AppFontStyle.body16Medium,
                children: [
                  TextSpan(
                    text: percentualLabel,
                    style: AppFontStyle.caption12Regular
                        .setColor(AppColors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppSpacingStack.xxxSmall.value),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Semantics(
                label: percentualLabel,
                value: '${element.percentual.toPrecision(2)}%',
                child: SizedBox(
                  width: AppSpacingStack.large.value + AppSpacingStack.nano.value,
                  child: LinearProgressIndicatorWidget(
                    value: element.percentual / 100,
                  ),
                ),
              ),
              SizedBox(height: AppSpacingStack.nano.value),
              Text(
                '${element.totalRespostasCorretas} de ${element.totalPerguntas}',
                style: AppFontStyle.caption12Regular
                    .setColor(AppColors.lightGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get bottomAd => ValueListenableBuilder(
        valueListenable: bannerAdNotifier,
        builder: (context, bannerAd, child) {
          if (bannerAd != null) {
            return SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            );
          }
          return Container();
        },
      );
}
