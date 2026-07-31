# Tarefas a fazer — Habilitação Quiz

**Última atualização:** 30 de julho de 2026  
**Prioridades:** [PRIORIDADES.md](../planning/PRIORIDADES.md) · **Roadmap:** [ROADMAP.md](../planning/ROADMAP.md)

### Como usar

1. Ler **Objetivo** e **Critério de pronto**.
2. Seguir **Pistas** (código / doc).
3. Disparar o **subagente** da tabela em [AGENTS.md](../../AGENTS.md).
4. Ao concluir: mover para [FINALIZADAS.md](./FINALIZADAS.md).

---

## Status geral (jul/2026)

| Onda | Épico | Código | Agente |
| :---: | :--- | :---: | :--- |
| 1 | GATE + PROMO | ✅ | `feature-gate-store`, `feature-promo` |
| 2 | HIST | ✅ | `feature-historico` |
| 3 | LEARN + T26–T28 | ✅ (T28 conteúdo parcial) | `feature-aprendizado`, `feature-conteudo-questoes` |
| — | Publicação loja | ⏳ operacional | `feature-store-publish` |
| — | Acessibilidade | ⏳ por épico | `feature-a11y-implementer` |
| 4 | IA | 🔒 bloqueado | `feature-ia-pro` (readonly) |

`flutter analyze` limpo · **110** testes passando (jul/2026).

---

## Produto / documentação

| ID | Objetivo | Critério de pronto | Agente |
| :--- | :--- | :--- | :--- |
| T01 | Aprovar matriz Free/Pro e preço **+** | Decisão registrada em PRODUCT_PLAN | `hq-orchestrator` |

---

## [STORE-PUB] — Publicação Free e Quiz+

_Código T02–T20 concluído — ver [FINALIZADAS.md](./FINALIZADAS.md). Falta validação e loja._

| ID | Objetivo | Critério de pronto | Agente |
| :--- | :--- | :--- | :--- |
| T15 | Smoke AAB/APK Free + Pro | Checklist [SMOKE_PRO.md](../store/SMOKE_PRO.md) preenchido. **Compilação** APK Free/Pro validada em 2026-07-30 (§ Última validação automática); falta smoke **manual** no dispositivo + AAB | `feature-store-publish` |
| T16–T17 | Publicar ficha **+** na Play | App `.pro` em review; preço definido | `feature-store-publish` |
| T18 | `isProPublished` = estado real | URL da loja abre; flag alinhada | `feature-store-publish` |
| T19 | Data safety sem ads | Play Console atualizado (Free e **+**) | `feature-store-publish` |
| T20 | TestFlight iOS **+** | [IOS_TESTFLIGHT.md](../store/IOS_TESTFLIGHT.md) ok | `feature-store-publish` |

Doc: [docs/store/README.md](../store/README.md)

---

## [CONTEUDO] — Explicações no JSON (P09 / T28)

_Schema em `PerguntaModel` pronto; `legislacao.json` com `explicacao` em 56/56; demais temas pendentes (T28c)._

| ID | Objetivo | Critério de pronto | Agente |
| :--- | :--- | :--- | :--- |
| ~~T28a~~ | ~~`id` estável em todos os JSON~~ | ✅ 203 ids — ver [FINALIZADAS.md](./FINALIZADAS.md) | — |
| ~~T28b~~ | ~~`explicacao` — lote 1 (legislação completa)~~ | ✅ 56/56 `legislacao.json` — ver [FINALIZADAS.md](./FINALIZADAS.md) | — |
| T28c | `explicacao` — demais temas | Por arquivo, revisão CTB | `feature-conteudo-questoes` |
| T28d | `referencia_ctb` onde aplicável | Legislação + dir. defensiva | `feature-conteudo-questoes` |

---

## [A11Y] — Acessibilidade por épico

| ID | Objetivo | Critério de pronto | Agente |
| :--- | :--- | :--- | :--- |
| A11Y-GATE | Semantics limites + questionário | Checklist doc GATE sem blocker (snackbar limite + questionário feito; revisar checklist) | `feature-a11y-implementer` |
| ~~A11Y-PROMO~~ | ~~CTAs Quiz+ + tela **+**~~ | ✅ 2026-07-30 — ver [FINALIZADAS.md](./FINALIZADAS.md) | — |
| A11Y-HIST | Lista, chips, detalhe simulado | Checklist doc HIST sem blocker | `feature-a11y-implementer` |
| A11Y-LEARN | Hub Aprender + Markdown | Checklist doc LEARN sem blocker | `feature-a11y-implementer` |

Doc: [acessibilidade-implementacao.md](../features/acessibilidade-implementacao.md)

---

## [FREE-RET] — Retenção Free (pós-lançamento)

| ID | Objetivo | Critério de pronto | Agente |
| :--- | :--- | :--- | :--- |
| ~~F01~~ | ~~Onboarding matéria fraca~~ | ✅ 1ª sessão; SP; sheet opcional — ver [FINALIZADAS.md](./FINALIZADAS.md) | — |
| F02 | Lembrete local opt-in | Notificação agendável | `feature-free-evolution` |
| ~~F03~~ | ~~Empty state histórico~~ | ✅ Copy + CTA suave — ver [FINALIZADAS.md](./FINALIZADAS.md) | — |
| F04 | Patch JSON versionado | `contentVersion` ou script | `feature-free-evolution` |

---

## [IA] — Inteligência Pro 🔒

**Bloqueado** até receita do **+** — ver [AI_FEATURES.md](../product/AI_FEATURES.md). Agente `feature-ia-pro` (somente leitura).

| ID | Objetivo |
| :--- | :--- |
| HQ-I01 … HQ-I16 | Ver [ia-pro.md](../features/ia-pro.md) |

---

## Ordem sugerida (agora)

```
T01 (decisão) → T15 smoke manual → T16–T18 publicar + → A11Y-HIST/LEARN → T28c
```

Depois: T28d → F02/F04 → fechar A11Y-GATE (checklist) → IA (quando houver receita).
