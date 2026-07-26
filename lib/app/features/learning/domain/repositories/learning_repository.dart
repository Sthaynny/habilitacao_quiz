import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';

abstract interface class ILearningRepository {
  Future<LearningManifestEntity> getManifest();

  Future<String> loadMarkdown(String relativePath);

  Future<LearningTrilhaEntity> getTrilhaBasica();

  Future<LearningTrilhaEntity> getTrilhaCompleta();

  Future<Set<String>> loadTrilhaProgresso(String trilhaId);

  Future<void> salvarPassoTrilha({
    required String trilhaId,
    required String stepId,
  });

  Future<List<String>> getRevisaoEspacadaIds();

  Future<void> registrarRevisaoEspacada(Set<String> questionIds);
}
