import 'package:habilitacao_quiz/app/features/learning/data/datasources/learning_datasource.dart';
import 'package:habilitacao_quiz/app/features/learning/data/models/learning_models.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/repositories/learning_repository.dart';

class LearningRepository implements ILearningRepository {
  LearningRepository(this._datasource);

  final LearningDatasource _datasource;

  LearningManifestEntity? _manifestCache;

  @override
  Future<LearningManifestEntity> getManifest() async {
    if (_manifestCache != null) return _manifestCache!;
    final json = await _datasource.loadManifestJson();
    _manifestCache = LearningManifestModel.fromJson(json);
    return _manifestCache!;
  }

  @override
  Future<String> loadMarkdown(String relativePath) =>
      _datasource.loadMarkdown(relativePath);

  @override
  Future<LearningTrilhaEntity> getTrilhaBasica() async {
    final manifest = await getManifest();
    final json = await _datasource.loadAssetJson(manifest.trilhaBasicaPath);
    return LearningTrilhaModel.fromJson(json);
  }

  @override
  Future<LearningTrilhaEntity> getTrilhaCompleta() async {
    final manifest = await getManifest();
    final json = await _datasource.loadAssetJson(manifest.trilhaCompletaPath);
    return LearningTrilhaModel.fromJson(json);
  }

  @override
  Future<Set<String>> loadTrilhaProgresso(String trilhaId) =>
      _datasource.loadTrilhaProgresso(trilhaId);

  @override
  Future<void> salvarPassoTrilha({
    required String trilhaId,
    required String stepId,
  }) =>
      _datasource.salvarPassoTrilha(trilhaId: trilhaId, stepId: stepId);

  @override
  Future<List<String>> getRevisaoEspacadaIds() =>
      _datasource.loadRevisaoEspacadaIds();

  @override
  Future<void> registrarRevisaoEspacada(Set<String> questionIds) async {
    if (questionIds.isEmpty) return;
    final current = await _datasource.loadRevisaoEspacadaIds();
    final merged = {...current, ...questionIds}.toList();
    await _datasource.saveRevisaoEspacadaIds(merged);
  }
}
