import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:quiz_car/core/styles/app_styles.dart';

class CarQuizWidget extends StatelessWidget {
  const CarQuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logo,
            width: 70.w,
          ),
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Text(
              "Car Quiz",
              style: AppTextStyles.notoSansExtraBold(fontSize: 30.ssp),
            ),
          ),
        ],
      ),
    );
  }
}
