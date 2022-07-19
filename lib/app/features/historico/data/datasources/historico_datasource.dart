import 'dart:collection';

import 'package:habilitacao_quiz/app/features/historico/data/models/historico_model.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ListExt on List {
  String toStringMap() => IterableBase.iterableToShortString(this, '[', ']');
}

const _key = 'historico';

class HistoricoDatasource {
  SharedPreferences? instance;
  Future<bool?> saveHistorico(HistoricoEntity historico) async {
    instance = await SharedPreferences.getInstance();
    final result = await instance!.setString(
      _key,
      (historico as HistoricoModel).toJson(),
    );
    if (result) {
      return result;
    }
    return null;
  }

  Future<HistoricoEntity> getHistorico() async {
    instance = await SharedPreferences.getInstance();
    final response = instance!.getString(_key);
    if (response != null) {
      return HistoricoModel.fromJson(response);
    } else {
      return HistoricoEntity(resutados: []);
    }
  }
}
