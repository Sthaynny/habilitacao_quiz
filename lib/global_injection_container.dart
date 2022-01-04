import 'package:quiz_car/core/i_injection_conetiner.dart';

abstract class GlobalInjectionContainer {
  static List<IInjectionContainer> get injectionsContainer => [];
  static void setInjection() {
    for (IInjectionContainer item in injectionsContainer) {
      item();
    }
  }
}
