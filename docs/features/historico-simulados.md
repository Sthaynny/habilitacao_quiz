# Histórico, simulados e retenção

**Épico:** [HIST] [GATE]  
**Ondas:** 1 (cap + gates) · 2 (histórico rico)

## Comportamento atual (código)

### Cap de 10 — Free via ProGate

Retenção Free: **10** entradas FIFO via `SalvarHistoricoUsecase` + `ProGate.maxResultadosHistorico`; Pro ilimitado (`null`). Ver `HistoricoEntity.add(maxResultados:)`.

### Modelo de dados (v2) — implementado (HQ-H03+)

- `id`, `tipo` (`tema` | `simulado`), `realizadoEm`
- `detalhePerguntas` opcional (Pro + simulado ao salvar — HQ-H04/HQ-H08)
- Migração JSON `schemaVersion: 2`; legado infere tipo por `titulo == Strings.simulado`

### UI (HQ-H05–H07)

- Chips: **Todos · Simulados · Temas** (`historico_list_filter.dart`)
- **Pro (T23):** busca por título + filtros **Aprovados / Reprovados**
- Cards com data, badge, `onTap` (`historico_widget.dart`)
- **Detalhe simulado (Pro):** `DetalheSimuladoScreen` — gabarito questão a questão
- **Free:** bottom sheet resumo + CTA **+**
- **Pro:** dashboard **Desempenho por matéria** (agrega temas + simulados com `materiaTitulo` no detalhe)

### Simulado

`simulado.dart` monta **30** questões com proporção por matéria; no histórico entra como qualquer quiz (`titulo: Strings.simulado`).

### Promo Quiz+ / sem AdMob (HQ-P08, HQ-H11)

- `HistoricoWidget`: cards clicáveis (HQ-H06); rodapé e estado vazio com `HabilitacaoQuizPlusCtaBanner`.
- Feature `historico/` **sem** `google_mobile_ads`, `BannerAd`, `AdHelper` ou `bannerAdNotifier` (regressão: `historico_no_admob_test.dart`).

## Gaps

| Gap | Impacto |
| :--- | :--- |
| Não distingue simulado vs tema | Filtros e métricas frágeis |
| Sem data | Sem evolução temporal |
| Cap 10 para Pro também | Pro não ganha valor de histórico |
| Sem revisão | Erros só na sessão ativa |

## Proposta

### Retenção

| Tier | Histórico |
| :--- | :--- |
| Free | **10** (manter FIFO atual) |
| Pro | **Ilimitado** — lógica no `ProGate` + `SalvarHistoricoUsecase`, não só em `add()` |

Ao expulsar o 11º no Free: snackbar + CTA **+**.

### Simulado (produto)

| Tier | Questões | Por dia |
| :--- | :---: | :---: |
| Free | 15 | 1 início |
| Pro | 30 | Ilimitado |

### Histórico — evolução UI (Onda 2) — parcial (HQ-H05–H07)

- Chips: **Todos · Simulados · Temas** — feito
- Cards com data, badge, `onTap` — feito
- **Detalhe simulado (Pro):** gabarito questão a questão — feito (`DetalheSimuladoScreen`)
- **Free:** resumo + CTA revisão no **+** — feito (bottom sheet)
- HQ-H08+: persistência/refino detalhe, copy 11º, métricas — ver [A_FAZER.md](../tasks/A_FAZER.md)

### Modelo de dados (v2) — feito HQ-H03/H04

- `id`, `tipo` (`tema` | `simulado`), `realizadoEm`
- `detalhePerguntas` opcional (Pro + simulado ao finalizar)
- Migração JSON `schemaVersion: 2`; inferir tipo por `titulo == Strings.simulado` em legado

## Wireframe (texto)

```
[ Todos | Simulados | Temas ]
┌ Desempenho por matéria (Pro) ────┐
│ Legislação ████████░░ 80%        │
│ ...                              │
┌ Simulado · 26/07 ─ 78% · 23/30 ─┐  → Detalhe (Pro)
┌ Legislação · 25/07 ─ 60% ────────┐
Free: "Últimos 10 resultados" [ + ilimitado ]
```

## Tarefas HQ-H01 … HQ-H12

Ver [A_FAZER.md](../tasks/A_FAZER.md#histórico--hq-h).
