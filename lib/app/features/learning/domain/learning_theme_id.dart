import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Identificadores de pasta em `assets/learning/temas/`.
enum LearningThemeId {
  legislacao,
  direcaoDefensiva,
  mecanicaBasica,
  primeirosSocorros,
  meioAmbiente,
}

extension LearningThemeIdValues on LearningThemeId {
  String get folderId => switch (this) {
        LearningThemeId.legislacao => 'legislacao',
        LearningThemeId.direcaoDefensiva => 'direcao_defensiva',
        LearningThemeId.mecanicaBasica => 'mecanica_basica',
        LearningThemeId.primeirosSocorros => 'primeiros_socorros',
        LearningThemeId.meioAmbiente => 'meio_ambiente',
      };

  String get displayTitle => switch (this) {
        LearningThemeId.legislacao => Strings.legislacao,
        LearningThemeId.direcaoDefensiva => Strings.direcaoDefesiva,
        LearningThemeId.mecanicaBasica => Strings.mecanicaBasica,
        LearningThemeId.primeirosSocorros => Strings.primeirosSocorros,
        LearningThemeId.meioAmbiente => Strings.meioAmbiente,
      };

  QuizEnum get quizEnum => switch (this) {
        LearningThemeId.legislacao => QuizEnum.legislacao,
        LearningThemeId.direcaoDefensiva => QuizEnum.direcaoDefensiva,
        LearningThemeId.mecanicaBasica => QuizEnum.mecanicaBasica,
        LearningThemeId.primeirosSocorros => QuizEnum.primeirosSocorros,
        LearningThemeId.meioAmbiente => QuizEnum.meioAmbiente,
      };
}

abstract final class LearningThemeIdMapper {
  static LearningThemeId? fromFolderId(String? id) {
    if (id == null) return null;
    for (final theme in LearningThemeId.values) {
      if (theme.folderId == id) return theme;
    }
    return null;
  }

  static LearningThemeId? fromQuizEnum(QuizEnum quiz) {
    for (final theme in LearningThemeId.values) {
      if (theme.quizEnum == quiz) return theme;
    }
    return null;
  }

  static LearningThemeId? fromQuizEnumName(String name) {
    for (final value in QuizEnum.values) {
      if (value.name == name) {
        return fromQuizEnum(value);
      }
    }
    return null;
  }
}
