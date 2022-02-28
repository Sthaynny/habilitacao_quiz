import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class QuizButtonWidget extends StatelessWidget {
  const QuizButtonWidget({
    Key? key,
    required this.titulo,
    this.onPressend,
    required this.iconAsset,
  }) : super(key: key);
  final String titulo;
  final VoidCallback? onPressend;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          AppColors.azul.withAlpha(200),
        ),
        elevation: MaterialStateProperty.all(2),
        fixedSize: MaterialStateProperty.all(
          Size(150.w, 300.h),
        ),
        shape: MaterialStateProperty.all(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
      ),
      onPressed: onPressend,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 150.w,
          maxHeight: 250.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 30,
              child: Image.asset(
                iconAsset,
                width: 45.w,
              ),
            ),
            Text(
              titulo,
              style: AppTextStyles.notoSansBold(fontSize: 14.ssp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
