# Finalizadas

| ID | Tarefa | Data |
| :--- | :--- | :--- |
| HQ-P01 | `app_edition.dart` (igual T02) | 2026-07-26 |
| HQ-P02 | `AppStoreConstants` | 2026-07-26 |
| HQ-P03 | `HabilitacaoQuizPlusCtaBanner` + widget test | 2026-07-26 |
| HQ-P04 | `app_store_launcher.dart` | 2026-07-26 |
| HQ-P05 | Tela **+** + rota `/habilitacao-quiz-plus` | 2026-07-26 |
| HQ-P06 | CTA na Home (sem AdMob) | 2026-07-26 |
| HQ-P07 | Remoção `google_mobile_ads` | 2026-07-26 |
| HQ-P08 | CTA histórico (lista) | 2026-07-26 |
| HQ-P09 | CTA resultado simulado Free | 2026-07-26 |
| HQ-P10 | CTA limites ProGate | 2026-07-26 |
| HQ-P11 | Item **+** aviso legal | 2026-07-26 |
| HQ-P12 | UTMs Play em `docs/store/` | 2026-07-26 |
| HQ-P13 | Checklist publicação Pro + flag | 2026-07-26 |
| T31 | Analytics funil promo (impressão/clique) | 2026-07-26 |
| — | Documentação produto v1.1 (docs/, features, planning, tasks) | 2026-07-26 |
| T02 | `kIsPro` / `AppEditionNames` (`app_edition.dart`, `kAppDisplayName` no app) | 2026-07-26 |
| T03 | `ProGate` + `StubProGate` + testes unitários | 2026-07-26 |
| T04 | Flavors Android `free` / `pro` (IDs e display name) | 2026-07-26 |
| T05 | `docs/store/BUILD.md` | 2026-07-26 |
| T06 | Limites de tema via `QuizRepository` + `ProGate` | 2026-07-26 |
| T07 | Contador simulados/dia (`SimuladoQuotaService`) | 2026-07-26 |
| T08 | Simulado 15 vs 30 questões (`simulado.dart` + testes) | 2026-07-26 |
| T09 | Histórico FIFO Free / ilimitado Pro (teste 15 saves) | 2026-07-26 |
| T15 | `docs/store/SMOKE_PRO.md` | 2026-07-26 |
| T16 | Listings Pro em `google_play/store_listing_pro_*` | 2026-07-26 |
| T17 | Preço Play **+** documentado em `docs/store/PLAY_CONSOLE.md` | 2026-07-26 |
| T18 | `isProPublished` default `true` (`app_store_constants.dart`) | 2026-07-26 |
| T19 | Data safety / privacidade (nota repo `PLAY_CONSOLE.md`) | 2026-07-26 |
| T20 | iOS `EditionPro.xcconfig` + `IOS_TESTFLIGHT.md` | 2026-07-26 |
| HQ-H01 | `ProGate.maxResultadosHistorico` | 2026-07-26 |
| HQ-H02 | Cap em `SalvarHistoricoUsecase` | 2026-07-26 |
| HQ-H03 | `ResultadoEntity` v2 + migração JSON | 2026-07-26 |
| HQ-H04 | Tipo/data ao finalizar quiz | 2026-07-26 |
| HQ-H05 | Chips Todos/Simulados/Temas | 2026-07-26 |
| HQ-H06 | Cards clicáveis + data/badge | 2026-07-26 |
| HQ-H07 | `DetalheSimuladoScreen` (Pro) | 2026-07-26 |
| HQ-H08 | Persistir detalhe perguntas Pro | 2026-07-26 |
| HQ-H11 | Remover resíduo AdMob histórico | 2026-07-26 |
| T25 | Backup/restauração JSON Pro (`file_picker` + `share_plus`) | 2026-07-26 |

---

## [HIST] HQ-H01 … HQ-H07 — detalhe para agentes

