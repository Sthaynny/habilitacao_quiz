import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

class LearningController extends GetxController {
  LearningController({
    required this.getManifestUsecase,
    required this.getTrilhaBasicaUsecase,
    required this.getTrilhaCompletaUsecase,
    required this.getTrilhaProgressoUsecase,
    required this.getMapaCompetenciasUsecase,
    required this.proGate,
  });

  final GetLearningManifestUsecase getManifestUsecase;
  final GetTrilhaBasicaUsecase getTrilhaBasicaUsecase;
  final GetTrilhaCompletaUsecase getTrilhaCompletaUsecase;
  final GetTrilhaProgressoUsecase getTrilhaProgressoUsecase;
  final GetMapaCompetenciasUsecase getMapaCompetenciasUsecase;
  final ProGate proGate;

  final Rxn<LearningManifestEntity> manifest = Rxn<LearningManifestEntity>();
  final RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    _loadManifest();
  }

  Future<void> _loadManifest() async {
    isLoading.value = true;
    try {
      manifest.value = await getManifestUsecase();
    } finally {
      isLoading.value = false;
    }
  }

  Future<LearningTrilhaEntity> loadTrilhaBasica() => getTrilhaBasicaUsecase();

  Future<LearningTrilhaEntity> loadTrilhaCompleta() =>
      getTrilhaCompletaUsecase();

  Future<Set<String>> loadTrilhaProgresso(String trilhaId) =>
      getTrilhaProgressoUsecase(trilhaId);

  GetMapaCompetenciasUsecase get mapaUsecase => getMapaCompetenciasUsecase;
}
