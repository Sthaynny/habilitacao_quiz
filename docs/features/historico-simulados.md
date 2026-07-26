# Histórico, simulados e retenção

**Épico:** [HIST] [GATE]  
**Ondas:** 1 (cap + gates) · 2 (histórico rico)

## Comportamento atual (código)

### Cap de 10 — já existe

```10:15:lib/app/features/historico/domain/entities/historico_entity.dart
  void add(ResultadoEntity resultadoEntity) {
    if (resutados.length > 9) {
      resutados.removeAt(0);
    }
    resutados.add(resultadoEntity);
  }
```

Todos os usuários (Free e futuro Pro) hoje têm **no máximo 10** entradas FIFO.

### O que cada resultado guarda

`ResultadoEntity`: `titulo`, `totalPerguntas`, `totalRespostasCorretas`, `percentual`, `result` (≥ 70%).

**Não há:** data/hora, tipo (simulado vs tema), detalhe por pergunta, replay.

### Simulado

`simulado.dart` monta **30** questões com proporção por matéria; no histórico entra como qualquer quiz (`titulo: Strings.simulado`).

### UI

- `HistoricoWidget`: lista de cards; **não clicáveis**.
- Promo AdMob no estado (código morto no layout do histórico).

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

### Histórico — evolução UI (Onda 2)

- Chips: **Todos · Simulados · Temas**
- Cards com data, badge, `onTap`
- **Detalhe simulado (Pro):** gabarito questão a questão
- **Free:** resumo + CTA revisão no **+**

### Modelo de dados (v2)

- `id`, `tipo` (`tema` | `simulado`), `realizadoEm`
- `detalhePerguntas` opcional (Pro + simulado)
- Migração JSON `schemaVersion: 2`; inferir tipo por `titulo == simulado`

## Wireframe (texto)

```
[ Todos | Simulados | Temas ]
┌ Simulado · 26/07 ─ 78% · 23/30 ─┐  → Detalhe (Pro)
┌ Legislação · 25/07 ─ 60% ────────┐
Free: "Últimos 10 resultados" [ + ilimitado ]
```

## Tarefas HQ-H01 … HQ-H12

Ver [A_FAZER.md](../tasks/A_FAZER.md#histórico--hq-h).
