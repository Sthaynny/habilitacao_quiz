import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class DetalheSimuladoScreen extends StatelessWidget {
  const DetalheSimuladoScreen({super.key, required this.resultado});

  final ResultadoEntity resultado;

  @override
  Widget build(BuildContext context) {
    final detalhes = resultado.detalhePerguntas ?? const [];

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
          : ListView.separated(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              itemCount: detalhes.length,
              separatorBuilder: (_, _) =>
                  SizedBox(height: AppSpacingStack.nano.value),
              itemBuilder: (context, index) => RepaintBoundary(
                child: _PerguntaDetalheCard(
                  key: ValueKey('detalhe-$index-${detalhes[index].perguntaTitulo}'),
                  index: index + 1,
                  item: detalhes[index],
                ),
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
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
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
