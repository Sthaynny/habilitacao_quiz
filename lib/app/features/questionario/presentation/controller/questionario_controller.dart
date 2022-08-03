import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/salvar_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/app/shared/utils/constants.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';

class QuestionarioController extends GetxController with PopUpMixin {
  void init({required QuizEntity quizEntity}) {
    _quiz(quizEntity);
  }

  final Rx<QuizEntity> _quiz = QuizEntity.empty().obs;
  final Rx<int> _indexPergunta = zero.obs;

  void get proximoPergunta {
    if (ultimaPergunta) {
      int totalPerguntasCorretas = zero;
      for (var pergunta in quiz.perguntas) {
        if (pergunta.respostaSelecionada != null &&
            pergunta.respostaSelecionada!.correta) {
          totalPerguntasCorretas++;
        }
      }
      final double percentual = (totalPerguntasCorretas / tamanhoQuiz) * 100;

      final result = ResultadoEntity(
        titulo: quiz.titulo,
        totalPerguntas: tamanhoQuiz,
        result: percentual >= mediaQuiz,
        totalRespostasCorretas: totalPerguntasCorretas,
        percentual: percentual,
      );

      Get.find<HistoricoEntity>().add(result);

      Get.find<SalvarHistoricoUsecase>().call(Get.find<HistoricoEntity>());

      irParaResultado(result);
    } else {
      _indexPergunta(indexPergunta + 1);
    }
  }

  void get voltarPergunta {
    _indexPergunta(indexPergunta - 1);
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
  get perguntaAtual => quiz.perguntas[indexPergunta];

  RespostaEntity? get respotaSelecionada =>
      quiz.perguntas[indexPergunta].respostaSelecionada;
  RespostaEntity? get respostaSelecionada =>
      quiz.perguntas[indexPergunta].respostaSelecionada;

  set setRespostaSelecionada(RespostaEntity resposta) {
    final listaPerguntas = quiz.perguntas;
    listaPerguntas[indexPergunta].respostaSelecionada = resposta;
    _quiz.update(
      (value) {
        value?.perguntas = listaPerguntas;
      },
    );
  }
}
