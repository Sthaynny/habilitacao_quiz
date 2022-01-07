import 'dart:convert';

import 'package:quiz_car/app/features/comum/data/models/pergunta_model.dart';
import 'package:quiz_car/app/features/comum/domain/entities/pergunta_entity.dart';
import 'package:quiz_car/app/features/comum/domain/entities/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required String titulo,
    required List<PerguntaEntity> perguntas,
  }) : super(
          titulo: titulo,
          perguntas: perguntas,
        );

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'perguntas': perguntas.map((pergunta) => (pergunta as PerguntaModel).toMap()).toList(),
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      titulo: map['titulo'] ?? '',
      perguntas: List<PerguntaEntity>.from(
          map['perguntas']?.map((pergunta) => PerguntaModel.fromMap(pergunta))),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(jsonDecode(source));
}
