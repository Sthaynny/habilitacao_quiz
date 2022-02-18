abstract class Strings {
  static const legislacao = "Legislação";
  static const direcaoDefesiva = "Direção Defensiva";
  static const mecanicaBasica = "Mecânica Básica";
  static const primeirosSocorros = "Primeiros Socorros";
  static const aleatorias = "Aleatórias";
  static const logoApp = "Habilitação Quiz";
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
  static const parabens = 'Parabéns!';
  static const menssgemTriste = 'Oh, que chato!\nVamos melhorar na proxima!';
  static const voceFinalizou = 'Você finalizou\n';
  static const compartilhar = 'Compartilhar';
  static const voltarInicio = 'Voltar ao início';

  static String resultadoQuestionario({
    required String respostasCorretas,
    required String totalPerguntas,
    required String percentual,
  }) =>
      'com $respostasCorretas de $totalPerguntas acertos, ou seja, $percentual%!';

  static String campartilharMensagem({
    required String titulo,
    required String percentual,
  }) =>
      '''Habilitação Quiz : Resultado do quiz: $titulo\n obitive $percentual de aproveitamento.''';
}
