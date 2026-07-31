import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/components/circular_progress_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LoadingBlurScreen extends StatelessWidget {
  const LoadingBlurScreen({
    required this.child,
    this.enabled = false,
    super.key,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child,
        Positioned.fill(
          child: Semantics(
            label: Strings.carregando,
            liveRegion: true,
            child: ExcludeSemantics(
              child: RepaintBoundary(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: ColoredBox(
                    color: AppColors.preto.withValues(alpha: .5),
                    child: const Center(child: CircularProgressWidget()),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
