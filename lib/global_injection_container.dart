import 'package:quiz_car/core/i_injection_conetiner.dart';

abstract class GlobalInjectionContainer {
  static List<IInjectionContiner> get injectionsContainer => [];
  static void setInjection() {
    for (IInjectionContiner item in injectionsContainer) {
      item();
    }
  }
}
