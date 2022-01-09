import 'package:get/get.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';

class QuestionarioController extends GetxController {
  QuestionarioController() {
    _indexPergunta = Rx<int>(1);
  }
  void init({required QuizEntity quizEntity}) {
    quiz = Rx(quizEntity);
  }

  late Rx<QuizEntity> quiz;
  late Rx<int> _indexPergunta;

  int get indexPergunta => _indexPergunta.value;
  set setindexPergunta(int value) => _indexPergunta.value = value;

  set perguntaSelecionada(RespostaEntity resposta) {
    quiz.value.perguntas[indexPergunta].respostaSelecionada = resposta;
    update();
  }

  get perguntaAtual => quiz.value.perguntas[indexPergunta];

  RespostaEntity? get respotaSelecionada =>
      quiz.value.perguntas[indexPergunta].respostaSelecionada;
}
