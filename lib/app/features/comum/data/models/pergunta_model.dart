import 'dart:convert';

import 'package:quiz_car/app/features/comum/data/models/resposta_model.dart';
import 'package:quiz_car/app/features/comum/domain/entities/pergunta_entity.dart';
import 'package:quiz_car/app/features/comum/domain/entities/resposta_entity.dart';

class PerguntaModel extends PerguntaEntity {
  PerguntaModel({
    required String titulo,
    required List<RespostaEntity> respostas,
  }) : super(titulo: titulo, respostas: respostas);

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'respostas': respostas
          .map((resposta) => (resposta as RespostaModel).toMap())
          .toList(),
    };
  }

  factory PerguntaModel.fromMap(Map<String, dynamic> map) {
    return PerguntaModel(
      titulo: map['titulo'] ?? '',
      respostas: List<RespostaEntity>.from(
          map['respostas']?.map((x) => RespostaModel.fromMap(x))),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PerguntaModel.fromJson(String source) =>
      PerguntaModel.fromMap(jsonDecode(source));
}
