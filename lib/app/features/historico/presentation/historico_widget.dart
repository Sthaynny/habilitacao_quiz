import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/detalhe_simulado_screen.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

enum _HistoricoFiltro { todos, simulados, temas }

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
  _HistoricoFiltro _filtro = _HistoricoFiltro.todos;

  HistoricoEntity get historico => widget.historico;

  List<ResultadoEntity> get _resultadosOrdenados {
    final lista = List<ResultadoEntity>.from(historico.resutados);
    lista.sort((a, b) {
      final ta = a.realizadoEm?.millisecondsSinceEpoch ?? 0;
      final tb = b.realizadoEm?.millisecondsSinceEpoch ?? 0;
      return tb.compareTo(ta);
    });
    return lista;
  }

  List<ResultadoEntity> get _resultadosFiltrados {
    return _resultadosOrdenados.where((r) {
      switch (_filtro) {
        case _HistoricoFiltro.todos:
          return true;
        case _HistoricoFiltro.simulados:
          return r.tipo == TipoResultado.simulado;
        case _HistoricoFiltro.temas:
          return r.tipo == TipoResultado.tema;
      }
    }).toList();
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
                      Semantics(
                        header: true,
                        child: Text(
                          Strings.historico,
                          style: AppFontStyle.headline24Bold,
                        ),
                      ),
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                      _buildFiltroChips(),
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildResultCard(
                      context,
                      _resultadosFiltrados[index],
                    ),
                    childCount: _resultadosFiltrados.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: AppSpacingStack.xxxSmall.value,
                      bottom: AppSpacingStack.small.value,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          Strings.historicoPlusRodape,
                          style: AppFontStyle.caption12Regular
                              .setColor(AppColors.grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSpacingStack.nano.value),
                        const HabilitacaoQuizPlusCtaBanner(
                          compact: false,
                          analyticsSurface: PromoSurface.historicoFooter,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildFiltroChips() {
    return Wrap(
      spacing: AppSpacingStack.nano.value,
      runSpacing: AppSpacingStack.nano.value,
      children: [
        _chip(
          label: Strings.historicoFiltroTodos,
          selected: _filtro == _HistoricoFiltro.todos,
          onSelected: () => setState(() => _filtro = _HistoricoFiltro.todos),
        ),
        _chip(
          label: Strings.historicoFiltroSimulados,
          selected: _filtro == _HistoricoFiltro.simulados,
          onSelected: () =>
              setState(() => _filtro = _HistoricoFiltro.simulados),
        ),
        _chip(
          label: Strings.historicoFiltroTemas,
          selected: _filtro == _HistoricoFiltro.temas,
          onSelected: () => setState(() => _filtro = _HistoricoFiltro.temas),
        ),
      ],
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onSelected,
  }) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        showCheckmark: false,
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        labelStyle: AppFontStyle.caption12Regular.copyWith(
          color: selected ? AppColors.primary : AppColors.grey,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacingStack.nano.value,
          vertical: AppSpacingStack.quarck.value,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: AppSpacingStack.xxxLarge.value),
        Semantics(
          header: true,
          child: Text(
            Strings.historico,
            style: AppFontStyle.headline24Bold,
          ),
        ),
        SizedBox(height: AppSpacingStack.xxxLarge.value),
        Center(
          child: Text(
            Strings.comeceEstudosVizualizarProgresso,
            style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: AppSpacingStack.small.value),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HabilitacaoQuizPlusCtaBanner(compact: false),
        ),
      ],
    );
  }

  void _onResultadoTap(BuildContext context, ResultadoEntity element) {
    final proGate = Get.find<ProGate>();
    if (proGate.isPro && element.isSimulado) {
      Get.to(() => DetalheSimuladoScreen(resultado: element));
      return;
    }
    if (proGate.isPro) {
      _showResumoDialog(context, element);
      return;
    }
    _showFreeResumoSheet(context, element);
  }

  void _showResumoDialog(BuildContext context, ResultadoEntity element) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(element.titulo, style: AppFontStyle.headline20Bold),
        content: Text(
          Strings.percentualHistorico(
            percentual: element.percentual.toStringAsFixed(1),
          ),
          style: AppFontStyle.body14Regular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(Strings.fechar),
          ),
        ],
      ),
    );
  }

  void _showFreeResumoSheet(BuildContext context, ResultadoEntity element) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Strings.historicoResumoFreeTitulo,
              style: AppFontStyle.headline20Bold,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              element.titulo,
              style: AppFontStyle.body16Medium,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              Strings.percentualHistorico(
                percentual: element.percentual.toStringAsFixed(1),
              ),
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            Text(
              Strings.historicoResumoFreeCorpo,
              style: AppFontStyle.body14Regular,
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            AppButton.primary(
              Strings.plusVerNaLoja,
              onPressed: () {
                Navigator.of(ctx).pop();
                Get.toNamed(Routes.habilitacaoQuizPlus);
              },
            ),
            SizedBox(height: AppSpacingStack.small.value),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, ResultadoEntity element) {
    final percentualLabel = Strings.percentualHistorico(
      percentual: element.percentual.toPrecision(2).toString(),
    );
    final dataLabel = Strings.historicoDataLabel(element.realizadoEm);
    final badge = element.isSimulado
        ? Strings.historicoBadgeSimulado
        : Strings.historicoBadgeTema;

    final cardLabel =
        '${element.titulo}. $badge. $dataLabel. $percentualLabel '
        '${element.totalRespostasCorretas} de ${element.totalPerguntas}';

    return Semantics(
      button: true,
      label: cardLabel,
      child: Material(
        color: AppColors.white,
        child: InkWell(
          onTap: () => _onResultadoTap(context, element),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
            margin: EdgeInsets.symmetric(vertical: AppSpacingStack.nano.value),
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(
                BorderSide(color: AppColors.border),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _badgeChip(badge),
                          if (dataLabel.isNotEmpty) ...[
                            SizedBox(width: AppSpacingStack.nano.value),
                            Text(
                              dataLabel,
                              style: AppFontStyle.caption12Regular
                                  .setColor(AppColors.lightGrey),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: AppSpacingStack.nano.value),
                      Text(
                        element.titulo,
                        style: AppFontStyle.body16Medium,
                      ),
                      Text(
                        percentualLabel,
                        style: AppFontStyle.caption12Regular
                            .setColor(AppColors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSpacingStack.xxxSmall.value),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: AppSpacingStack.large.value +
                          AppSpacingStack.nano.value,
                      child: LinearProgressIndicatorWidget(
                        value: element.percentual / 100,
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
          ),
        ),
      ),
    );
  }

  Widget _badgeChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacingStack.nano.value,
        vertical: AppSpacingStack.quarck.value,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: AppFontStyle.caption12Regular.setColor(AppColors.primary),
      ),
    );
  }
}
