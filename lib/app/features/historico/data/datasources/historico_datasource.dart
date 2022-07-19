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
  Future<bool?> saveHistorico(List<HistoricoEntity> list) async {
    final List<String> listData =
        list.map((e) => (e as HistoricoModel).toJson()).toList();

    instance = await SharedPreferences.getInstance();
    final result = await instance!.setStringList(
      _key,
      listData,
    );
    if (result) {
      return result;
    }
    return null;
  }

  Future<List<HistoricoEntity>> getHistorico() async {
    instance = await SharedPreferences.getInstance();
    final response = instance!.getStringList(_key) ?? <String>[];
    final result = response.map((e) => HistoricoModel.fromJson(e)).toList();
    return result;
  }
}
