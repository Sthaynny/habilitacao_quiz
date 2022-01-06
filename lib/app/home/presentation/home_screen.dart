import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/home/presentation/components/car_quiz_widget.dart';
import 'package:quiz_car/app/home/presentation/controller/home_controller.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const CarQuizWidget(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    AppColors.azul.withAlpha(180),
                  ),
                  elevation: MaterialStateProperty.all(3),
                  fixedSize: MaterialStateProperty.all(
                    Size(150.w, 200.h),
                  ),
                  shape: MaterialStateProperty.all(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppImages.legislacao,
                      width: 50.w,
                    ),
                    Text(
                      "Legislação",
                      style: AppTextStyles.notoSansBold(fontSize: 14.ssp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
