import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/features/home/presentation/components/car_quiz_widget.dart';
import 'package:quiz_car/app/features/home/presentation/components/quiz_button_widget.dart';
import 'package:quiz_car/app/features/home/presentation/controller/home_controller.dart';
import 'package:quiz_car/core/styles/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: const CarQuizWidget(),
            ),
            SizedBox(
              height: 500.h,
              child: GridView.count(
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                crossAxisCount: 2,
                children: [
                  QuizButtonWidget(
                    onPressend: () {},
                    iconAsset: AppImages.legislacao,
                    titulo: "Legislação",
                  ),
                  QuizButtonWidget(
                    onPressend: () {},
                    iconAsset: AppImages.mecanica,
                    titulo: "Mecânica Básica",
                  ),
                  QuizButtonWidget(
                    onPressend: () {},
                    iconAsset: AppImages.primeirosSocorros,
                    titulo: "Primeiros Socorros",
                  ),
                  QuizButtonWidget(
                    onPressend: () {},
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
