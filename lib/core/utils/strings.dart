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
  static const avisoLegal = 'Aviso legal';
  static const fontesOficiais = 'Fontes oficiais';
  static const fontesOficiaisDescricao =
      'As questões deste app são baseadas em conteúdo educacional sobre trânsito. Consulte sempre as fontes oficiais abaixo para informações atualizadas.';
  static const avisoLegalTexto =
      'Este aplicativo é independente e não representa, não é afiliado, patrocinado ou aprovado por qualquer entidade governamental, incluindo a SENATRAN (antiga DENATRAN) ou qualquer DETRAN estadual. O conteúdo é exclusivamente educacional e não substitui cursos oficiais, materiais do DETRAN ou a prova teórica da CNH.';

  static const comeceEstudosVizualizarProgresso =
      'Comece os estudos para visualizar seu progresso!';

  static const plusBannerSubtitle =
      'Simulado de 30 questões, histórico ilimitado e mais.';
  static const plusBannerSemantics =
      'Conhecer o Habilitação Quiz mais, versão completa';
  static const plusBannerHint = 'Abre detalhes do aplicativo pago';
  static const plusEmBreve =
      'O Habilitação Quiz+ ainda não está disponível na loja.';
  static const plusLojaIndisponivel =
      'Não foi possível abrir a loja. Tente novamente mais tarde.';
  static const plusScreenTitle = 'Estude sem limites';
  static const plusScreenIntro =
      'O Habilitação Quiz+ é um app separado na loja, com recursos para quem quer ir além do básico:';
  static const plusVerNaLoja = 'Ver na Play Store';
  static const plusItemLegal = 'Habilitação Quiz+';
  static const plusItemLegalDesc =
      'Versão completa do app na loja (compra única).';
  static const simuladoLimiteDiario =
      'Você já fez o simulado de hoje. No Habilitação Quiz+ são ilimitados.';
  static const resultadoSimuladoFreeCta =
      'No Habilitação Quiz+, faça simulados oficiais de 30 questões, sem limite diário.';
  static const historicoLimiteFreeSnackbar =
      'Mantemos só os últimos 10 resultados no app gratuito. No +, histórico ilimitado.';
  static const historicoPlusRodape =
      'Histórico ilimitado e detalhes no Habilitação Quiz+.';

  static const plusBenefits = <String>[
    'Simulado com 30 questões, quantas vezes quiser',
    'Quizzes com o banco completo por tema',
    'Histórico ilimitado para acompanhar sua evolução',
    'Sem anúncios',
  ];

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
