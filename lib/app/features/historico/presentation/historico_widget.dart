import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/linear_progress_indicator.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';
import 'package:habilitacao_quiz/core/styles/app_font_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HistoricoWidget extends StatefulWidget {
  const HistoricoWidget({
    Key? key,
    required this.historico,
  }) : super(key: key);
  final HistoricoEntity historico;

  @override
  State<HistoricoWidget> createState() => _HistoricoWidgetState();
}

class _HistoricoWidgetState extends State<HistoricoWidget> {
  HistoricoEntity get historico => widget.historico;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacingStack.xSmall.value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.historico,
            style: AppFontStyle.headline24Bold,
          ),
          ...body
        ],
      ),
    );
  }

  List<Widget> get body {
    if (historico.resutados.isNotEmpty) {
      return [
        SingleChildScrollView(
          child: Column(
            children: historico.resutados
                .map(
                  (element) => Container(
                    padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
                    margin: EdgeInsets.symmetric(
                        vertical: AppSpacingStack.nano.value),
                    decoration: BoxDecoration(
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: AppColors.border,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '${element.titulo}\n',
                            style: AppFontStyle.body16Medium,
                            children: [
                              TextSpan(
                                text: Strings.percentualHistorico(
                                  percentual: element.percentual
                                      .toPrecision(2)
                                      .toString(),
                                ),
                                style: AppFontStyle.caption12Regular,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 70,
                              child: LinearProgressIndicatorWidget(
                                value: element.percentual / 100,
                              ),
                            ),
                            SizedBox(
                              height: AppSpacingStack.nano.value,
                            ),
                            Text(
                              '${element.totalRespostasCorretas} de ${element.totalPerguntas}',
                              style: AppFontStyle.caption12Regular
                                  .setColor(AppColors.lightGrey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ];
    }
    return [
      const Spacer(),
      Text(
        Strings.comeceEstudosVizualizarProgresso,
        style: AppFontStyle.body16Medium,
        textAlign: TextAlign.center,
      ),
      const Spacer(),
    ];
  }
}
