import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';

class QuizEntity {
  final String titulo;
  List<PerguntaEntity> perguntas;

  QuizEntity({
    required this.titulo,
    required this.perguntas,
  });

  factory QuizEntity.empty() {
    return QuizEntity(titulo: '', perguntas: []);
  }

  bool get isEmpty => titulo.isEmpty && perguntas.isEmpty;

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
