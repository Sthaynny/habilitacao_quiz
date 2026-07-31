import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_export_format.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/export_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/export_historico_backup_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/restaurar_historico_backup_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/ihistorico_backup_file_gateway.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/detalhe_simulado_screen.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/widgets/historico_empty_state.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/widgets/historico_filtro_chip.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/widgets/historico_list_plus_footer.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/widgets/historico_resultado_list_card.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_materia_dashboard.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_list_filter.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:share_plus/share_plus.dart';

class HistoricoWidget extends StatefulWidget {
  const HistoricoWidget({
    super.key,
    required this.historico,
    this.onIniciarQuiz,
  });
  final HistoricoEntity historico;
  final VoidCallback? onIniciarQuiz;

  @override
  State<HistoricoWidget> createState() => _HistoricoWidgetState();
}

class _HistoricoWidgetState extends State<HistoricoWidget> with PopUpMixin {
  HistoricoFiltroTipo _filtroTipo = HistoricoFiltroTipo.todos;
  HistoricoFiltroDesempenho _filtroDesempenho =
      HistoricoFiltroDesempenho.todos;
  final TextEditingController _buscaController = TextEditingController();
  bool _backupBusy = false;
  bool _isExporting = false;
  late List<ResultadoEntity> _resultadosFiltrados;

  HistoricoEntity get historico => widget.historico;

  bool get _isPro => Get.find<ProGate>().isPro;

  HistoricoListFilter get _filtroAtivo => HistoricoListFilter(
        tipo: _filtroTipo,
        desempenho:
            _isPro ? _filtroDesempenho : HistoricoFiltroDesempenho.todos,
        busca: _isPro ? _buscaController.text : '',
      );

  @override
  void initState() {
    super.initState();
    _atualizarResultadosFiltrados();
  }

