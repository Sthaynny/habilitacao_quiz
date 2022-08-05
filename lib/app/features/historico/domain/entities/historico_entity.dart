// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

class HistoricoEntity {
  final List<ResultadoEntity> resutados;

  HistoricoEntity({required this.resutados});

  void add(ResultadoEntity resultadoEntity) {
    if (resutados.length > 9) {
      resutados.removeAt(0);
    }
    resutados.add(resultadoEntity);
  }
}
