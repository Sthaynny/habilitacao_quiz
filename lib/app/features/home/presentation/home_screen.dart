import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quiz_button_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/app/shared/presentation/pages/loading_blur_screen.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/car_quiz_widget.dart';
import 'package:habilitacao_quiz/app/shared/utils/keys_home.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/components/aligned_grid.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeController controller;

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with PopUpMixin {
  HomeController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(
        () {
          if (controller.isError) {
            popUpErro();
          }
          return LoadingBlurScreen(
            enabled: controller.isLoading,
            child: Container(
              alignment: Alignment.center,
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                gradient: AppGradients.linear,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CarQuizWidget(),
                  AlignedGrid(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      QuizButtonWidget(
                        key: QuizEnum.legislacao.converteKey,
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.legislacao);
                        },
                        iconAsset: AppImages.legislacao,
                        titulo: Strings.legislacao,
                      ),
                      QuizButtonWidget(
                        key: QuizEnum.direcaoDefensiva.converteKey,
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.direcaoDefensiva);
                        },
                        iconAsset: AppImages.direcaoDefensiva,
                        titulo: Strings.direcaoDefesiva,
                      ),
                      QuizButtonWidget(
                        key: QuizEnum.mecanicaBasica.converteKey,
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.mecanicaBasica);
                        },
                        iconAsset: AppImages.mecanica,
                        titulo: Strings.mecanicaBasica,
                      ),
                      QuizButtonWidget(
                        key: QuizEnum.primeirosSocorros.converteKey,
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.primeirosSocorros);
                        },
                        iconAsset: AppImages.primeirosSocorros,
                        titulo: Strings.primeirosSocorros,
                      ),
                      QuizButtonWidget(
                        key: QuizEnum.meioAmbiente.converteKey,
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.meioAmbiente);
                        },
                        iconAsset: AppImages.meioAmbiente,
                        titulo: Strings.meioAmbiente,
                      ),
                      QuizButtonWidget(
                        key: QuizEnum.similado.converteKey,
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.similado);
                        },
                        iconAsset: AppImages.simulado,
                        titulo: Strings.simulado,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
