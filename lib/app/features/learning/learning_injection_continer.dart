import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/data/datasources/learning_datasource.dart';
import 'package:habilitacao_quiz/app/features/learning/data/repositories/learning_repository.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/repositories/learning_repository.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/services/revisao_quiz_builder.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/revisar_erros_ultimo_teste_usecase.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/controller/learning_controller.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class LearningInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<LearningDatasource>(
      () => LearningDatasource(),
      fenix: true,
    );
    Get.lazyPut<ILearningRepository>(
      () => LearningRepository(Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => GetLearningManifestUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadLearningMarkdownUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => GetTrilhaBasicaUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => GetTrilhaCompletaUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => GetTrilhaProgressoUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => SalvarPassoTrilhaUsecase(Get.find()), fenix: true);
    Get.lazyPut(
      () => GetMapaCompetenciasUsecase(Get.find<ProGate>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetRevisaoEspacadaIdsUsecase(Get.find(), Get.find<ProGate>()),
      fenix: true,
    );
    Get.lazyPut(
      () => RegistrarRevisaoEspacadaUsecase(Get.find(), Get.find<ProGate>()),
      fenix: true,
    );
    Get.lazyPut(
      () => RevisaoQuizBuilder(Get.find<QuizDatasource>()),
      fenix: true,
    );
    Get.lazyPut(
      () => RevisarErrosUltimoTesteUsecase(Get.find(), Get.find<ProGate>()),
      fenix: true,
    );
    Get.lazyPut<LearningController>(
      () => LearningController(
        getManifestUsecase: Get.find(),
        getTrilhaBasicaUsecase: Get.find(),
        getTrilhaCompletaUsecase: Get.find(),
        getTrilhaProgressoUsecase: Get.find(),
        getMapaCompetenciasUsecase: Get.find(),
        proGate: Get.find<ProGate>(),
      ),
      fenix: true,
    );
  }
}
