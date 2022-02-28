import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';

void main() {
  final tMapQuizModel = <String, dynamic>{
    "titulo": "Direção Defensiva",
    "perguntas": [
      {
        "titulo": "O condutor no trânsito deve?",
        "respostas": [
          {
            "titulo":
                "Observar e respeitar as normas de circulação estabelecidas pelo Código Nacional de Trânsito",
            "correta": true
          },
        ]
      },
    ]
  };
  final tInstanceQuizModel = QuizModel.fromMap(tMapQuizModel);

  test('Deve retornar uma instancia de QuizEntity ', () {
    expect(tInstanceQuizModel, isA<QuizEntity>());
  });

  test('Deve retornar um modelo valido(Json)', () {
    final result = QuizModel.fromJson(jsonEncode(tMapQuizModel));

    expect(result, isA<QuizModel>());
  });

  test('Deve retornar um modelo valido(Map)', () {
    final result = QuizModel.fromMap(tMapQuizModel);

    expect(result, isA<QuizModel>());
  });
  test('Deve retornar um Json', () {
    final result = tInstanceQuizModel.toJson();

    expect(result, jsonEncode(tInstanceQuizModel.toMap()));
  });

  test('Deve retornar um Map', () {
    final result = tInstanceQuizModel.toMap();

    expect(result, tMapQuizModel);
  });
}
