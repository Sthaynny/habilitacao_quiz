# Arquitetura Flutter — Habilitação Quiz

Guia para implementação de features com **Clean Architecture**, **GetX** e limites **Free/Pro** no domínio.

## Camadas (`lib/app/features/<feature>/`)

| Camada | Pasta | Responsabilidade |
| :--- | :--- | :--- |
| Apresentação | `presentation/` | Widgets, `GetxController`, `Obx` escopado |
| Domínio | `domain/` | Entidades, repositórios (interfaces), use cases |
| Dados | `data/` | Models, datasources, implementação de repositórios |

Shared cross-feature: `lib/app/shared/` (entidades de quiz, repositórios).

Core transversal: `lib/core/` (estilos, componentes, store, constantes).

## Padrões obrigatórios

### Use case

- Um caso de uso por ação de negócio (`SalvarHistoricoUsecase`, `SimuladoQuizUsercase`).
- Injetar `ProGate` (ou serviços de quota) no construtor — **não** checar `kIsPro` só na UI.
- Retornar falhas tipadas (`Erro`, `Either` se já usado no módulo) em vez de `throw` genérico em fluxo de UI.

### Repositório

- Interface em `domain/repositories/`; implementação em `data/repositories/`.
- Datasource isolado (SP, assets, API futura).

### Controller GetX

- Estado reativo mínimo; delegar regras ao use case.
- `onInit` / `onClose` para subscriptions; evitar lógica de negócio longa no controller.

### Injeção

- `*_injection_continer.dart` por feature + `global_injection_container.dart`.
- Registrar dependências no mesmo padrão dos módulos existentes (`Get.put` / `Get.lazyPut`).

### Rotas

- `lib/app/features/routes/routes.dart` + binding na navegação (`Get.toNamed`).

## Free vs Pro (`ProGate`)

- Matriz de produto: [PRODUCT_PLAN](../product/PRODUCT_PLAN.md) seção 5.
- Implementação: `lib/app/shared/domain/services/pro_gate.dart` (+ stub em testes).
- Gates típicos: tamanho do simulado, histórico FIFO, quota diária, trilhas Aprender, export.

## UI e design system

- Regra Cursor: `.cursor/rules/habilitacao-quiz-ui.mdc`
- Tokens e componentes: [habilitacao-quiz-ds.md](./habilitacao-quiz-ds.md)
- Performance: `ListView.builder` em listas longas; `Obx` só no subtree que muda.

## Qualidade

- `flutter pub get` → `flutter analyze` → `flutter test` nos paths alterados.
- Sem APIs depreciadas; sem `google_mobile_ads` em código novo.
- Textos de interface em português (BR); nomes de código em inglês.

## Épico IA

Não implementar HQ-I* até receita do app **+** — ver [AI_FEATURES](../product/AI_FEATURES.md).
