// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';

class ResultadoEntity {
  const ResultadoEntity({
    required this.id,
    required this.tipo,
    required this.realizadoEm,
    required this.titulo,
    required this.totalPerguntas,
    required this.result,
    required this.totalRespostasCorretas,
    required this.percentual,
    this.detalhePerguntas,
  });

  final String id;
  final TipoResultado tipo;
  final DateTime? realizadoEm;
  final String titulo;
  final int totalPerguntas;
  final int totalRespostasCorretas;
  final bool result;
  final double percentual;
  final List<ResultadoPerguntaDetalheEntity>? detalhePerguntas;

  bool get isSimulado => tipo == TipoResultado.simulado;
}
