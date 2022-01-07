import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/presentation/components/car_quiz_widget.dart';
import 'package:quiz_car/app/features/home/presentation/components/quiz_button_widget.dart';
import 'package:quiz_car/app/features/home/presentation/controller/home_controller.dart';
import 'package:quiz_car/core/mixins/em_breve.dart';
import 'package:quiz_car/core/styles/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with EmBreve {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 70.h,
              margin: EdgeInsets.fromLTRB(0, 40.h, 0, 10.h),
              child: const CarQuizWidget(),
            ),
            SizedBox(
              height: size.height - 130.h,
              child: GridView.count(
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                crossAxisCount: 2,
                children: [
                  QuizButtonWidget(
                    onPressend: () {
                      bottomSheetEmBreve(context);
                    },
                    iconAsset: AppImages.legislacao,
                    titulo: "Legislação",
                  ),
                  QuizButtonWidget(
                    onPressend: () {
                      bottomSheetEmBreve(context);
                    },
                    iconAsset: AppImages.direcaoDefensiva,
                    titulo: "Direção defensiva",
                  ),
                  QuizButtonWidget(
                    onPressend: () {
                      bottomSheetEmBreve(context);
                    },
                    iconAsset: AppImages.mecanica,
                    titulo: "Mecânica Básica",
                  ),
                  QuizButtonWidget(
                    onPressend: () {
                      bottomSheetEmBreve(context);
                    },
                    iconAsset: AppImages.primeirosSocorros,
                    titulo: "Primeiros Socorros",
                  ),
                  QuizButtonWidget(
                    onPressend: () {
                      bottomSheetEmBreve(context);
                    },
                    iconAsset: AppImages.aleatoria,
                    titulo: "Aleatórias",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
