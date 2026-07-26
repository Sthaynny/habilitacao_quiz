# Tarefas a fazer — Habilitação Quiz

**Última atualização:** 26 de julho de 2026  
**Prioridades:** [PRIORIDADES.md](../planning/PRIORIDADES.md) · **Roadmap:** [ROADMAP.md](../planning/ROADMAP.md)

### Como usar

1. Ler **Objetivo** e **Critério de pronto**.
2. Seguir **Pistas** (código / doc).
3. Ao concluir: mover para [FINALIZADAS.md](./FINALIZADAS.md).

---

## Produto / documentação

| ID | Objetivo | Critério de pronto | Pistas |
| :--- | :--- | :--- | :--- |
| T01 | Aprovar matriz Free/Pro e preço **+** | Decisão registrada | [PRODUCT_PLAN](../product/PRODUCT_PLAN.md) |

---

## [GATE] + [STORE] — Fundação

| ID | Objetivo | Critério de pronto | Pistas |
| :--- | :--- | :--- | :--- |
| T02 | `kIsPro` / `AppEditionNames` | Constante usada no app | `cura.li/.../app_edition.dart` |
| T03 | `ProGate` + `StubProGate` + testes | Testes limites Free/Pro | [modelo-free-pro](../features/modelo-free-pro.md) |
| T04 | Flavors Android `free` / `pro` | IDs `.pro` e display name **+** | `cura.li/android/app/build.gradle.kts` |
| T05 | `docs/store/BUILD.md` | Comandos build Free/Pro documentados | Cura.li BUILD.md |
| T06 | Injetar `ProGate` nos use cases de tema | Sessão 15q Free, full Pro | `*_quiz_usercase.dart` |
| T07 | Contador simulados/dia (SP) | Bloqueia 2º simulado Free no mesmo dia | `ProGate.podeIniciarSimuladoHoje` |
| T08 | `Simulado` 15 vs 30 questões | Proporção mantida no Pro 30q | `simulado.dart` |
| T09 | Histórico: FIFO 10 só Free; Pro ilimitado | QA salvar 15 resultados no Pro | `historico_entity.dart` |
| T15 | Smoke AAB Free + Pro | Checklist smoke assinado | criar `docs/store/SMOKE_PRO.md` |
| T16 | Ficha Play **+** (texto, ícone +) | Assets em `google_play/` | listing Pro separado |
| T17 | Preço pago Play **+** | Configurado no console | — |
| T18 | `isProPublished = true` | CTA abre loja real | `app_store_constants.dart` |
| T19 | Privacidade / Data safety sem ads rede | Formulário Play atualizado | nota versão Free |
| T20 | iOS Bundle `.pro` + TestFlight | Quando conta Apple ativa | — |

---

## [PROMO] — Promo Quiz+

| ID | Objetivo | Critério de pronto | Pistas |
| :--- | :--- | :--- | :--- |
| HQ-P01 | `app_edition.dart` | Igual T02 | — |
| HQ-P02 | `AppStoreConstants` | URLs + labels centralizados | Cura.li |
| HQ-P03 | `HabilitacaoQuizPlusCtaBanner` | Widget test; 48dp; semantics | `cura_li_plus_cta.dart` |
| HQ-P04 | `app_store_launcher.dart` | Não abre se `!isProPublished` | `url_launcher` |
| HQ-P05 | `HabilitacaoQuizPlusScreen` + rota | `/habilitacao-quiz-plus` | `routes.dart`, `my_app.dart` |
| HQ-P06 | Substituir AdMob na Home | Sem `BannerAd` | `home_screen.dart`, `quizzes_widget.dart` |
| HQ-P07 | Remover `google_mobile_ads` | `pubspec`, `main.dart`, manifest | — |
| HQ-P08 | CTA histórico (lista) | Fim do scroll; sem AdMob morto | `historico_widget.dart` |
| HQ-P09 | CTA `resultado_screen` simulado Free | Copy 30q no **+** | `resultado_screen.dart` |
| HQ-P10 | CTA nos limites ProGate | Simulado/histórico | controllers + gate |
| HQ-P11 | Item **+** no aviso legal | Navega para tela **+** | `legal_notice_screen.dart` |
| HQ-P12 | UTMs Play documentados | Em `docs/store/` | — |
| HQ-P13 | Ativar publicação Pro | Smoke loja | HQ-P02 flag |
| T31 | Analytics funil promo | Eventos impressão/clique | Firebase opcional |

Doc: [promocao-quiz-plus.md](../features/promocao-quiz-plus.md)

---

## [HIST] — Histórico e simulados

