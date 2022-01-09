import 'package:quiz_car/app/features/shared/domain/entities/pergunta_entity.dart';

class QuizEntity {
  final String titulo;
  final List<PerguntaEntity> perguntas;

  QuizEntity({
    required this.titulo,
    required this.perguntas,
  });

  QuizEntity copyWith({
    String? titulo,
    List<PerguntaEntity>? perguntas,
  }) {
    return QuizEntity(
      titulo: titulo ?? this.titulo,
      perguntas: perguntas ?? this.perguntas,
    );
  }
}
