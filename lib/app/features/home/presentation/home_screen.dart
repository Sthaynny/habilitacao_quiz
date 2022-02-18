import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/presentation/components/car_quiz_widget.dart';
import 'package:quiz_car/app/features/home/presentation/components/quiz_button_widget.dart';
import 'package:quiz_car/app/features/home/presentation/controller/home_controller.dart';
import 'package:quiz_car/app/shared/presentation/pages/loading_blur_screen.dart';
import 'package:quiz_car/app/shared/utils/quiz_enum.dart';
import 'package:quiz_car/core/components/aligned_grid.dart';
import 'package:quiz_car/core/mixins/pop_up_mixin.dart';
import 'package:quiz_car/core/styles/app_styles.dart';
import 'package:quiz_car/core/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with PopUpMixin {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetX<HomeController>(
        init: controller,
        builder: (controller) {
          if (controller.homeState.value == HomeState.erro) {
            popUpErro();
          }
          return LoadingBlurScreen(
            enabled: controller.homeState.value == HomeState.carregando,
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
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.legislacao);
                        },
                        iconAsset: AppImages.legislacao,
                        titulo: Strings.legislacao,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.direcaoDefensiva);
                        },
                        iconAsset: AppImages.direcaoDefensiva,
                        titulo: Strings.direcaoDefesiva,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.mecanicaBasica);
                        },
                        iconAsset: AppImages.mecanica,
                        titulo: Strings.mecanicaBasica,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.primeirosSocorros);
                        },
                        iconAsset: AppImages.primeirosSocorros,
                        titulo: Strings.primeirosSocorros,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          controller.irParaPagina(QuizEnum.meioAmbiente);
                        },
                        iconAsset: AppImages.meioAmbiente,
                        titulo: Strings.meioAmbiente,
                      ),
                      QuizButtonWidget(
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
