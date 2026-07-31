import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';

void main() {
  test('legislacao.json: todas as perguntas com id e explicacao (T28b)', () {
    final file = File('assets/json/legislacao.json');
    expect(file.existsSync(), isTrue, reason: 'assets/json/legislacao.json');

    final map = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final quiz = QuizModel.fromMap(map);

    expect(quiz.perguntas.length, 56);

    for (var i = 0; i < quiz.perguntas.length; i++) {
      final pergunta = quiz.perguntas[i];
      final raw = (map['perguntas'] as List)[i] as Map<String, dynamic>;

      expect(raw['id'], 'legislacao_${i + 1}');
      expect(
        raw['explicacao'],
        isA<String>(),
        reason: 'legislacao_${i + 1} sem explicacao',
      );
      expect(
        (raw['explicacao'] as String).trim().isNotEmpty,
        isTrue,
        reason: 'legislacao_${i + 1} explicacao vazia',
      );
      expect(pergunta.explicacao, raw['explicacao']);
    }
  });
}
