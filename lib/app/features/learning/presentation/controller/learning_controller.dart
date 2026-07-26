import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

class LearningController extends GetxController {
  LearningController({
    required GetLearningManifestUsecase getManifestUsecase,
    required GetTrilhaBasicaUsecase getTrilhaBasicaUsecase,
    required GetTrilhaCompletaUsecase getTrilhaCompletaUsecase,
    required GetTrilhaProgressoUsecase getTrilhaProgressoUsecase,
    required GetMapaCompetenciasUsecase getMapaCompetenciasUsecase,
    required ProGate proGate,
  })  : _getManifestUsecase = getManifestUsecase,
        _getTrilhaBasicaUsecase = getTrilhaBasicaUsecase,
        _getTrilhaCompletaUsecase = getTrilhaCompletaUsecase,
        _getTrilhaProgressoUsecase = getTrilhaProgressoUsecase,
        _getMapaCompetenciasUsecase = getMapaCompetenciasUsecase,
        _proGate = proGate;

  final GetLearningManifestUsecase _getManifestUsecase;
  final GetTrilhaBasicaUsecase _getTrilhaBasicaUsecase;
  final GetTrilhaCompletaUsecase _getTrilhaCompletaUsecase;
  final GetTrilhaProgressoUsecase _getTrilhaProgressoUsecase;
  final GetMapaCompetenciasUsecase _getMapaCompetenciasUsecase;
  final ProGate _proGate;

  final Rxn<LearningManifestEntity> manifest = Rxn<LearningManifestEntity>();
  final RxBool isLoading = true.obs;

  ProGate get proGate => _proGate;

  @override
  void onReady() {
    super.onReady();
    _loadManifest();
  }

  Future<void> _loadManifest() async {
    isLoading.value = true;
    try {
      manifest.value = await _getManifestUsecase();
    } finally {
      isLoading.value = false;
    }
  }

  Future<LearningTrilhaEntity> loadTrilhaBasica() =>
      _getTrilhaBasicaUsecase();

  Future<LearningTrilhaEntity> loadTrilhaCompleta() =>
      _getTrilhaCompletaUsecase();

  Future<Set<String>> loadTrilhaProgresso(String trilhaId) =>
      _getTrilhaProgressoUsecase(trilhaId);

  GetMapaCompetenciasUsecase get mapaUsecase => _getMapaCompetenciasUsecase;
}
