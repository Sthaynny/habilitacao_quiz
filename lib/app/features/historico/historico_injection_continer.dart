import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/data/datasources/historico_datasource.dart';
import 'package:habilitacao_quiz/app/features/historico/data/datasources/historico_export_datasource.dart';
import 'package:habilitacao_quiz/app/features/historico/data/repositories/historico_export_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/data/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/i_historico_export_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/historico_export_content_builder.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/export_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/get_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/simulado_weekly_analytics.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class HistoricoInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut(
      () => HistoricoDatasource(),
      fenix: true,
    );
    Get.lazyPut<IHistoricoRepository>(
      () => HistoricoRepository(
        Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => GetHistoricoUsecase(Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => SalvarHistoricoUsecase(
        Get.find(),
        Get.find<ProGate>(),
        Get.find<SimuladoWeeklyAnalytics>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => HistoricoExportDatasource(),
      fenix: true,
    );
    Get.lazyPut<IHistoricoExportRepository>(
      () => HistoricoExportRepository(Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => const HistoricoExportContentBuilder(),
      fenix: true,
    );
    Get.lazyPut(
      () => ExportHistoricoUsecase(
        Get.find<ProGate>(),
        Get.find<IHistoricoExportRepository>(),
        Get.find<HistoricoExportContentBuilder>(),
      ),
      fenix: true,
    );
  }
}
