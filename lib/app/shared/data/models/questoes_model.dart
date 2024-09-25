import 'dart:convert';

import 'package:habilitacao_quiz/app/shared/data/models/pergunta_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.titulo,
    required super.perguntas,
  });

  QuizEntity fromEntity() {
    return QuizEntity(
      titulo: titulo,
      perguntas: perguntas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'perguntas': perguntas
          .map((pergunta) => (pergunta as PerguntaModel).toMap())
          .toList(),
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