| ID | O que foi feito | Arquivos-chave | Como validar | Dependências |
| :--- | :--- | :--- | :--- | :--- |
| **HQ-H01** | Getter `maxResultadosHistorico` (Free `10`, Pro `null`) e `podeSalvarResultado` em `ProGate` / `CompileTimeProGate` / `StubProGate`. | `lib/app/shared/domain/services/pro_gate.dart`, `test/shared/domain/services/pro_gate_test.dart` | `flutter test test/shared/domain/services/pro_gate_test.dart` | T03 |
| **HQ-H02** | FIFO Free e persistência centralizados em `SalvarHistoricoUsecase.registrarResultado` com `SalvarHistoricoOutcome.removeuMaisAntigoPorLimiteFree`; `HistoricoEntity.add(maxResultados:)`. | `lib/app/features/historico/domain/usecases/salvar_historico_usecase.dart`, `lib/app/features/historico/domain/entities/historico_entity.dart`, `lib/app/features/questionario/presentation/controller/questionario_controller.dart`, `test/features/historico/domain/usecases/salvar_historico_usecase_test.dart` | `flutter test test/features/historico/domain/usecases/salvar_historico_usecase_test.dart test/features/historico/domain/entities/historico_entity_test.dart` | HQ-H01 |
| **HQ-H03** | `ResultadoEntity` com `id`, `tipo` (`TipoResultado`), `realizadoEm`, `detalhePerguntas` opcional; `HistoricoModel` `schemaVersion: 2`; migração v1 sem `id` infere tipo por `titulo == Strings.simulado`. | `lib/app/features/resultado/domain/resultado_entity.dart`, `lib/app/features/resultado/data/models/resultado_model.dart`, `lib/app/features/historico/data/models/historico_model.dart`, `test/features/historico/data/models/historico_model_test.dart` | `flutter test test/features/historico/data/models/historico_model_test.dart` | HQ-H02 |
| **HQ-H04** | `MapQuizToResultado` preenche metadados ao fim do questionário; Pro + simulado monta `detalhePerguntas` para gabarito. | `lib/app/features/resultado/domain/map_quiz_to_resultado.dart`, `lib/app/features/questionario/presentation/controller/questionario_controller.dart`, `test/features/resultado/domain/map_quiz_to_resultado_test.dart` | `flutter test test/features/resultado/domain/map_quiz_to_resultado_test.dart` | HQ-H03 |
| **HQ-H05** | Chips `FilterChip` Todos/Simulados/Temas; `filtrarEOrdenarHistorico` em `historico_list_filter.dart`. | `lib/app/features/historico/presentation/historico_widget.dart`, `lib/app/features/historico/presentation/historico_list_filter.dart`, `lib/core/utils/strings.dart` (`historicoFiltro*`), `test/features/historico/presentation/historico_list_filter_test.dart` | `flutter test test/features/historico/presentation/historico_list_filter_test.dart` | HQ-H03 |
| **HQ-H06** | Cards com badge tema/simulado, data (`Strings.historicoDataLabel`), `InkWell`; Pro simulado → `DetalheSimuladoScreen`; Free → bottom sheet + CTA `Routes.habilitacaoQuizPlus`. | `lib/app/features/historico/presentation/historico_widget.dart`, `lib/core/utils/strings.dart` (`historicoBadge*`, `historicoResumoFree*`) | Manual na aba Histórico; `flutter analyze lib/app/features/historico/presentation/historico_widget.dart` | HQ-H05, HQ-H07 |
| **HQ-H07** | Tela `DetalheSimuladoScreen` lista gabarito (`ResultadoPerguntaDetalheEntity`); rota `Routes.detalheSimulado` em `my_app.dart`. | `lib/app/features/historico/presentation/detalhe_simulado_screen.dart`, `lib/app/features/routes/routes.dart`, `lib/app/my_app.dart` | Abrir card simulado Pro com `detalhePerguntas`; `flutter analyze lib/app/features/historico/presentation/detalhe_simulado_screen.dart` | HQ-H04, HQ-H06 |
| **T21** | Critério produto: Pro persiste **≥15** resultados sem FIFO (`maxResultadosHistorico: null` + `SalvarHistoricoUsecase`); reforço de testes T09/HQ-H02. | `lib/app/shared/domain/services/pro_gate.dart`, `lib/app/features/historico/domain/usecases/salvar_historico_usecase.dart`, `test/features/historico/domain/usecases/salvar_historico_usecase_test.dart`, `test/shared/domain/services/pro_gate_test.dart`, `test/features/historico/domain/entities/historico_entity_test.dart` | `flutter test test/features/historico/domain/usecases/salvar_historico_usecase_test.dart test/shared/domain/services/pro_gate_test.dart test/features/historico/domain/entities/historico_entity_test.dart` | T09, HQ-H01, HQ-H02 |
| **HQ-H08** | `resultadoParaPersistenciaHistorico` em `SalvarHistoricoUsecase` — só simulado Pro grava `detalhePerguntas`; Free/tema nunca persistem gabarito (complementa `MapQuizToResultado`). | `lib/app/features/historico/domain/resultado_para_historico.dart`, `lib/app/features/historico/domain/usecases/salvar_historico_usecase.dart`, `test/features/historico/domain/resultado_para_historico_test.dart`, `test/features/historico/data/datasources/historico_datasource_test.dart` | `flutter test test/features/historico/domain/resultado_para_historico_test.dart test/features/historico/data/datasources/historico_datasource_test.dart test/features/historico/domain/usecases/salvar_historico_usecase_test.dart test/features/historico/data/models/historico_model_test.dart test/features/resultado/domain/map_quiz_to_resultado_test.dart` | HQ-H04, HQ-H07 |
| **HQ-H11** | Feature `historico/` sem AdMob; CTA **+** no rodapé (`HabilitacaoQuizPlusCtaBanner`, HQ-P08). Teste `historico_no_admob_test.dart`. | `lib/app/features/historico/presentation/historico_widget.dart`, `test/features/historico/presentation/historico_no_admob_test.dart` | `flutter test test/features/historico/presentation/historico_no_admob_test.dart` | HQ-P07, HQ-P08 |
