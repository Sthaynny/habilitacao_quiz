import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/utils/simulado.dart';

import '../../utils/utils.dart';

void main() {
  late String jsonQuiz;

  setUpAll(() {
    jsonQuiz = jsonEncode(tMapQuizModel);
  });

  Simulado buildSimuladoHelper() => Simulado(
        jsonMecanica: jsonQuiz,
        jsonDirecaoDefensiva: jsonQuiz,
        jsonPrimeirosSocorros: jsonQuiz,
        jsonLegislacao: jsonQuiz,
        jsonMeioAmbiente: jsonQuiz,
      );

  test('Free: 15 questões no simulado', () {
    final quiz = buildSimuladoHelper().buildSimulado(totalQuestoes: 15);
    expect(quiz.perguntas.length, 15);
  });

  test('Pro: 30 questões no simulado', () {
    final quiz = buildSimuladoHelper().buildSimulado(totalQuestoes: 30);
    expect(quiz.perguntas.length, 30);
  });
}
