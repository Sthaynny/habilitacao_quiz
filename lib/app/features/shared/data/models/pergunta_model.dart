import 'dart:convert';

import 'package:quiz_car/app/features/shared/data/models/resposta_model.dart';
import 'package:quiz_car/app/features/shared/domain/entities/pergunta_entity.dart';
import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';

class PerguntaModel extends PerguntaEntity {
  PerguntaModel({
    required String titulo,
    required List<RespostaEntity> respostas,
    String? imagemB64,
  }) : super(
          titulo: titulo,
          respostas: respostas,
          imagemB64: imagemB64,
        );

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'respostas': respostas
          .map((resposta) => (resposta as RespostaModel).toMap())
          .toList(),
      'imagem': imagemB64,
    };
  }

  factory PerguntaModel.fromMap(Map<String, dynamic> map) {
    return PerguntaModel(
      titulo: map['titulo'] ?? '',
      respostas: List<RespostaEntity>.from(
          map['respostas']?.map((x) => RespostaModel.fromMap(x))),
      imagemB64: map['imagem'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PerguntaModel.fromJson(String source) =>
      PerguntaModel.fromMap(jsonDecode(source));
}
