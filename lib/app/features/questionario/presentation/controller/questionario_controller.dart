import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';

import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';

import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';

import 'package:habilitacao_quiz/app/features/resultado/domain/map_quiz_to_resultado.dart';

import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';

import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';

import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';

import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

import 'package:habilitacao_quiz/app/shared/utils/constants.dart';

import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/utils/gate_limit_feedback.dart';
import 'package:habilitacao_quiz/core/utils/semantics_announce.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';



class QuestionarioController extends GetxController with PopUpMixin {

  void init({required QuizEntity quizEntity}) {
    _quiz(quizEntity);
    _syncRespostaSelecionadaFromPerguntaAtual();
  }

  final Rx<QuizEntity> _quiz = QuizEntity.empty().obs;
  final Rx<int> _indexPergunta = zero.obs;
  final Rxn<RespostaEntity> _respostaSelecionadaAtual = Rxn<RespostaEntity>();

  void _syncRespostaSelecionadaFromPerguntaAtual() {
    _respostaSelecionadaAtual(quiz.perguntas[indexPergunta].respostaSelecionada);
  }



  void get proximoPergunta {

    if (ultimaPergunta) {

      _finalizarQuestionario();

    } else {
      _indexPergunta(indexPergunta + 1);
      _syncRespostaSelecionadaFromPerguntaAtual();
      _announceQuestaoAtual();
    }
  }



  void finalizarPorTempoEsgotado() {

    _finalizarQuestionario();

  }



  void _finalizarQuestionario() {

    int totalPerguntasCorretas = zero;

    for (var pergunta in quiz.perguntas) {

      if (pergunta.respostaSelecionada != null &&

          pergunta.respostaSelecionada!.correta) {

        totalPerguntasCorretas++;

      }

    }

    final totalPerguntas = quiz.perguntas.length;

    final double percentual = totalPerguntas == 0

        ? 0

        : (totalPerguntasCorretas / totalPerguntas) * cem;



    final proGate = Get.find<ProGate>();

    final result = MapQuizToResultado.call(

      quiz: quiz,

      totalPerguntasCorretas: totalPerguntasCorretas,

      percentual: percentual,

      aprovado: percentual >= mediaQuiz,

      isPro: proGate.isPro,

    );



    _registrarRevisaoEspacadaSePro(proGate);



    final historico = Get.find<HistoricoEntity>();

    Get.find<SalvarHistoricoUsecase>()

        .registrarResultado(historico, result)

        .then(showHistoricoLimiteFreeSnackbarIfNeeded);

    irParaResultado(result);

  }



  Future<void> _registrarRevisaoEspacadaSePro(ProGate proGate) async {

    if (!proGate.podeRevisaoEspacada) return;

    final wrongIds = <String>{};

    for (final pergunta in quiz.perguntas) {

      final sel = pergunta.respostaSelecionada;

      if (sel == null || sel.correta) continue;

      final id = pergunta.id;

      if (id != null && id.isNotEmpty) wrongIds.add(id);

    }

    if (wrongIds.isEmpty) return;

    await Get.find<RegistrarRevisaoEspacadaUsecase>()(wrongIds);

  }



  void get voltarPergunta {
    _indexPergunta(indexPergunta - 1);
    _syncRespostaSelecionadaFromPerguntaAtual();
    _announceQuestaoAtual();
  }

  void _announceQuestaoAtual() {
    announceForAccessibility(
      Strings.questaoIndicadorA11y(indexPerguntaUsuario, tamanhoQuiz),
    );
  }



  Future<void> fecharQuestionario() async {

    final result = await popUpConfirmacao();

    if (result != null && result) {

      Get.back();

    }

  }



  void irParaResultado(ResultadoEntity resultadoEntity) {

    Get.offNamed(

      Routes.resultado,

      arguments: resultadoEntity,

    );

  }

}



extension MetodosAuxilixaresController on QuestionarioController {

  QuizEntity get quiz => _quiz.value;

  int get tamanhoQuiz => quiz.perguntas.length;

  int get indexPergunta => _indexPergunta.value;

  int get indexPerguntaUsuario => _indexPergunta.value + 1;

  bool get ultimaPergunta =>

      _indexPergunta.value == (quiz.perguntas.length - 1);

  PerguntaEntity get perguntaAtual => quiz.perguntas[indexPergunta];



  RespostaEntity? get respotaSelecionada => _respostaSelecionadaAtual.value;

  RespostaEntity? get respostaSelecionada => _respostaSelecionadaAtual.value;

  set setRespostaSelecionada(RespostaEntity resposta) {
    quiz.perguntas[indexPergunta].respostaSelecionada = resposta;
    _respostaSelecionadaAtual(resposta);
  }
}


