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
          const Size(150, 300),
        ),
        shape: MaterialStateProperty.all(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      onPressed: onPressend,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 150,
          maxHeight: 250,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 30,
              child: Image.asset(
                iconAsset,
                width: 45,
              ),
            ),
            Text(
              titulo,
              style: AppTextStyles.notoSansBold(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
