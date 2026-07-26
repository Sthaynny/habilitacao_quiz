import 'package:dartz/dartz.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class RestaurarHistoricoBackupUsecase {
  RestaurarHistoricoBackupUsecase(
    this._repository,
    this._proGate,
  );

  final IHistoricoRepository _repository;
  final ProGate _proGate;

  Future<Either<ExceptionErro, HistoricoEntity>> call({
    required String jsonContent,
    required HistoricoEntity historicoEmMemoria,
  }) async {
    if (!_proGate.isPro) {
      return left(
        ExceptionErro(menssagem: Strings.historicoBackupProOnly),
      );
    }

    HistoricoEntity restored;
    try {
      restored = _repository.decodeBackup(jsonContent);
    } on FormatException {
      return left(
        ExceptionErro(menssagem: Strings.historicoBackupArquivoInvalido),
      );
    } catch (_) {
      return left(
        ExceptionErro(menssagem: Strings.historicoBackupArquivoInvalido),
      );
    }

    final persistido = await _repository.salvarHistorico(restored);
    if (persistido != true) {
      return left(ExceptionErro());
    }

    historicoEmMemoria.resutados
      ..clear()
      ..addAll(restored.resutados);

    return right(historicoEmMemoria);
  }
}
