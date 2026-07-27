import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/core/styles/app_images.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

abstract final class LearningThemeVisuals {
  static String imageAsset(String folderId) {
    final theme = LearningThemeIdMapper.fromFolderId(folderId);
    return switch (theme) {
      LearningThemeId.legislacao => AppImages.legislacao,
      LearningThemeId.direcaoDefensiva => AppImages.direcaoDefensiva,
      LearningThemeId.mecanicaBasica => AppImages.mecanica,
      LearningThemeId.primeirosSocorros => AppImages.primeirosSocorros,
      LearningThemeId.meioAmbiente => AppImages.meioAmbiente,
      null => AppImages.aleatoria,
    };
  }

  static String teaser(String folderId) {
    final theme = LearningThemeIdMapper.fromFolderId(folderId);
    return switch (theme) {
      LearningThemeId.legislacao => Strings.aprenderTeaserLegislacao,
      LearningThemeId.direcaoDefensiva => Strings.aprenderTeaserDirecaoDefensiva,
      LearningThemeId.mecanicaBasica => Strings.aprenderTeaserMecanicaBasica,
      LearningThemeId.primeirosSocorros => Strings.aprenderTeaserPrimeirosSocorros,
      LearningThemeId.meioAmbiente => Strings.aprenderTeaserMeioAmbiente,
      null => Strings.aprenderLerConteudo,
    };
  }
}
