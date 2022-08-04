import 'package:habilitacao_quiz/app/features/historico/historico_injection_continer.dart';
import 'package:habilitacao_quiz/app/features/home/home_injection_continer.dart';
import 'package:habilitacao_quiz/app/features/questionario/questionario_injection_continer.dart';
import 'package:habilitacao_quiz/app/shared/shared_injection_continer.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

abstract class GlobalInjectionContainer {
  static List<IInjectionContainer> get injectionsContainer => [
        SharedInjectionContainer(),
        HomeInjectionContainer(),
        QuestionarioInjectionContainer(),
        HistoricoInjectionContainer(),
      ];

  static void setInjection() {
    for (IInjectionContainer item in injectionsContainer) {
      item();
    }
  }
}
