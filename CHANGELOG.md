# Changelog — Habilitação Quiz

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/). Versão do app em `pubspec.yaml`.

## [2.0.0] — 2026-07-30

### Aprender (novo)

- Nova aba **Aprender** com hub de estudo: temas em Markdown, trilha básica, fichas e mapa de competências (Pro).
- Trilha completa, fichas Pro, revisão de erros do último teste, revisão espaçada e modo prova com timer de 40 minutos (Pro).
- Conteúdo pedagógico enriquecido com referências oficiais (CTB, SENATRAN, MBST).

### Histórico

- Gabarito detalhado no simulado com resumo e filtros (erros/acertos).
- Dashboard Pro com percentual por matéria e destaque da matéria mais fraca.
- Busca e filtros Pro; exportação PDF/CSV e backup/restauração do histórico (Pro).
- Empty state com CTA para iniciar quiz; aviso ao salvar o 11º resultado no Free.

### Quiz e resultado

- Explicações detalhadas nas questões de Legislação e no resultado do quiz.
- IDs estáveis no JSON de questões; quizzes por tema fixados em 15 questões.
- Painel de estudo Pro na aba Quizzes.

### Free — retenção

- Onboarding na primeira sessão: escolha da matéria para focar.
- Lembrete diário de estudo opcional (notificação local).
- Aviso quando o conteúdo de questões é atualizado no app (`content_manifest`).

### Habilitação Quiz+

- Modelo Free vs Pro com flavors Android (`free` / `pro`).
- CTAs Quiz+ na home, histórico e resultado; tela promocional do **+**; sem AdMob.
- Limites Free: simulado 15 questões, cota diária, histórico dos últimos 10 resultados.

### Acessibilidade

- Semantics, alvos de toque ≥ 48dp e suporte a leitores de tela em home, quiz, histórico, Aprender, onboarding e componentes compartilhados.
- Markdown com cabeçalhos anunciáveis; feedback de limite Free anunciável.

### Performance e estabilidade

- Menos rebuilds e menor uso de memória na home, quiz, histórico, Aprender e promo.
- Splash e bootstrap mais rápidos; correção de travamento na abertura.
- Fonte Noto Sans via `google_fonts`.

### Correções

- CTA Quiz+ oculto no app Pro; flavor Pro alinhado a `kIsPro`.
- Header da home alinhado ao gradiente; aba Quizzes como inicial.
- Backup do histórico registrado no DI; detalhe Pro persistido em temas.

## [1.9.4] — 2026-06-30

- Ajustes de conformidade com políticas da Google Play (avisos legais e descrições).
- Atualização de dependências e SDK.
