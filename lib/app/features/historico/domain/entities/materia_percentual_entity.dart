class MateriaPercentualEntity {
  const MateriaPercentualEntity({
    required this.titulo,
    required this.percentual,
    required this.totalCorretas,
    required this.totalQuestoes,
  });

  final String titulo;
  final double percentual;
  final int totalCorretas;
  final int totalQuestoes;

  bool get temDados => totalQuestoes > 0;
}
