import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

enum _GabaritoFiltro { todas, erros, acertos }

class DetalheSimuladoScreen extends StatefulWidget {
  const DetalheSimuladoScreen({super.key, required this.resultado});

  final ResultadoEntity resultado;

  @override
  State<DetalheSimuladoScreen> createState() => _DetalheSimuladoScreenState();
}

class _DetalheSimuladoScreenState extends State<DetalheSimuladoScreen> {
  _GabaritoFiltro _filtro = _GabaritoFiltro.todas;

  List<ResultadoPerguntaDetalheEntity> get _detalhes =>
      widget.resultado.detalhePerguntas ?? const [];

  List<ResultadoPerguntaDetalheEntity> get _filtrados {
    return switch (_filtro) {
      _GabaritoFiltro.todas => _detalhes,
      _GabaritoFiltro.erros => _detalhes.where((e) => !e.acertou).toList(),
      _GabaritoFiltro.acertos => _detalhes.where((e) => e.acertou).toList(),
    };
  }

  int get _acertos => _detalhes.where((e) => e.acertou).length;

  @override
  Widget build(BuildContext context) {
    final detalhes = _detalhes;
    final filtrados = _filtrados;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.historicoDetalheTitulo,
          style: AppFontStyle.headline20Bold,
        ),
      ),
      body: detalhes.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacingStack.small.value),
                child: Text(
                  Strings.historicoSemDetalhe,
                  style: AppFontStyle.body16Regular.setColor(AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacingStack.xxxSmall.value,
                    AppSpacingStack.xxxSmall.value,
                    AppSpacingStack.xxxSmall.value,
                    0,
                  ),
                  child: _GabaritoResumoCard(
                    titulo: widget.resultado.titulo,
                    acertos: _acertos,
                    total: detalhes.length,
                    percentual: widget.resultado.percentual,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingStack.xxxSmall.value,
                    vertical: AppSpacingStack.nano.value,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FiltroChip(
                          label: Strings.gabaritoFiltroTodas,
                          selected: _filtro == _GabaritoFiltro.todas,
                          onTap: () =>
                              setState(() => _filtro = _GabaritoFiltro.todas),
                        ),
                        SizedBox(width: AppSpacingStack.nano.value),
                        _FiltroChip(
                          label: Strings.gabaritoFiltroErros,
                          selected: _filtro == _GabaritoFiltro.erros,
                          onTap: () =>
                              setState(() => _filtro = _GabaritoFiltro.erros),
                        ),
                        SizedBox(width: AppSpacingStack.nano.value),
                        _FiltroChip(
                          label: Strings.gabaritoFiltroAcertos,
                          selected: _filtro == _GabaritoFiltro.acertos,
                          onTap: () => setState(
                            () => _filtro = _GabaritoFiltro.acertos,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: filtrados.isEmpty
                      ? Center(
                          child: Text(
                            Strings.gabaritoFiltroVazio,
                            style: AppFontStyle.body14Regular.setColor(
                              AppColors.grey,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(
                            AppSpacingStack.xxxSmall.value,
                          ),
                          itemCount: filtrados.length,
                          separatorBuilder: (_, _) =>
                              SizedBox(height: AppSpacingStack.nano.value),
                          itemBuilder: (context, index) {
                            final item = filtrados[index];
                            final originalIndex =
                                detalhes.indexOf(item) + 1;
                            return RepaintBoundary(
                              child: _PerguntaDetalheCard(
                                key: ValueKey(
                                  'detalhe-$originalIndex-${item.perguntaTitulo}',
                                ),
                                index: originalIndex,
                                item: item,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class _GabaritoResumoCard extends StatelessWidget {
  const _GabaritoResumoCard({
    required this.titulo,
    required this.acertos,
    required this.total,
    required this.percentual,
  });

  final String titulo;
  final int acertos;
  final int total;
  final double percentual;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
      decoration: BoxDecoration(
        color: AppColors.cinzaSuperClaro,
        borderRadius: BorderRadius.circular(10),
        border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: AppFontStyle.body16Bold),
          SizedBox(height: AppSpacingStack.nano.value),
          Text(
            Strings.gabaritoResumo(acertos: acertos, total: total),
            style: AppFontStyle.body14Regular,
          ),
          Text(
            Strings.percentualHistorico(
              percentual: percentual.toStringAsFixed(1),
            ),
            style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
          ),
        ],
      ),
    );
  }
}

class _FiltroChip extends StatelessWidget {
  const _FiltroChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        labelStyle: AppFontStyle.body14Regular.setColor(
          selected ? AppColors.primary : AppColors.black,
        ),
      ),
    );
  }
}

class _PerguntaDetalheCard extends StatelessWidget {
  const _PerguntaDetalheCard({
    super.key,
    required this.index,
    required this.item,
  });

  final int index;
  final ResultadoPerguntaDetalheEntity item;

  @override
  Widget build(BuildContext context) {
    final status = item.acertou ? 'Acertou' : 'Errou';
    final explicacao = item.explicacao?.trim();
    final label = StringBuffer(
      'Questão $index. ${item.perguntaTitulo}. $status. '
      'Sua resposta: ${item.respostaEscolhidaTitulo ?? Strings.nao}. '
      'Gabarito: ${item.respostaCorretaTitulo}',
    );
    if (explicacao != null && explicacao.isNotEmpty) {
      label.write('. ${Strings.explicacaoGabarito}: $explicacao');
    }

    return Semantics(
      label: label.toString(),
      child: Container(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        decoration: BoxDecoration(
          border: Border.all(
            color: item.acertou ? AppColors.border : AppColors.primary,
            width: item.acertou ? 1 : 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: item.acertou ? AppColors.white : AppColors.cinzaSuperClaro,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  item.acertou ? Icons.check_circle : Icons.cancel,
                  color: item.acertou ? AppColors.secondary : AppColors.primary,
                  size: 20,
                ),
                SizedBox(width: AppSpacingStack.nano.value),
                Expanded(
                  child: Text(
                    'Questão $index',
                    style: AppFontStyle.body16Medium,
                  ),
                ),
                if (item.materiaTitulo != null)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.grey.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacingStack.quarck.value,
                        vertical: 2,
                      ),
                      child: Text(
                        item.materiaTitulo!,
                        style: AppFontStyle.caption12Regular.setColor(
                          AppColors.grey,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              item.perguntaTitulo,
              style: AppFontStyle.body14Regular,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              'Sua resposta: ${item.respostaEscolhidaTitulo ?? '—'}',
              style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
            ),
            Text(
              'Gabarito: ${item.respostaCorretaTitulo}',
              style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
            ),
            if (explicacao != null && explicacao.isNotEmpty) ...[
              SizedBox(height: AppSpacingStack.nano.value),
              Text(
                Strings.explicacaoGabarito,
                style: AppFontStyle.body14Bold,
              ),
              Text(
                explicacao,
                style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
