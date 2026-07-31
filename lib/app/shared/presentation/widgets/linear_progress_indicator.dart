import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  const LinearProgressIndicatorWidget({super.key, required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    final percentual = (value.clamp(0.0, 1.0) * 100).round();

    return Semantics(
      label: Strings.progressoQuestoes(percentual),
      value: '$percentual%',
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: AppColors.cinzaSuperClaro,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.verde),
          ),
        ),
      ),
    );
  }
}
