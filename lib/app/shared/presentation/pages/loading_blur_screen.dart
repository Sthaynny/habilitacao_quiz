import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/components/circular_progress_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

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
    return Stack(
      children: <Widget>[
        child,
        AnimatedOpacity(
          opacity: enabled ? 1 : .0,
          duration: const Duration(milliseconds: 280),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: IgnorePointer(
              ignoring: !enabled,
              child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.preto.withValues(alpha: .5),
                  ),
                  child: const Center(
                    child: CircularProgressWidget(),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
