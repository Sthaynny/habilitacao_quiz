import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/agregar_percentual_por_materia.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/materia_percentual_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/components/section_header_a11y.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HistoricoMateriaDashboard extends StatelessWidget {
  const HistoricoMateriaDashboard({
    super.key,
    required this.resultados,
  });

  final List<ResultadoEntity> resultados;

  @override
  Widget build(BuildContext context) {
    final proGate = Get.find<ProGate>();
    if (proGate.podeVerDashboardMateriaHistorico) {
      final stats = agregarPercentualPorMateria(resultados);
      return _ProDashboard(stats: stats);
    }
    return const _FreeTeaser();
  }
}

class _ProDashboard extends StatelessWidget {
  const _ProDashboard({required this.stats});

  final List<MateriaPercentualEntity> stats;

  @override
  Widget build(BuildContext context) {
    final comDados = stats.where((s) => s.temDados).toList();
    final maisFraca = comDados.isEmpty
        ? null
        : comDados.reduce(
            (a, b) => a.percentual <= b.percentual ? a : b,
          );

    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        margin: EdgeInsets.only(bottom: AppSpacingStack.xxxSmall.value),
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeaderA11y(
              title: Strings.historicoDashboardMateriaTitulo,
              subtitle: Strings.historicoDashboardMateriaSubtitulo,
              style: AppFontStyle.body16Medium,
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.length,
              separatorBuilder: (_, _) =>
                  SizedBox(height: AppSpacingStack.nano.value),
              itemBuilder: (context, index) {
                final item = stats[index];
                return _MateriaRow(
                  item,
                  destacar: maisFraca != null && item.titulo == maisFraca.titulo,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MateriaRow extends StatelessWidget {
  const _MateriaRow(this.item, {this.destacar = false});

  final MateriaPercentualEntity item;
  final bool destacar;

  @override
  Widget build(BuildContext context) {
    final pctLabel = item.temDados
        ? '${item.percentual.toStringAsFixed(0)}%'
        : Strings.historicoDashboardMateriaSemDados;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingStack.nano.value),
      child: Semantics(
        label: destacar
            ? '${item.titulo}. $pctLabel. ${Strings.proStudyFocoMateria}'
            : '${item.titulo}. $pctLabel',
        child: ExcludeSemantics(
          child: Container(
            padding: destacar
                ? EdgeInsets.all(AppSpacingStack.quarck.value)
                : EdgeInsets.zero,
            decoration: destacar
                ? BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.25),
                    ),
                  )
                : null,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.titulo,
                        style: AppFontStyle.caption12Regular,
                        softWrap: true,
                      ),
                      if (destacar)
                        Text(
                          Strings.proStudyFocoMateria,
                          style: AppFontStyle.caption12Regular.setColor(
                            AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: LinearProgressIndicatorWidget(
                    value: item.temDados ? item.percentual / 100 : 0,
                  ),
                ),
                SizedBox(width: AppSpacingStack.nano.value),
                Text(
                  pctLabel,
                  style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FreeTeaser extends StatelessWidget {
  const _FreeTeaser();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: Strings.historicoDashboardMateriaFreeTitulo,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        margin: EdgeInsets.only(bottom: AppSpacingStack.xxxSmall.value),
        decoration: BoxDecoration(
          color: AppColors.cinzaSuperClaro,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.historicoDashboardMateriaFreeTitulo,
              style: AppFontStyle.body16Medium,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              Strings.historicoDashboardMateriaFreeCorpo,
              style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            Semantics(
              button: true,
              label: Strings.plusVerNaLoja,
              hint: Strings.plusBannerHint,
              excludeSemantics: true,
              child: AppButton.primary(
                Strings.plusVerNaLoja,
                onPressed: () => Get.toNamed(Routes.habilitacaoQuizPlus),
              ),
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            const HabilitacaoQuizPlusCtaBanner(
              compact: true,
              analyticsSurface: PromoSurface.historicoFooter,
            ),
          ],
        ),
      ),
    );
  }
}
