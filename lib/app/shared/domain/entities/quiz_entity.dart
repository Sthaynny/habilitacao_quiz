import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';

class QuizEntity {
  final String titulo;
  List<PerguntaEntity> perguntas;
  final Duration? tempoLimite;
  final bool modoProva;

  QuizEntity({
    required this.titulo,
    required this.perguntas,
    this.tempoLimite,
    this.modoProva = false,
  });

  factory QuizEntity.empty() {
    return QuizEntity(titulo: '', perguntas: []);
  }

  bool get isEmpty => titulo.isEmpty && perguntas.isEmpty;

  QuizEntity copyWith({
    String? titulo,
    List<PerguntaEntity>? perguntas,
    Duration? tempoLimite,
    bool? modoProva,
  }) {
    return QuizEntity(
      titulo: titulo ?? this.titulo,
      perguntas: perguntas ?? this.perguntas,
      tempoLimite: tempoLimite ?? this.tempoLimite,
      modoProva: modoProva ?? this.modoProva,
    );
  }
}
