import 'package:habilitacao_quiz/app/features/historico/domain/entities/materia_percentual_entity.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';

class LearningManifestEntity {
  const LearningManifestEntity({
    required this.contentVersion,
    required this.contentChangelog,
    required this.themes,
    required this.fichas,
    required this.trilhaBasicaPath,
    required this.trilhaCompletaPath,
  });

  final int contentVersion;
  final String contentChangelog;
  final List<LearningThemeContentEntity> themes;
  final List<LearningFichaEntity> fichas;
  final String trilhaBasicaPath;
  final String trilhaCompletaPath;
}

class LearningThemeContentEntity {
  const LearningThemeContentEntity({
    required this.id,
    required this.quizEnumName,
    required this.resumoPath,
    required this.artigoPath,
  });

  final String id;
  final String quizEnumName;
  final String resumoPath;
  final String artigoPath;

  LearningThemeId? get learningTheme => LearningThemeIdMapper.fromFolderId(id);
}

class LearningFichaEntity {
  const LearningFichaEntity({
    required this.id,
    required this.title,
    required this.path,
    required this.proOnly,
  });

  final String id;
  final String title;
  final String path;
  final bool proOnly;
}

enum LearningTrilhaStepKind {
  readResumo,
  readArtigo,
  quiz,
  ficha,
}

class LearningTrilhaEntity {
  const LearningTrilhaEntity({
    required this.id,
    required this.title,
    required this.steps,
  });

  final String id;
  final String title;
  final List<LearningTrilhaStepEntity> steps;
}

class LearningTrilhaStepEntity {
  const LearningTrilhaStepEntity({
    required this.id,
    required this.title,
    required this.kind,
    this.themeId,
    this.fichaId,
  });

  final String id;
  final String title;
  final LearningTrilhaStepKind kind;
  final String? themeId;
  final String? fichaId;
}

class MapaCompetenciasEntity {
  const MapaCompetenciasEntity({
    required this.materias,
    required this.dinamico,
  });

  final List<MateriaPercentualEntity> materias;
  final bool dinamico;
}
