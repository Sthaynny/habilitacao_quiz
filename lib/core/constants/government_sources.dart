class GovernmentSource {
  const GovernmentSource({
    required this.title,
    required this.url,
    required this.description,
  });

  final String title;
  final String url;
  final String description;
}

abstract class GovernmentSources {
  static const senatran = GovernmentSource(
    title: 'SENATRAN',
    url: 'https://www.gov.br/transportes/pt-br/assuntos/transito/senatran',
    description:
        'Secretaria Nacional de Trânsito — órgão federal responsável pelas normas de trânsito no Brasil.',
  );

  static const codigoTransitoBrasileiro = GovernmentSource(
    title: 'Código de Trânsito Brasileiro (Lei nº 9.503/1997)',
    url: 'https://www.planalto.gov.br/ccivil_03/leis/l9503.htm',
    description:
        'Legislação federal que rege o trânsito de veículos terrestres no Brasil.',
  );

  static const ministerioTransportes = GovernmentSource(
    title: 'Ministério dos Transportes',
    url: 'https://www.gov.br/transportes',
    description:
        'Portal oficial do Ministério dos Transportes do Governo Federal.',
  );

  static const list = [
    senatran,
    codigoTransitoBrasileiro,
    ministerioTransportes,
  ];
}
