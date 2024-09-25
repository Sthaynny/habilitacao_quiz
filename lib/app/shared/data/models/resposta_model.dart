import 'dart:convert';

import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';

class RespostaModel extends RespostaEntity {
  RespostaModel({
    required super.titulo,
    super.correta,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'correta': correta,
    };
  }

  RespostaEntity toEntity() {
    return RespostaEntity(titulo: titulo, correta: correta);
  }

  factory RespostaModel.fromMap(Map<String, dynamic> map) {
    return RespostaModel(
      titulo: map['titulo'] ?? '',
      correta: map['correta'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RespostaModel.fromJson(String source) =>
      RespostaModel.fromMap(json.decode(source));
}
