import 'package:quiz_car/app/features/home/home_injection_continer.dart';
import 'package:quiz_car/core/i_injection_conetiner.dart';

abstract class GlobalInjectionContainer {
  static List<IInjectionContainer> get injectionsContainer => [
        HomeInjectionContainer(),
      ];

  static void setInjection() {
    for (IInjectionContainer item in injectionsContainer) {
      item();
    }
  }
}
