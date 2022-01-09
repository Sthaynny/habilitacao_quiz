import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/shared/presentation/widgets/primary_button_widget.dart';
import 'package:quiz_car/core/styles/app_styles.dart';
import 'package:share/share.dart';

class ResultadoScreen extends StatelessWidget {
  const ResultadoScreen({
    Key? key,
    required this.titulo,
    required this.totalPerguntas,
    required this.result,
    required this.totalRespostasCorretas,
    required this.percentual,
  }) : super(key: key);
  final String titulo;
  final int totalPerguntas;
  final int totalRespostasCorretas;
  final bool result;
  final int percentual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100.h),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              result ? AppImages.sucesso : AppImages.atencao,
              height: 249.h,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    result
                        ? 'Parabéns!'
                        : 'Oh, que chato!\nVamos melhorar na proxima!',
                    style: AppTextStyles.notoSansBold(
                      color: AppColors.preto,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Você concluiu\n',
                    style: AppTextStyles.notoSansRegular(
                      color: AppColors.preto,
                      fontSize: 13.ssp,
                    ),
                    children: [
                      TextSpan(
                          text: '$titulo\n',
                          style: AppTextStyles.notoSansBold(
                            color: AppColors.preto,
                            fontSize: 13.ssp,
                          )),
                      TextSpan(
                          text:
                              'com $totalRespostasCorretas de $totalPerguntas acertos',
                          style: AppTextStyles.notoSansRegular(
                            color: AppColors.preto,
                            fontSize: 13.ssp,
                          )),
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
                    label: 'Compartilhar',
                    onTap: () {
                      Share.share(
                        '''Dev Quiz - Flutter: Resultado do quiz: $titulo\n obitive $percentual de aproveitamento.''',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: PrimaryButtonWidget.branco(
                    label: 'Voltar ao início',
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
