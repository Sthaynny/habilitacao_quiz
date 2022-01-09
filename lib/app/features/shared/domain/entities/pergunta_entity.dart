import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';

class PerguntaEntity {
  PerguntaEntity({
    required this.titulo,
    required this.respostas,
    this.respostaSelecionada,
  });

  final String titulo;
  final List<RespostaEntity> respostas;
  RespostaEntity? respostaSelecionada;

  PerguntaEntity copyWith({
    String? titulo,
    List<RespostaEntity>? respostas,
    RespostaEntity? respostaSelecionada,
  }) {
    return PerguntaEntity(
      titulo: titulo ?? this.titulo,
      respostas: respostas ?? this.respostas,
      respostaSelecionada: respostaSelecionada ?? this.respostaSelecionada,
    );
  }
}
