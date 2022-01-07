import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';

class PerguntaEntity {
  final String titulo;
  final List<RespostaEntity> respostas;

  PerguntaEntity({required this.titulo, required this.respostas});

  PerguntaEntity copyWith({
    String? titulo,
    List<RespostaEntity>? respostas,
  }) {
    return PerguntaEntity(
      titulo: titulo ?? this.titulo,
      respostas: respostas ?? this.respostas,
    );
  }
}
