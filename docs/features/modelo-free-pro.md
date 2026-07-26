# Modelo Free + Habilitação Quiz+

**Épicos:** [GATE] [STORE]  
**Onda:** 1 (fundação) + publicação loja  
**Referência:** [Cura.li PRODUCT_PLAN](../../../cura.li/docs/product/PRODUCT_PLAN.md)

## Decisão

- **Dois apps**, um repositório Flutter.
- **Free:** `br.com.sthaynny.habilitacao_quiz`, limites de estudo, promo do **+**.
- **Pro:** `br.com.sthaynny.habilitacao_quiz.pro`, compra única na loja, `HABILITACAO_QUIZ_PRO=true`.

## Matriz resumida

| Recurso | Free | Pro |
| :--- | :---: | :---: |
| Questões por sessão (tema) | 15 | Banco completo |
| Simulado | 15q, 1/dia | 30q, ilimitado |
| Histórico | 10 (FIFO — **já no código**) | Ilimitado |
| Promo **+** | Sim | Não |
| AdMob | Não | Não |
| Aprender / IA | Básico / nenhuma | Completo / sim |

Detalhes: [PRODUCT_PLAN.md](../product/PRODUCT_PLAN.md) §5.

## ProGate (proposta)

Arquivo: `lib/app/shared/domain/services/pro_gate.dart`

| Constante | Free | Pro |
| :--- | :---: | :---: |
| `maxQuestoesSessaoTemaFree` | 15 | `null` |
| `maxQuestoesSimuladoFree` | 15 | 30 (via ilimitado) |
| `maxSimuladosPorDiaFree` | 1 | `null` |
| `maxResultadosHistoricoFree` | 10 | `null` |
| `exibirPromoPlus` | true | false |

`CompileTimeProGate` lê `kIsPro` de `app_edition.dart`.

## Regras de produto

1. FIFO de 10 no Free — **já em** `HistoricoEntity.add()`; no Pro, remover cap.
2. Não interromper questionário em andamento.
3. Limites no domínio, não só na UI.

## Tarefas

Ver [A_FAZER.md](../tasks/A_FAZER.md) — blocos **T02–T09**, **T15–T20**.
