import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/detalhe_simulado_screen.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_free_limite_footer.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_list_filter.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
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
  HistoricoFiltroTipo _filtroTipo = HistoricoFiltroTipo.todos;
  HistoricoFiltroDesempenho _filtroDesempenho =
      HistoricoFiltroDesempenho.todos;
  final TextEditingController _buscaController = TextEditingController();

  HistoricoEntity get historico => widget.historico;

  bool get _isPro => Get.find<ProGate>().isPro;

  HistoricoListFilter get _filtroAtivo => HistoricoListFilter(
        tipo: _filtroTipo,
        desempenho:
            _isPro ? _filtroDesempenho : HistoricoFiltroDesempenho.todos,
        busca: _isPro ? _buscaController.text : '',
      );

  List<ResultadoEntity> get _resultadosFiltrados =>
      filtrarEOrdenarHistorico(historico.resutados, _filtroAtivo);

  @override
  void dispose() {
    _buscaController.dispose();
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
                      Semantics(
                        header: true,
                        child: Text(
                          Strings.historico,
                          style: AppFontStyle.headline24Bold,
                        ),
                      ),
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                      _buildFiltroChips(),
                      if (_isPro) ...[
                        SizedBox(height: AppSpacingStack.nano.value),
                        _buildBuscaPro(),
                        SizedBox(height: AppSpacingStack.nano.value),
                        _buildDesempenhoChips(),
                      ],
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                    ],
                  ),
                ),
                if (_resultadosFiltrados.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacingStack.small.value,
                      ),
                      child: Text(
                        Strings.historicoBuscaSemResultados,
                        style: AppFontStyle.body14Regular
                            .setColor(AppColors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildResultCard(
                        context,
                        _resultadosFiltrados[index],
                      ),
                      childCount: _resultadosFiltrados.length,
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: HistoricoFreeLimiteFooter(),
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
          selected: _filtroTipo == HistoricoFiltroTipo.todos,
          onSelected: () =>
              setState(() => _filtroTipo = HistoricoFiltroTipo.todos),
        ),
        _chip(
          label: Strings.historicoFiltroSimulados,
          selected: _filtroTipo == HistoricoFiltroTipo.simulados,
          onSelected: () =>
              setState(() => _filtroTipo = HistoricoFiltroTipo.simulados),
        ),
        _chip(
          label: Strings.historicoFiltroTemas,
          selected: _filtroTipo == HistoricoFiltroTipo.temas,
          onSelected: () =>
              setState(() => _filtroTipo = HistoricoFiltroTipo.temas),
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

  Widget _buildBuscaPro() {
    return Semantics(
      textField: true,
      label: Strings.historicoBuscaHint,
      child: TextField(
        controller: _buscaController,
        onChanged: (_) => setState(() {}),
        style: AppFontStyle.body14Regular,
        decoration: InputDecoration(
          hintText: Strings.historicoBuscaHint,
          hintStyle: AppFontStyle.body14Regular.setColor(AppColors.lightGrey),
          prefixIcon: const Icon(Icons.search, color: AppColors.grey),
          suffixIcon: _buscaController.text.isEmpty
              ? null
              : Semantics(
                  button: true,
                  label: Strings.fechar,
                  child: IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.grey),
                    onPressed: () {
                      _buscaController.clear();
                      setState(() {});
                    },
                  ),
                ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacingStack.nano.value,
            vertical: AppSpacingStack.nano.value,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildDesempenhoChips() {
    return Wrap(
      spacing: AppSpacingStack.nano.value,
      runSpacing: AppSpacingStack.nano.value,
      children: [
        _chip(
          label: Strings.historicoFiltroDesempenhoTodos,
          selected: _filtroDesempenho == HistoricoFiltroDesempenho.todos,
          onSelected: () => setState(
            () => _filtroDesempenho = HistoricoFiltroDesempenho.todos,
          ),
        ),
        _chip(
          label: Strings.historicoFiltroAprovados,
          selected: _filtroDesempenho == HistoricoFiltroDesempenho.aprovados,
          onSelected: () => setState(
            () => _filtroDesempenho = HistoricoFiltroDesempenho.aprovados,
          ),
        ),
        _chip(
          label: Strings.historicoFiltroReprovados,
          selected: _filtroDesempenho == HistoricoFiltroDesempenho.reprovados,
          onSelected: () => setState(
            () => _filtroDesempenho = HistoricoFiltroDesempenho.reprovados,
          ),
        ),
      ],
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
