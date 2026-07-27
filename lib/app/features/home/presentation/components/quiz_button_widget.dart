import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class QuizButtonWidget extends StatelessWidget {
  const QuizButtonWidget({
    super.key,
    required this.titulo,
    this.onPressend,
    required this.iconAsset,
  });
  final String titulo;
  final VoidCallback? onPressend;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          AppColors.azul.withAlpha(200),
        ),
        elevation: WidgetStateProperty.all(2),
        fixedSize: WidgetStateProperty.all(
          const Size(150, 300),
        ),
        shape: WidgetStateProperty.all(
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
              color: AppColors.white.withValues(alpha: 0),
              elevation: 30,
              child: Image.asset(
                iconAsset,
                width: 45,
                cacheWidth: _imageCachePx(context, 45),
                excludeFromSemantics: true,
              ),
            ),
            Text(
              titulo,
              style: AppFontStyle.body14Regular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static int _imageCachePx(BuildContext context, double logicalSize) {
    return (logicalSize * MediaQuery.devicePixelRatioOf(context)).round();
  }
}
