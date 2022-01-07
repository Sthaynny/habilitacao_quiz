class RespostaEntity {
  RespostaEntity({
    required this.titulo,
    this.correta = false,
  });
  final String titulo;
  final bool correta;

  RespostaEntity copyWith({
    String? titulo,
    bool? correta,
  }) {
    return RespostaEntity(
      titulo: titulo ?? this.titulo,
      correta: correta ?? this.correta,
    );
  }
}
