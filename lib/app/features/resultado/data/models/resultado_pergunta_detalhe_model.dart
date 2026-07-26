import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';

class ResultadoPerguntaDetalheModel extends ResultadoPerguntaDetalheEntity {
  ResultadoPerguntaDetalheModel({
    required super.perguntaTitulo,
    required super.respostaCorretaTitulo,
    super.respostaEscolhidaTitulo,
    required super.acertou,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'perguntaTitulo': perguntaTitulo,
        'respostaEscolhidaTitulo': respostaEscolhidaTitulo,
        'respostaCorretaTitulo': respostaCorretaTitulo,
        'acertou': acertou,
      };

  factory ResultadoPerguntaDetalheModel.fromEntity(
    ResultadoPerguntaDetalheEntity entity,
  ) =>
      ResultadoPerguntaDetalheModel(
        perguntaTitulo: entity.perguntaTitulo,
        respostaCorretaTitulo: entity.respostaCorretaTitulo,
        respostaEscolhidaTitulo: entity.respostaEscolhidaTitulo,
        acertou: entity.acertou,
      );

  factory ResultadoPerguntaDetalheModel.fromMap(Map<String, dynamic> map) {
    return ResultadoPerguntaDetalheModel(
      perguntaTitulo: map['perguntaTitulo'] as String,
      respostaCorretaTitulo: map['respostaCorretaTitulo'] as String,
      respostaEscolhidaTitulo: map['respostaEscolhidaTitulo'] as String?,
      acertou: map['acertou'] as bool,
    );
  }
}
