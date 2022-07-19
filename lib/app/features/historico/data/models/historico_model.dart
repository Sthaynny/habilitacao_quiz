import 'dart:convert';

import 'package:habilitacao_quiz/app/features/historico/domain/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/data/models/resultado_model.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

class HistoricoModel extends HistoricoEntity {
  HistoricoModel({required super.resutados});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resutados': resutados
          .map((element) => (element as ResultadoModel).toMap())
          .toList(),
    };
  }

  factory HistoricoModel.fromMap(Map<String, dynamic> map) {
    return HistoricoModel(
      resutados: List<ResultadoEntity>.from(
        (map['resutados'] as List<int>).map<ResultadoModel>(
          (x) => ResultadoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricoModel.fromJson(String source) =>
      HistoricoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
