import 'dart:convert';

import 'package:habilitacao_quiz/app/shared/data/models/resposta_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';

class PerguntaModel extends PerguntaEntity {
  PerguntaModel({
    required super.titulo,
    required super.respostas,
    super.id,
    super.explicacao,
    super.materiaTitulo,
    super.imagemB64,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'titulo': titulo,
      'respostas': respostas
          .map((resposta) => (resposta as RespostaModel).toMap())
          .toList(),
    };
    if (id != null) map['id'] = id;
    if (explicacao != null) map['explicacao'] = explicacao;
    if (materiaTitulo != null) map['materiaTitulo'] = materiaTitulo;
    if (imagemB64 != null) {
      map.addAll({
        'imagem': base64UrlEncode(imagemB64!),
      });
    }
    return map;
  }

  factory PerguntaModel.fromMap(Map<String, dynamic> map) {
    return PerguntaModel(
      id: map['id'] as String?,
      titulo: map['titulo'] ?? '',
      explicacao: map['explicacao'] as String?,
      materiaTitulo: map['materiaTitulo'] as String?,
      respostas: List<RespostaEntity>.from(
          map['respostas']?.map((x) => RespostaModel.fromMap(x))),
      imagemB64: map.containsKey('imagem') ? base64Decode(map['imagem']) : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PerguntaModel.fromJson(String source) =>
      PerguntaModel.fromMap(jsonDecode(source));
}