  @override
  void didUpdateWidget(covariant HistoricoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.historico != widget.historico) {
      _atualizarResultadosFiltrados();
    }
  }

  void _atualizarResultadosFiltrados() {
    _resultadosFiltrados =
        filtrarEOrdenarHistorico(historico.resutados, _filtroAtivo);
  }

  void _onFiltroAlterado(VoidCallback alterar) {
    setState(() {
      alterar();
      _atualizarResultadosFiltrados();
    });
  }

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
                        _buildExportProActions(),
                        SizedBox(height: AppSpacingStack.nano.value),
                        _buildBackupSection(),
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
                      (context, index) {
                        final item = _resultadosFiltrados[index];
                        return RepaintBoundary(
                          key: ValueKey(item.id),
                          child: HistoricoResultadoListCard(
                            resultado: item,
                            onTap: () => _onResultadoTap(context, item),
                          ),
                        );
                      },
                      childCount: _resultadosFiltrados.length,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: HistoricoListPlusFooter(),
                ),
              ],
            ),
    );
  }

  Widget _buildBackupSection() {
    final disabled = _backupBusy || _isExporting;
    return Semantics(
      container: true,
      label: Strings.historicoBackupSecaoTitulo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Strings.historicoBackupSecaoTitulo,
            style: AppFontStyle.body16Medium,
          ),
          SizedBox(height: AppSpacingStack.quarck.value),
          Text(
            Strings.historicoBackupSecaoSubtitulo,
            style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          if (_backupBusy) ...[
            const LinearProgressIndicator(
              minHeight: 2,
              color: AppColors.primary,
              backgroundColor: AppColors.border,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
          ],
          AppButton.primary(
            Strings.historicoBackupExport,
            expanded: true,
            onPressed: disabled ? null : _onExportBackup,
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          AppButton.primaryOutline(
            Strings.historicoBackupRestore,
            expanded: true,
            color: AppColors.primary,
            onPressed: disabled ? null : _onRestoreBackup,
          ),
        ],
      ),
    );
  }

  Widget _buildExportProActions() {
    return Row(
      children: [
        Expanded(
          child: AppButton.link(
            Strings.historicoExportCsv,
            onPressed: _isExporting || _backupBusy
                ? null
                : () => _exportHistorico(HistoricoExportFormat.csv),
          ),
        ),
        SizedBox(width: AppSpacingStack.nano.value),
        Expanded(
          child: AppButton.link(
            Strings.historicoExportPdf,
            onPressed: _isExporting || _backupBusy
                ? null
                : () => _exportHistorico(HistoricoExportFormat.pdf),
          ),
        ),
      ],
    );
  }

  Future<void> _exportHistorico(HistoricoExportFormat format) async {
    if (_isExporting) return;
    setState(() => _isExporting = true);
    try {
      final result = await Get.find<ExportHistoricoUsecase>().call(
        resultados: _resultadosFiltrados,
        format: format,
      );
      final failure = result.failure;
      if (failure == ExportHistoricoFailure.proRequired) {
        Get.toNamed(Routes.habilitacaoQuizPlus);
        return;
      }
      if (failure == ExportHistoricoFailure.empty) {
        Get.snackbar(Strings.atencao, Strings.historicoExportVazio);
        return;
      }
      if (failure == ExportHistoricoFailure.ioError) {
        Get.snackbar(Strings.atencao, Strings.historicoExportErro);
        return;
      }
      final file = result.file!;
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, name: file.filename)],
          subject: Strings.historicoExportAssunto,
        ),
      );
    } catch (_) {
      Get.snackbar(Strings.atencao, Strings.historicoExportErro);
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
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
      Get.snackbar(Strings.atencao, Strings.historicoBackupExportErro);
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
          setState(_atualizarResultadosFiltrados);
          Get.snackbar(
            Strings.historico,
            Strings.historicoBackupRestoreSucesso,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } catch (_) {
      Get.snackbar(Strings.atencao, Strings.historicoBackupRestoreErro);
    } finally {
      if (mounted) setState(() => _backupBusy = false);
    }
  }

  Widget _buildFiltroChips() {
    return Wrap(
      spacing: AppSpacingStack.nano.value,
      runSpacing: AppSpacingStack.nano.value,
      children: [
        HistoricoFiltroChip(
          label: Strings.historicoFiltroTodos,
          selected: _filtroTipo == HistoricoFiltroTipo.todos,
          onSelected: () => _onFiltroAlterado(
            () => _filtroTipo = HistoricoFiltroTipo.todos,
          ),
        ),
        HistoricoFiltroChip(
          label: Strings.historicoFiltroSimulados,
          selected: _filtroTipo == HistoricoFiltroTipo.simulados,
          onSelected: () => _onFiltroAlterado(
            () => _filtroTipo = HistoricoFiltroTipo.simulados,
          ),
        ),
        HistoricoFiltroChip(
          label: Strings.historicoFiltroTemas,
          selected: _filtroTipo == HistoricoFiltroTipo.temas,
          onSelected: () => _onFiltroAlterado(
            () => _filtroTipo = HistoricoFiltroTipo.temas,
          ),
        ),
      ],
    );
  }

  Widget _buildBuscaPro() {
    return Semantics(
      textField: true,
      label: Strings.historicoBuscaHint,
      child: TextField(
        controller: _buscaController,
        onChanged: (_) => _onFiltroAlterado(() {}),
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
                      _onFiltroAlterado(() {});
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
        HistoricoFiltroChip(
          label: Strings.historicoFiltroDesempenhoTodos,
          selected: _filtroDesempenho == HistoricoFiltroDesempenho.todos,
          onSelected: () => _onFiltroAlterado(
            () => _filtroDesempenho = HistoricoFiltroDesempenho.todos,
          ),
        ),
        HistoricoFiltroChip(
          label: Strings.historicoFiltroAprovados,
          selected: _filtroDesempenho == HistoricoFiltroDesempenho.aprovados,
          onSelected: () => _onFiltroAlterado(
            () => _filtroDesempenho = HistoricoFiltroDesempenho.aprovados,
          ),
        ),
        HistoricoFiltroChip(
          label: Strings.historicoFiltroReprovados,
          selected: _filtroDesempenho == HistoricoFiltroDesempenho.reprovados,
          onSelected: () => _onFiltroAlterado(
            () => _filtroDesempenho = HistoricoFiltroDesempenho.reprovados,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return HistoricoEmptyState(
      onIniciarQuiz: widget.onIniciarQuiz ?? () {},
      showBackup: _isPro,
      backupSection: _isPro ? _buildBackupSection() : null,
    );
  }

  void _onResultadoTap(BuildContext context, ResultadoEntity element) {
    final proGate = Get.find<ProGate>();
    final detalhe = element.detalhePerguntas;
    if (proGate.isPro && detalhe != null && detalhe.isNotEmpty) {
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
            Semantics(
              header: true,
              child: Text(
                Strings.historicoResumoFreeTitulo,
                style: AppFontStyle.headline20Bold,
              ),
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
            Semantics(
              button: true,
              label: Strings.plusVerNaLoja,
              hint: Strings.plusBannerHint,
              excludeSemantics: true,
              child: AppButton.primary(
                Strings.plusVerNaLoja,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Get.toNamed(Routes.habilitacaoQuizPlus);
                },
              ),
            ),
            SizedBox(height: AppSpacingStack.small.value),
          ],
        ),
      ),
    );
  }

}
