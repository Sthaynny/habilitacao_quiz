import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_car/app/shared/data/models/resposta_model.dart';
import 'package:quiz_car/app/shared/domain/entities/resposta_entity.dart';

void main() {
  final tInstanceRespostaModel = RespostaModel(titulo: "test");
  final tMapRespostaModel = tInstanceRespostaModel.toMap();

  test('Deve retornar uma instancia de RespostaEntity ', () {
    expect(tInstanceRespostaModel, isA<RespostaEntity>());
  });

  test('Deve retornar um modelo valido(Json)', () {
    final result = RespostaModel.fromJson(jsonEncode(tMapRespostaModel));

    expect(result, isA<RespostaModel>());
  });

  test('Deve retornar um modelo valido(Map)', () {
    final result = RespostaModel.fromMap(tMapRespostaModel);

    expect(result, isA<RespostaModel>());
  });
  test('Deve retornar um Json', () {
    final result = tInstanceRespostaModel.toJson();

    expect(result, jsonEncode(tInstanceRespostaModel.toMap()));
  });

  test('Deve retornar um Map', () {
    final result = tInstanceRespostaModel.toMap();

    expect(result, tMapRespostaModel);
  });
}
