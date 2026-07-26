import 'dart:typed_data';

import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';

class PerguntaEntity {
  PerguntaEntity({
    required this.titulo,
    required this.respostas,
    this.id,
    this.explicacao,
    this.materiaTitulo,
    this.respostaSelecionada,
    this.imagemB64,
  });

  final String? id;
  final String titulo;
  final String? explicacao;
  final String? materiaTitulo;
  final List<RespostaEntity> respostas;
  RespostaEntity? respostaSelecionada;
  Uint8List? imagemB64;

  PerguntaEntity copyWith({
    String? id,
    String? titulo,
    String? explicacao,
    String? materiaTitulo,
    Uint8List? imagemB64,
    List<RespostaEntity>? respostas,
    RespostaEntity? respostaSelecionada,
  }) {
    return PerguntaEntity(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      explicacao: explicacao ?? this.explicacao,
      materiaTitulo: materiaTitulo ?? this.materiaTitulo,
      imagemB64: imagemB64 ?? this.imagemB64,
      respostas: respostas ?? this.respostas,
      respostaSelecionada: respostaSelecionada ?? this.respostaSelecionada,
    );
  }
}
