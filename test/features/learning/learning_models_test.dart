import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/learning/data/models/learning_models.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';

void main() {
  test('manifest parse themes and contentVersion', () {
    const json = '''
{
  "contentVersion": 1,
  "contentChangelog": "test",
  "themes": [
    {
      "id": "legislacao",
      "quizEnum": "legislacao",
      "resumoPath": "temas/legislacao/resumo.md",
      "artigoPath": "temas/legislacao/artigo_01.md"
    }
  ],
  "trilhaBasicaPath": "trilha_basica.json",
  "trilhaCompletaPath": "trilha_completa.json",
  "fichas": []
}
''';
    final model = LearningManifestModel.fromJson(json);
    expect(model.contentVersion, 1);
    expect(model.themes.single.id, 'legislacao');
    expect(
      LearningThemeIdMapper.fromQuizEnumName(model.themes.single.quizEnumName),
      LearningThemeId.legislacao,
    );
  });

  test('trilha step kinds', () {
    const json = '''
{
  "id": "trilha_basica",
  "title": "Trilha",
  "steps": [
    {"id": "s1", "title": "Ler", "kind": "read_resumo", "themeId": "legislacao"}
  ]
}
''';
    final trilha = LearningTrilhaModel.fromJson(json);
    expect(trilha.steps.single.id, 's1');
  });
}
