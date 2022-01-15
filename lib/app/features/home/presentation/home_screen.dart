import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/presentation/components/car_quiz_widget.dart';
import 'package:quiz_car/app/features/home/presentation/components/quiz_button_widget.dart';
import 'package:quiz_car/app/features/home/presentation/controller/home_controller.dart';
import 'package:quiz_car/app/features/shared/presentation/pages/loading_blur_screen.dart';
import 'package:quiz_car/app/features/shared/utils/quiz_enum.dart';
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
                          popUpEmBreve();
                        },
                        iconAsset: AppImages.mecanica,
                        titulo: Strings.mecanicaBasica,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          popUpEmBreve();
                        },
                        iconAsset: AppImages.primeirosSocorros,
                        titulo: Strings.primeirosSocorros,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          popUpEmBreve();
                        },
                        iconAsset: AppImages.meioAmbiente,
                        titulo: Strings.meioAmbiente,
                      ),
                      QuizButtonWidget(
                        onPressend: () {
                          popUpEmBreve();
                        },
                        iconAsset: AppImages.aleatoria,
                        titulo: Strings.aleatorias,
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
