import 'package:get/get.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';

class QuestionarioController extends GetxController {
  QuestionarioController() {
    _indexPergunta = Rx<int>(0);
  }
  void init({required QuizEntity quizEntity}) {
    _quiz = Rx(quizEntity);
  }

  late Rx<QuizEntity> _quiz;
  late Rx<int> _indexPergunta;

  QuizEntity get quiz => _quiz.value;
  int get tamanhoQuiz => quiz.perguntas.length;

  int get indexPergunta => _indexPergunta.value;
  int get indexPerguntaUsuario => _indexPergunta.value + 1;

  RespostaEntity? get respostaSelecionada =>
      quiz.perguntas[indexPergunta].respostaSelecionada;

  set setRespostaSelecionada(RespostaEntity resposta) {
    quiz.perguntas[indexPergunta].respostaSelecionada = resposta;
    update();
  }

  get perguntaAtual => quiz.perguntas[indexPergunta];

  RespostaEntity? get respotaSelecionada =>
      quiz.perguntas[indexPergunta].respostaSelecionada;

  void get proximoPergunta {
    _indexPergunta.value++;
    update();
  }

  void get voltarPergunta {
    _indexPergunta.value--;
    update();
  }
}
