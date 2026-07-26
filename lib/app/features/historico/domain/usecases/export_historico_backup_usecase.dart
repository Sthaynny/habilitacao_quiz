import 'package:dartz/dartz.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/repositories/historico_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class ExportHistoricoBackupUsecase {
  ExportHistoricoBackupUsecase(
    this._repository,
    this._proGate,
  );

  final IHistoricoRepository _repository;
  final ProGate _proGate;

  Either<ExceptionErro, String> call(HistoricoEntity historico) {
    if (!_proGate.isPro) {
      return left(
        ExceptionErro(menssagem: Strings.historicoBackupProOnly),
      );
    }
    return right(_repository.encodeBackup(historico));
  }
}
