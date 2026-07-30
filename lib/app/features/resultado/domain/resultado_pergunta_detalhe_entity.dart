// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResultadoPerguntaDetalheEntity {
  const ResultadoPerguntaDetalheEntity({
    required this.perguntaTitulo,
    required this.respostaCorretaTitulo,
    this.respostaEscolhidaTitulo,
    required this.acertou,
    this.materiaTitulo,
    this.explicacao,
  });

  final String perguntaTitulo;
  final String? respostaEscolhidaTitulo;
  final String respostaCorretaTitulo;
  final bool acertou;
  final String? materiaTitulo;
  final String? explicacao;
}
