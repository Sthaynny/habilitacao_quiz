import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/data/datasources/historico_datasource.dart';
import 'package:habilitacao_quiz/app/features/historico/data/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/get_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';
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
      () => SalvarHistoricoUsecase(Get.find()),
      fenix: true,
    );
  }
}
