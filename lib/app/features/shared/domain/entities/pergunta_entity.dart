import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';

class PerguntaEntity {
  PerguntaEntity({
    required this.titulo,
    required this.respostas,
    this.respostaSelecionada,
    this.imagemB64,
  });

  final String titulo;
  final List<RespostaEntity> respostas;
  RespostaEntity? respostaSelecionada;
  String? imagemB64;

  PerguntaEntity copyWith({
    String? titulo,
    String? imagemB64,
    List<RespostaEntity>? respostas,
    RespostaEntity? respostaSelecionada,
  }) {
    return PerguntaEntity(
      titulo: titulo ?? this.titulo,
      imagemB64: imagemB64 ?? this.imagemB64,
      respostas: respostas ?? this.respostas,
      respostaSelecionada: respostaSelecionada ?? this.respostaSelecionada,
    );
  }
}
