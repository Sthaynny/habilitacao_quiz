# Documentação — Habilitação Quiz

Índice central do app e do produto **Free + Habilitação Quiz+**.

**Novo no repositório?** Comece por [getting-started.md](./getting-started.md).

## Pastas

| Pasta | Conteúdo |
| :--- | :--- |
| [product/](./product/) | Visão de produto, matriz Free/Pro, IA (planejada) |
| [features/](./features/) | Especificações por épico (promo Pro, histórico, aprendizado, gate) |
| [planning/](./planning/) | Roadmap, ondas, prioridades, roteiro de apresentação |
| [tasks/](./tasks/) | Backlog acionável (HQ-*, T*) e tarefas concluídas |
| [engineering/](./engineering/) | Arquitetura Flutter, design system, protocolo de commit |
| [store/](./store/) | Builds Free/Pro, Play Console, smoke e UTMs |

## Leitura rápida

1. [PRODUCT_PLAN.md](./product/PRODUCT_PLAN.md) — decisões e matriz de recursos  
2. [ROADMAP.md](./planning/ROADMAP.md) — fases e ondas  
3. [A_FAZER.md](./tasks/A_FAZER.md) — o que atacar agora  
4. [BUILD.md](./store/BUILD.md) — flavors e artefatos de release  

## Agentes e épicos

Orquestração e subagentes: [AGENTS.md](../AGENTS.md). Cada spec em `features/` mapeia um épico:

| Feature doc | Épico | Subagente |
| :--- | :--- | :--- |
| [modelo-free-pro.md](./features/modelo-free-pro.md) | [GATE][STORE] | `feature-gate-store` |
| [promocao-quiz-plus.md](./features/promocao-quiz-plus.md) | [PROMO] | `feature-promo` |
| [historico-simulados.md](./features/historico-simulados.md) | [HIST] | `feature-historico` |
| [area-aprendizado.md](./features/area-aprendizado.md) | [LEARN] | `feature-aprendizado` |
| [ia-pro.md](./features/ia-pro.md) | [IA] | `feature-ia-pro` (guardião; sem implementação até receita do **+**) |
| [acessibilidade-implementacao.md](./features/acessibilidade-implementacao.md) | A11y | `feature-a11y-implementer` |

## Princípio atualizado (jul/2026)

Os espaços hoje ocupados por **AdMob** passam a promover o **Habilitação Quiz+** (app pago na loja), não anúncios de terceiros. O Free continua **sem rede de ads**.
