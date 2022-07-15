import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/resultado/resultado_args.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/primary_button_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:share/share.dart';

class ResultadoScreen extends StatelessWidget {
  const ResultadoScreen({
    Key? key,
    required this.args,
  }) : super(key: key);
  final ResultadoArgs args;

  String get getPercentual => args.percentual.toPrecision(2).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              args.result ? AppImages.sucesso : AppImages.atencao,
              height: 180,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    args.result ? Strings.parabens : Strings.menssgemTriste,
                    style: AppTextStyles.notoSansBold(
                      color: AppColors.preto,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    text: Strings.voceFinalizou,
                    style: AppTextStyles.notoSansRegular(
                      color: AppColors.preto,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                          text: '${args.titulo}\n',
                          style: AppTextStyles.notoSansBold(
                            color: AppColors.preto,
                            fontSize: 13,
                          )),
                      TextSpan(
                        text: Strings.resultadoQuestionario(
                          respostasCorretas:
                              args.totalRespostasCorretas.toString(),
                          totalPerguntas: args.totalPerguntas.toString(),
                          percentual: getPercentual,
                        ),
                        style: AppTextStyles.notoSansRegular(
                          color: AppColors.preto,
                          fontSize: 13,
                        ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: PrimaryButtonWidget.azul(
                    label: Strings.compartilhar,
                    onTap: () {
                      Share.share(
                        Strings.campartilharMensagem(
                          titulo: args.titulo,
                          percentual: getPercentual,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: PrimaryButtonWidget.branco(
                    label: Strings.voltarInicio,
                    onTap: () {
                      Get.back();
                    },
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
