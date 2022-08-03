abstract class Strings {
  static const legislacao = "Legislação";
  static const direcaoDefesiva = "Direção Defensiva";
  static const mecanicaBasica = "Mecânica Básica";
  static const primeirosSocorros = "Primeiros Socorros";
  static const aleatorias = "Aleatórias";
  static const logoApp = "Habilitação\nQuiz";
  static const erroPadrao = "Ops... Tivemos um problema, tente novamente!";
  static const voltar = 'Voltar';
  static const avancar = 'Avançar';
  static const finalizar = 'Finalizar';
  static const fechar = 'fechar';
  static const emBreve = 'Em breve!';
  static const atencao = "ATENÇÃO";
  static const nao = 'Não';
  static const sim = "Sim";
  static const menssagemAoSairQuestionario =
      "Você vai perder o progresso feito no seu simulado. Quer mesmo sair desse questionário?";
  static const simulado = "Simulado";
  static const meioAmbiente = "Meio Ambiente";
  static const parabens = 'Parabéns!\nVocê será o mestre do automobilismo!';
  static const menssagemBaixoRendimento =
      'A persistência é o melhor caminho do sucesso!';
  static const voceFinalizou = 'Você concluiu\n';
  static const compartilhar = 'Compartilhar';
  static const voltarInicio = 'Voltar ao início';
  static const historico = 'Histórico';
  static const quizzes = 'Quizzes';

  static const comeceEstudosVizualizarProgresso =
      'Comece os estudos para visualizar seu progresso!';

  static String resultadoQuestionario({
    required String respostasCorretas,
    required String totalPerguntas,
    required String percentual,
  }) =>
      'com $respostasCorretas de $totalPerguntas acertos, $percentual%.';

  static String percentualHistorico({
    required String percentual,
  }) =>
      'Você obteve $percentual% de acertos.';

  static String campartilharMensagem({
    required String titulo,
    required String percentual,
  }) =>
      '''Habilitação Quiz : Resultado do quiz: $titulo\n obitive $percentual de aproveitamento.''';
}
