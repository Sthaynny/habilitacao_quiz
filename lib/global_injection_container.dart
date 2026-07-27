import 'package:flutter/scheduler.dart';
import 'package:habilitacao_quiz/app/features/historico/historico_injection_continer.dart';
import 'package:habilitacao_quiz/app/features/home/home_injection_continer.dart';
import 'package:habilitacao_quiz/app/features/learning/learning_injection_continer.dart';
import 'package:habilitacao_quiz/app/features/questionario/questionario_injection_continer.dart';
import 'package:habilitacao_quiz/app/shared/shared_injection_continer.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

abstract class GlobalInjectionContainer {
  static final List<IInjectionContainer> _bootstrapContainers = [
    SharedInjectionContainer(),
    HomeInjectionContainer(),
    HistoricoInjectionContainer(),
  ];

  static final List<IInjectionContainer> _deferredContainers = [
    QuestionarioInjectionContainer(),
    LearningInjectionContainer(),
  ];

  static List<IInjectionContainer> get injectionsContainer => [
        ..._bootstrapContainers,
        ..._deferredContainers,
      ];

  static void setInjection() {
    for (final item in _bootstrapContainers) {
      item();
    }
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      for (final item in _deferredContainers) {
        item();
      }
    });
  }
}
