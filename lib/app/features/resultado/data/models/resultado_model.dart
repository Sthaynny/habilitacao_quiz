import 'dart:convert';

import 'package:habilitacao_quiz/app/features/resultado/data/models/resultado_pergunta_detalhe_model.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class ResultadoModel extends ResultadoEntity {
  ResultadoModel({
    required super.id,
    required super.tipo,
    required super.realizadoEm,
    required super.titulo,
    required super.totalPerguntas,
    required super.result,
    required super.totalRespostasCorretas,
    required super.percentual,
    super.detalhePerguntas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo.name,
      'realizadoEm': realizadoEm?.toUtc().toIso8601String(),
      'titulo': titulo,
      'totalPerguntas': totalPerguntas,
      'totalRespostasCorretas': totalRespostasCorretas,
      'result': result,
      'percentual': percentual,
      if (detalhePerguntas != null && detalhePerguntas!.isNotEmpty)
        'detalhePerguntas': detalhePerguntas!
            .map(
              (e) => ResultadoPerguntaDetalheModel.fromEntity(e).toMap(),
            )
            .toList(),
    };
  }

  factory ResultadoModel.fromEntity(ResultadoEntity entity) => ResultadoModel(
        id: entity.id,
        tipo: entity.tipo,
        realizadoEm: entity.realizadoEm,
        titulo: entity.titulo,
        totalPerguntas: entity.totalPerguntas,
        result: entity.result,
        totalRespostasCorretas: entity.totalRespostasCorretas,
        percentual: entity.percentual,
        detalhePerguntas: entity.detalhePerguntas,
      );

  factory ResultadoModel.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id')) {
      return _fromLegacyMap(map);
    }
    final detalheRaw = map['detalhePerguntas'] as List<dynamic>?;
    return ResultadoModel(
      id: map['id'] as String,
      tipo: TipoResultado.values.byName(map['tipo'] as String),
      realizadoEm: map['realizadoEm'] != null
          ? DateTime.parse(map['realizadoEm'] as String)
          : null,
      titulo: map['titulo'] as String,
      totalPerguntas: map['totalPerguntas'] as int,
      totalRespostasCorretas: map['totalRespostasCorretas'] as int,
      result: map['result'] as bool,
      percentual: (map['percentual'] as num).toDouble(),
      detalhePerguntas: detalheRaw
          ?.map(
            (e) => ResultadoPerguntaDetalheModel.fromMap(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  static ResultadoModel _fromLegacyMap(Map<String, dynamic> map) {
    final titulo = map['titulo'] as String;
    final tipo = titulo == Strings.simulado
        ? TipoResultado.simulado
        : TipoResultado.tema;
    return ResultadoModel(
      id: 'legacy_${titulo.hashCode}_${map['percentual']}',
      tipo: tipo,
      realizadoEm: null,
      titulo: titulo,
      totalPerguntas: map['totalPerguntas'] as int,
      totalRespostasCorretas: map['totalRespostasCorretas'] as int,
      result: map['result'] as bool,
      percentual: (map['percentual'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultadoModel.fromJson(String source) =>
      ResultadoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
