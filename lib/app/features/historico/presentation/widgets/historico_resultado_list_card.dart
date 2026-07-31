import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/components/linerar_progress.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HistoricoResultadoListCard extends StatelessWidget {
  const HistoricoResultadoListCard({
    super.key,
    required this.resultado,
    required this.onTap,
  });

  final ResultadoEntity resultado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final element = resultado;
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Container(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              margin: EdgeInsets.symmetric(vertical: AppSpacingStack.nano.value),
              decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                  BorderSide(color: AppColors.border),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExcludeSemantics(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _HistoricoBadgeChip(text: badge),
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
                        softWrap: true,
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
        ),
      ),
    );
  }
}

class _HistoricoBadgeChip extends StatelessWidget {
  const _HistoricoBadgeChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
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
      ),
    );
  }
}