| ID | Objetivo | Critério de pronto | Pistas |
| :--- | :--- | :--- | :--- |
| HQ-H01 | `ProGate.maxResultadosHistorico` | Testes unitários | T03 |
| HQ-H02 | Cap em `SalvarHistoricoUsecase` | Pro sem FIFO | `historico_entity.dart` |
| HQ-H03 | `ResultadoEntity` v2 + migração | `id`, `tipo`, `realizadoEm` | `historico_model.dart` |
| HQ-H04 | Setar tipo/data ao finalizar quiz | `questionario_controller.dart` | — |
| HQ-H05 | Chips Todos/Simulados/Temas | `historico_widget.dart` | — |
| HQ-H06 | Cards clicáveis + data/badge | Navegação Free vs Pro | — |
| HQ-H07 | `DetalheSimuladoScreen` (Pro) | Lista gabarito | — |
| HQ-H08 | Persistir detalhe perguntas Pro | Só simulado Pro | — |
| HQ-H09 | Copy “últimos 10” + CTA | Snackbar no 11º | — |
| HQ-H10 | CTA resultado simulado 15q | HQ-P09 | — |
| HQ-H11 | Remover resíduo AdMob histórico | HQ-P08 | — |
| HQ-H12 | Métricas simulados/semana | Analytics | — |
| T21 | Histórico ilimitado Pro | ≥15 saves Pro | T09 |
| T22 | Dashboard % por matéria | Pro only | histórico agregado |
| T23 | Filtros / busca histórico | Pro | — |
| T24 | Export PDF/CSV | Pro | `path_provider`, share |
| T25 | Backup/restauração arquivo | Pro | — |

Doc: [historico-simulados.md](../features/historico-simulados.md)

---

## [LEARN] — Área Aprender

| ID | Objetivo | Critério de pronto | Pistas |
| :--- | :--- | :--- | :--- |
| HQ-A01 | `manifest.json` tema ↔ quiz | Mapa documentado | `QuizEnum` |
| HQ-A02 | Redigir 5 resumos + 5 artigos + trilha básica | Revisão editorial leve | `assets/learning/` |
| HQ-A03 | Repo/domínio learning | Lê assets offline | clean arch |
| HQ-A04 | UI hub + Markdown | Hub + detalhe tema | pacote markdown |
| HQ-A05 | 3ª aba Aprender | `PageView` + nav | `home_screen.dart` |
| HQ-A06 | CTA Praticar tema | Fluxo questionário | `quizzes_controller` |
| HQ-A07 | Progresso trilha SP | Persistência | — |
| HQ-A08 | Disclaimer + fontes no hub | Reuso legal | `legal_notice_screen` |
| HQ-A09 | ProGate trilha/fichas/mapa | Gates testados | — |
| HQ-A10 | Trilha completa + fichas Pro | Conteúdo assets | — |
| HQ-A11 | Mapa competências | Agrega histórico | T22 |
| HQ-A12 | Revisão espaçada | IDs estáveis no JSON | — |
| HQ-A13 | Testes learning | Parse + progresso | — |
| HQ-A14 | Copy loja Aprender | Listings | `google_play/` |
| HQ-A15 | `contentVersion` manifest | Changelog conteúdo | — |
| T26 | Revisão erros último teste | Pro | questionário |
| T27 | Modo prova ~40 min | Pro 30q | timer UI |
| T28 | Lote explicações no JSON | Campo `explicacao` | assets/json |

Doc: [area-aprendizado.md](../features/area-aprendizado.md)

---

## [IA] — Inteligência Pro

| ID | Objetivo | Critério de pronto | Pistas |
| :--- | :--- | :--- | :--- |
| HQ-I01 | Schema JSON `id`, `explicacao`, `referencia_ctb` | Retrocompatível | — |
| HQ-I02 | Curar ~40 explicações | Legislação + dir. defensiva | — |
| HQ-I03 | `AiQuotaService` + ProGate | Só Pro | — |
| HQ-I04 | UI “Explicar resposta” | Estados loading/offline | revisão P05 |
| HQ-I05 | Disclaimer 1ª uso IA | Tela curta | — |
| HQ-I06 | Proxy + App Check + rate limit | Sem chave no app | Cloud Function |
| HQ-I07 | `ExplainAnswerRepository` + cache | Testes | — |
| HQ-I08 | Validação fontes allowlist | Proxy | — |
| HQ-I09 | Analytics IA | Eventos básicos | — |
| HQ-I10 | Privacidade IA | Data safety | — |
| HQ-I11 | `SessaoDetalhada` erros por questão | Pro | SP |
| HQ-I12 | `StudyCoachService` determinístico | % 7 dias | T22 |
| HQ-I13 | Card “O que estudar hoje” | Home Pro | — |
| HQ-I14 | LLM opcional coach | Cota 3/dia | — |
| HQ-I15 | Spike oral STT | Branch experimental | — |
| HQ-I16 | Revisão jurídica 20 respostas IA | Checklist | — |

Doc: [ia-pro.md](../features/ia-pro.md)

---

## Ordem sugerida (primeiras 2 semanas)

```
T02 → T03 → HQ-P02 → HQ-P03 → HQ-P05 → HQ-P06 → T06 → T08 → T07 → T09 → HQ-P07 → T04 → T15
```

Depois: HQ-P08–P11 → T16–T20 → HQ-H03…
