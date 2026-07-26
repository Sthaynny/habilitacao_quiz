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

_Tarefas T02–T09 e T15–T20 concluídas em 26/07/2026 — ver [FINALIZADAS.md](./FINALIZADAS.md)._

---

## [PROMO] — Promo Quiz+

_Tarefas HQ-P01–HQ-P13 e T31 concluídas em 26/07/2026 — ver [FINALIZADAS.md](./FINALIZADAS.md)._

Doc: [promocao-quiz-plus.md](../features/promocao-quiz-plus.md)

---

## [HIST] — Histórico e simulados

_Tarefas HQ-H01–HQ-H12, T21–T25 concluídas em 26/07/2026 — ver [FINALIZADAS.md](./FINALIZADAS.md)._

Doc: [historico-simulados.md](../features/historico-simulados.md)

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
