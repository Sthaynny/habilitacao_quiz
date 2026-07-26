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
    return _FreeTeaser();
  }
}

class _ProDashboard extends StatelessWidget {
  const _ProDashboard({required this.stats});

  final List<MateriaPercentualEntity> stats;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: Strings.historicoDashboardMateriaTitulo,
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
            Text(
              Strings.historicoDashboardMateriaTitulo,
              style: AppFontStyle.body16Medium,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              Strings.historicoDashboardMateriaSubtitulo,
              style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            ...stats.map(_MateriaRow.new),
          ],
        ),
      ),
    );
  }
}

class _MateriaRow extends StatelessWidget {
  const _MateriaRow(this.item);

  final MateriaPercentualEntity item;

  @override
  Widget build(BuildContext context) {
    final pctLabel = item.temDados
        ? '${item.percentual.toStringAsFixed(0)}%'
        : Strings.historicoDashboardMateriaSemDados;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingStack.nano.value),
      child: Semantics(
        label: '${item.titulo}. $pctLabel',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                item.titulo,
                style: AppFontStyle.caption12Regular,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
    );
  }
}

class _FreeTeaser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
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
            AppButton.primary(
              Strings.plusVerNaLoja,
              onPressed: () => Get.toNamed(Routes.habilitacaoQuizPlus),
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
