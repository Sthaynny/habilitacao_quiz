import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_car/app/features/comum/data/models/pergunta_model.dart';
import 'package:quiz_car/app/features/comum/domain/entities/pergunta_entity.dart';

void main() {
  final tInstancePerguntaModel = PerguntaModel.fromMap(<String, dynamic>{
    "titulo": "O condutor no trânsito deve?",
    "respostas": [
      {
        "titulo":
            "Observar e respeitar as normas de circulação estabelecidas pelo Código Nacional de Trânsito",
        "correta": true
      },
      {"titulo": "Obedecer apenas à sinalização das placas e aos semáforos."}
    ]
  });
  final tMapPerguntaModel = tInstancePerguntaModel.toMap();

  test('Deve retornar uma instancia de PerguntaEntity ', () {
    expect(tInstancePerguntaModel, isA<PerguntaEntity>());
  });

  test('Deve retornar um modelo valido(Json)', () {
    final result = PerguntaModel.fromJson(jsonEncode(tMapPerguntaModel));

    expect(result, isA<PerguntaEntity>());
    expect(result, isA<PerguntaModel>());
  });

  test('Deve retornar um modelo valido(Map)', () {
    final result = PerguntaModel.fromMap(tMapPerguntaModel);

    expect(result, isA<PerguntaEntity>());
    expect(result, isA<PerguntaModel>());
  });
  test('Deve retornar um Json', () {
    final result = tInstancePerguntaModel.toJson();

    expect(result, jsonEncode(tInstancePerguntaModel.toMap()));
  });

  test('Deve retornar um Map', () {
    final result = tInstancePerguntaModel.toMap();

    expect(result, tMapPerguntaModel);
  });
}
