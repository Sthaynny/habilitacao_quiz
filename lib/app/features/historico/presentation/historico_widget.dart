import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
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
                  (element) => Container(),
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
