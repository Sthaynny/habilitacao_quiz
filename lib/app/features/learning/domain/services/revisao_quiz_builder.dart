import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/utils/keys.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Monta quizzes de revisão a partir do banco JSON local.
class RevisaoQuizBuilder {
  RevisaoQuizBuilder(this._quizDatasource);

  final QuizDatasource _quizDatasource;

  static const _quizKeys = [
    Keys.legislacao,
    Keys.direcaoDefensiva,
    Keys.mecanicaBasica,
    Keys.primeirosSocorros,
    Keys.meioAmbiente,
  ];

  Future<QuizEntity?> buildFromQuestionTitles(Set<String> titles) async {
    if (titles.isEmpty) return null;
    final all = await _loadAllPerguntas();
    final selected = all.where((p) => titles.contains(p.titulo)).toList();
    if (selected.isEmpty) return null;
    selected.shuffle();
    return QuizEntity(titulo: Strings.revisaoEspacada, perguntas: selected);
  }

  Future<QuizEntity?> buildFromQuestionIds(List<String> ids) async {
    if (ids.isEmpty) return null;
    final wanted = ids.toSet();
    final all = await _loadAllPerguntas();
    final selected =
        all.where((p) => p.id != null && wanted.contains(p.id)).toList();
    if (selected.isEmpty) return null;
    selected.shuffle();
    return QuizEntity(titulo: Strings.revisaoEspacada, perguntas: selected);
  }

  Future<List<PerguntaEntity>> _loadAllPerguntas() async {
    final perguntas = <PerguntaEntity>[];
    for (final key in _quizKeys) {
      final json = await _quizDatasource.getQuiz(key);
      if (json.isEmpty) continue;
      final quiz = QuizModel.fromJson(json);
      for (final p in quiz.perguntas) {
        final materia = p.materiaTitulo ?? quiz.titulo;
        perguntas.add(
          p.copyWith(materiaTitulo: materia),
        );
      }
    }
    return perguntas;
  }
}
