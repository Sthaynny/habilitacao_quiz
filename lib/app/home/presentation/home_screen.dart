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
            children: const [
              CarQuizWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
