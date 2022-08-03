import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:share/share.dart';

class ResultadoScreen extends StatelessWidget {
  const ResultadoScreen({
    Key? key,
    required this.args,
  }) : super(key: key);
  final ResultadoEntity args;

  String get getPercentual => args.percentual.toPrecision(2).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: AppSpacingStack.xxxLarge.value),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              args.result ? AppImages.sucesso : AppImages.bad,
              height: 300,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpacingStack.small.value),
                  child: Text(
                    args.result
                        ? Strings.parabens
                        : Strings.menssagemBaixoRendimento,
                    style: AppFontStyle.headline20Bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: AppSpacingStack.xxxSmall.value,
                ),
                Text.rich(
                  TextSpan(
                    text: Strings.voceFinalizou,
                    style: AppFontStyle.body14Regular,
                    children: [
                      TextSpan(
                        text: '${args.titulo}\n',
                        style: AppFontStyle.body14Bold,
                      ),
                      TextSpan(
                        text: Strings.resultadoQuestionario(
                          respostasCorretas:
                              args.totalRespostasCorretas.toString(),
                          totalPerguntas: args.totalPerguntas.toString(),
                          percentual: getPercentual,
                        ),
                        style: AppFontStyle.body14Regular,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingStack.large.value,
                  ),
                  child: AppButton.primary(
                    Strings.compartilhar,
                    onPressed: () {
                      Share.share(
                        Strings.campartilharMensagem(
                          titulo: args.titulo,
                          percentual: getPercentual,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSpacingStack.xxSmall.value),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpacingStack.large.value),
                  child: AppButton.link(
                    Strings.voltarInicio,
                    onPressed: Get.back,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
