import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_list_filter.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

enum _HistoricoFiltro { todos, simulados, temas }

extension on _HistoricoFiltro {
  HistoricoFiltroTipo get asDomain {
    switch (this) {
      case _HistoricoFiltro.todos:
        return HistoricoFiltroTipo.todos;
      case _HistoricoFiltro.simulados:
        return HistoricoFiltroTipo.simulados;
      case _HistoricoFiltro.temas:
        return HistoricoFiltroTipo.temas;
    }
  }
}

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

  List<ResultadoEntity> get _resultadosFiltrados =>
      filtrarEOrdenarHistorico(historico.resutados, _filtro.asDomain);

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

  Widget _buildResultCard(ResultadoEntity element) {
    final percentualLabel = Strings.percentualHistorico(
      percentual: element.percentual.toPrecision(2).toString(),
    );

    final cardLabel =
        '${element.titulo}. $percentualLabel '
        '${element.totalRespostasCorretas} de ${element.totalPerguntas}';

    return Semantics(
      label: cardLabel,
      child: ExcludeSemantics(
        child: Container(
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
    );
  }
}
