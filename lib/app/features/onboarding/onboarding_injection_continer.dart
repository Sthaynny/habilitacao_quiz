import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/onboarding/data/onboarding_datasource.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class OnboardingInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<OnboardingDatasource>(() => OnboardingDatasource(), fenix: true);
  }
}
