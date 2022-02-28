import 'dart:convert';
import 'dart:typed_data';

import 'package:habilitacao_quiz/app/shared/data/models/resposta_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';

class PerguntaModel extends PerguntaEntity {
  PerguntaModel({
    required String titulo,
    required List<RespostaEntity> respostas,
    Uint8List? imagemB64,
  }) : super(
          titulo: titulo,
          respostas: respostas,
          imagemB64: imagemB64,
        );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'titulo': titulo,
      'respostas': respostas
          .map((resposta) => (resposta as RespostaModel).toMap())
          .toList(),
    };
    if (imagemB64 != null) {
      map.addAll({
        'imagem': base64UrlEncode(imagemB64!),
      });
    }
    return map;
  }

  factory PerguntaModel.fromMap(Map<String, dynamic> map) {
    return PerguntaModel(
      titulo: map['titulo'] ?? '',
      respostas: List<RespostaEntity>.from(
          map['respostas']?.map((x) => RespostaModel.fromMap(x))),
      imagemB64: map.containsKey('imagem') ? base64Decode(map['imagem']) : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PerguntaModel.fromJson(String source) =>
      PerguntaModel.fromMap(jsonDecode(source));
}
