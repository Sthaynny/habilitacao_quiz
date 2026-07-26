import 'dart:convert';

import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';

class LearningManifestModel extends LearningManifestEntity {
  LearningManifestModel({
    required super.contentVersion,
    required super.contentChangelog,
    required super.themes,
    required super.fichas,
    required super.trilhaBasicaPath,
    required super.trilhaCompletaPath,
  });

  factory LearningManifestModel.fromJson(String source) {
    final map = jsonDecode(source) as Map<String, dynamic>;
    return LearningManifestModel(
      contentVersion: map['contentVersion'] as int? ?? 0,
      contentChangelog: map['contentChangelog'] as String? ?? '',
      trilhaBasicaPath: map['trilhaBasicaPath'] as String? ?? '',
      trilhaCompletaPath: map['trilhaCompletaPath'] as String? ?? '',
      themes: (map['themes'] as List<dynamic>? ?? [])
          .map((e) => LearningThemeContentModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      fichas: (map['fichas'] as List<dynamic>? ?? [])
          .map((e) => LearningFichaModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LearningThemeContentModel extends LearningThemeContentEntity {
  LearningThemeContentModel({
    required super.id,
    required super.quizEnumName,
    required super.resumoPath,
    required super.artigoPath,
  });

  factory LearningThemeContentModel.fromMap(Map<String, dynamic> map) {
    return LearningThemeContentModel(
      id: map['id'] as String? ?? '',
      quizEnumName: map['quizEnum'] as String? ?? '',
      resumoPath: map['resumoPath'] as String? ?? '',
      artigoPath: map['artigoPath'] as String? ?? '',
    );
  }
}

class LearningFichaModel extends LearningFichaEntity {
  LearningFichaModel({
    required super.id,
    required super.title,
    required super.path,
    required super.proOnly,
  });

  factory LearningFichaModel.fromMap(Map<String, dynamic> map) {
    return LearningFichaModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      path: map['path'] as String? ?? '',
      proOnly: map['proOnly'] as bool? ?? true,
    );
  }
}

class LearningTrilhaModel extends LearningTrilhaEntity {
  LearningTrilhaModel({
    required super.id,
    required super.title,
    required super.steps,
  });

  factory LearningTrilhaModel.fromJson(String source) {
    final map = jsonDecode(source) as Map<String, dynamic>;
    return LearningTrilhaModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      steps: (map['steps'] as List<dynamic>? ?? [])
          .map((e) => LearningTrilhaStepModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LearningTrilhaStepModel extends LearningTrilhaStepEntity {
  LearningTrilhaStepModel({
    required super.id,
    required super.title,
    required super.kind,
    super.themeId,
    super.fichaId,
  });

  factory LearningTrilhaStepModel.fromMap(Map<String, dynamic> map) {
    return LearningTrilhaStepModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      kind: _parseKind(map['kind'] as String?),
      themeId: map['themeId'] as String?,
      fichaId: map['fichaId'] as String?,
    );
  }

  static LearningTrilhaStepKind _parseKind(String? raw) {
    return switch (raw) {
      'read_resumo' => LearningTrilhaStepKind.readResumo,
      'read_artigo' => LearningTrilhaStepKind.readArtigo,
      'quiz' => LearningTrilhaStepKind.quiz,
      'ficha' => LearningTrilhaStepKind.ficha,
      _ => LearningTrilhaStepKind.readResumo,
    };
  }
}
