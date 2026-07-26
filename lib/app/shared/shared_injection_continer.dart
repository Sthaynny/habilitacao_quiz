import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/simulado_quota_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/repositories/quiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/simulado_quota_service.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class SharedInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<PromoFunnelAnalytics>(
      () => const DebugPromoFunnelAnalytics(),
      fenix: true,
    );
    Get.lazyPut<ProGate>(() => const CompileTimeProGate(), fenix: true);
    Get.lazyPut<QuizDatasource>(() => QuizDatasource(), fenix: true);
    Get.lazyPut<IQuizRepository>(
      () => QuizRepository(Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<SimuladoQuotaDatasource>(
      () => SimuladoQuotaDatasource(),
      fenix: true,
    );
    Get.lazyPut<SimuladoQuotaService>(
      () => SimuladoQuotaService(Get.find(), Get.find()),
      fenix: true,
    );
  }
}
