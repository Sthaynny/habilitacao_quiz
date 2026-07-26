import 'package:habilitacao_quiz/app/shared/data/datasources/simulado_quota_datasource.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

class SimuladoQuotaService {
  SimuladoQuotaService(this._datasource, this._proGate);

  final SimuladoQuotaDatasource _datasource;
  final ProGate _proGate;

  Future<bool> podeIniciarSimuladoHoje() async {
    final count = await _datasource.simuladosIniciadosHoje();
    return _proGate.podeIniciarSimuladoHoje(count);
  }

  Future<void> registrarInicioSimulado() {
    return _datasource.registrarInicioSimuladoHoje();
  }
}
