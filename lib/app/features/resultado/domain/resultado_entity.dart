// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResultadoEntity {
  const ResultadoEntity({
    required this.titulo,
    required this.totalPerguntas,
    required this.result,
    required this.totalRespostasCorretas,
    required this.percentual,
  });
  final String titulo;
  final int totalPerguntas;
  final int totalRespostasCorretas;
  final bool result;
  final double percentual;
}
