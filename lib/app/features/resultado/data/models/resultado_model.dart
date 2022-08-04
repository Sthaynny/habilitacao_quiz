import 'dart:convert';

import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

class ResultadoModel extends ResultadoEntity {
  ResultadoModel({
    required super.titulo,
    required super.totalPerguntas,
    required super.result,
    required super.totalRespostasCorretas,
    required super.percentual,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'totalPerguntas': totalPerguntas,
      'totalRespostasCorretas': totalRespostasCorretas,
      'result': result,
      'percentual': percentual,
    };
  }

  factory ResultadoModel.fromEntity(ResultadoEntity entity) => ResultadoModel(
      titulo: entity.titulo,
      totalPerguntas: entity.totalPerguntas,
      result: entity.result,
      totalRespostasCorretas: entity.totalRespostasCorretas,
      percentual: entity.percentual);

  factory ResultadoModel.fromMap(Map<String, dynamic> map) {
    return ResultadoModel(
      titulo: map['titulo'] as String,
      totalPerguntas: map['totalPerguntas'] as int,
      totalRespostasCorretas: map['totalRespostasCorretas'] as int,
      result: map['result'] as bool,
      percentual: map['percentual'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultadoModel.fromJson(String source) =>
      ResultadoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
