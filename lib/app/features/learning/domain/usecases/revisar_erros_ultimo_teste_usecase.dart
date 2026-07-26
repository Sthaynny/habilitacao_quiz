import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/services/revisao_quiz_builder.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Monta quiz apenas com erros do último resultado (Pro).
class RevisarErrosUltimoTesteUsecase {
  RevisarErrosUltimoTesteUsecase(this._builder, this._proGate);

  final RevisaoQuizBuilder _builder;
  final ProGate _proGate;

  Future<QuizEntity?> call() async {
    if (!_proGate.podeRevisarErrosUltimoTeste) return null;
    final historico = Get.find<HistoricoEntity>();
    if (historico.resutados.isEmpty) return null;
    final ultimo = historico.resutados.last;
    final detalhe = ultimo.detalhePerguntas;
    if (detalhe == null || detalhe.isEmpty) return null;

    final titulosErrados = detalhe
        .where((d) => !d.acertou)
        .map((d) => d.perguntaTitulo)
        .toSet();
    if (titulosErrados.isEmpty) return null;

    final quizByTitle = await _builder.buildFromQuestionTitles(titulosErrados);
    return quizByTitle?.copyWith(titulo: Strings.revisarErrosUltimoTeste);
  }
}
