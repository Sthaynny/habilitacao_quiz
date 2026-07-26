import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/export_historico_backup_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/restaurar_historico_backup_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/ihistorico_backup_file_gateway.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/detalhe_simulado_screen.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_materia_dashboard.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_list_filter.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
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

class _HistoricoWidgetState extends State<HistoricoWidget> with PopUpMixin {
  HistoricoFiltroTipo _filtroTipo = HistoricoFiltroTipo.todos;
  HistoricoFiltroDesempenho _filtroDesempenho =
      HistoricoFiltroDesempenho.todos;
  final TextEditingController _buscaController = TextEditingController();
  bool _backupBusy = false;

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
                      HistoricoMateriaDashboard(
                        resultados: historico.resutados,
                      ),
                      _buildFiltroChips(),
                      if (_isPro) ...[
                        SizedBox(height: AppSpacingStack.nano.value),
                        _buildBuscaPro(),
                        SizedBox(height: AppSpacingStack.nano.value),
                        _buildDesempenhoChips(),
                        SizedBox(height: AppSpacingStack.nano.value),
                        _buildBackupActions(),
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

  Widget _buildBackupActions() {
    return Row(
      children: [
        Expanded(
          child: AppButton.link(
            Strings.historicoBackupExport,
            onPressed: _backupBusy ? null : _onExportBackup,
          ),
        ),
        Expanded(
          child: AppButton.link(
            Strings.historicoBackupRestore,
            onPressed: _backupBusy ? null : _onRestoreBackup,
          ),
        ),
      ],
    );
  }

  Future<void> _onExportBackup() async {
    setState(() => _backupBusy = true);
    try {
      final result = Get.find<ExportHistoricoBackupUsecase>().call(historico);
      await result.fold(
        (e) async {
          Get.snackbar(Strings.historico, e.menssagem);
        },
        (json) async {
          await Get.find<IHistoricoBackupFileGateway>().shareBackupFile(
            jsonContent: json,
          );
          Get.snackbar(
            Strings.historico,
            Strings.historicoBackupExportSucesso,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } catch (_) {
      popUpErro();
    } finally {
      if (mounted) setState(() => _backupBusy = false);
    }
  }

  Future<void> _onRestoreBackup() async {
    final confirm = await Get.defaultDialog<bool>(
      title: Strings.historicoBackupRestoreConfirmTitulo,
      titleStyle: AppFontStyle.headline20Bold,
      middleText: Strings.historicoBackupRestoreConfirmCorpo,
      middleTextStyle: AppFontStyle.body14Regular,
      textConfirm: Strings.sim,
      textCancel: Strings.nao,
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    );
    if (confirm != true) return;

    setState(() => _backupBusy = true);
    try {
      final content =
          await Get.find<IHistoricoBackupFileGateway>().pickBackupFileContent();
      if (content == null) return;

      final result = await Get.find<RestaurarHistoricoBackupUsecase>().call(
        jsonContent: content,
        historicoEmMemoria: historico,
      );
      result.fold(
        (e) => Get.snackbar(Strings.historico, e.menssagem),
        (_) {
          setState(() {});
          Get.snackbar(
            Strings.historico,
            Strings.historicoBackupRestoreSucesso,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } catch (_) {
      popUpErro();
    } finally {
      if (mounted) setState(() => _backupBusy = false);
    }
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
