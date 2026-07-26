// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResultadoPerguntaDetalheEntity {
  const ResultadoPerguntaDetalheEntity({
    required this.perguntaTitulo,
    required this.respostaCorretaTitulo,
    this.respostaEscolhidaTitulo,
    required this.acertou,
  });

  final String perguntaTitulo;
  final String? respostaEscolhidaTitulo;
  final String respostaCorretaTitulo;
  final bool acertou;
}
