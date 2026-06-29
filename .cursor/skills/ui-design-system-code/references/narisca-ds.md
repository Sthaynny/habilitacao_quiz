# Design System — NaRisca (agendamentos)

> **Nota:** Este arquivo é referência de outro projeto. Para o **Habilitação Quiz**, usar [habilitacao-quiz-ds.md](habilitacao-quiz-ds.md).

Índice: [Classificação](#classificação) · [Regras](#regras-do-projeto) · [Tokens](#tokens) · [Componentes](#componentes-app) · [Formulários](#formulários) · [Estado](#estado-e-feedback) · [Skills relacionadas](#skills-relacionadas)

**Cenário A — DS maduro.** Usar exclusivamente tokens e widgets do repositório (`lib/core/theme/`, `lib/core/widgets/`).

## Classificação

| Critério | Fonte no repositório |
|----------|----------------------|
| Tema central | `lib/core/theme/app_theme.dart`, `tenant_theme.dart` |
| Cores | `lib/core/theme/app_colors.dart` → `ColorScheme` + `AppSemanticColors` |
| Spacing | `lib/core/theme/app_spacing.dart` → `AppSpacing` |
| Tamanhos / raios | `lib/core/theme/app_sizes.dart` → `AppSizes` |
| Breakpoints | `lib/core/theme/app_breakpoints.dart` → `AppBreakpoints` |
| Widgets DS | `lib/core/widgets/` → prefixo `App*` |
| Validação / máscaras | `lib/core/forms/forms.dart` → `FormValidators`, `InputFormatters` |
| Formatação BR | `lib/core/utils/format_utils.dart`, `money_utils.dart` |

## Regras do projeto

Carregar conforme a tarefa:

| Regra | Arquivo | Escopo |
|-------|---------|--------|
| Design system (inputs, botões, tokens) | `.cursor/rules/agendamentos-design-system.mdc` | `lib/**/*.dart` |
| Layout de formulários (`Form` + `ListView`) | `.cursor/rules/agendamentos-form-layout.mdc` | `*_page.dart`, `*_form*.dart` |
| Estado de tela (Cubit, sem `setState` de dados) | `.cursor/rules/agendamentos-cubit-state.mdc` | presentation |
| Modularização de widgets | `.cursor/skills/flutter-components/SKILL.md` | novos componentes |
| Nomenclatura | `.cursor/rules/agendamentos-naming.mdc` | identificadores |
| Debounce em calendário/busca | `.cursor/rules/agendamentos-interaction-debouncer.mdc` | Cubits com rede |
| Layout performático | [layout-performance.md](layout-performance.md) | scroll, rebuild, virtualização |

## Tokens

### Spacing (`AppSpacing`)

| Token | px | Uso típico |
|-------|-----|------------|
| `xs` | 4 | gap ícone–texto |
| `sm` | 8 | padding interno compacto |
| `md` | 16 | padding de página, gap entre campos |
| `lg` | 24 | gap entre grupos, padding vertical de seção |
| `xl` | 32 | entre seções de formulário |
| `xxl` | 48 | hero / margens amplas |

### Tamanhos (`AppSizes`)

| Token | Valor | Uso |
|-------|-------|-----|
| `touchTargetMin` | 48 | alvo mínimo de toque |
| `radiusSm` | 8 | chips, segmentos |
| `radiusMd` | 12 | botões, cards, inputs |
| `buttonHeightCompact` / `default` / `cta` | 40 / 48 / 52 | `AppButtonSize` |
| `segmentedHeight` | 40 | `AppSegmentedControl` |
| `radioTileMinHeight` | 48 | `AppRadioGroup` |

### Cores

```dart
final scheme = Theme.of(context).colorScheme;
final semantic = AppSemanticColors.of(context);

// Texto e superfícies
scheme.surface / scheme.onSurface
scheme.onSurfaceVariant          // texto secundário
scheme.surfaceContainerHighest   // cards, inputs

// Ações
scheme.primary / scheme.onPrimary
scheme.error / scheme.onError

// Feedback (além do ColorScheme)
semantic.success / semantic.warning / semantic.info
```

### Breakpoints (`AppBreakpoints`)

| Token | px | Uso |
|-------|-----|-----|
| `compact` | 600 | empilhar `Row`+`Expanded` em formulários |
| `medium` | 800 | layout intermediário |
| `expanded` | 1024 | sidebar + conteúdo |
| `contentMaxWidth` | 1200 | largura máxima de dashboard |

## Componentes `App*`

Import barrel (inputs, ações, seleção): `package:agendamentos/core/widgets/widgets.dart`

Catálogo completo: [.cursor/skills/flutter-components/catalog.md](../../flutter-components/catalog.md)

| Necessidade | Widget | Evitar em código novo |
|-------------|--------|----------------------|
| Texto genérico | `AppTextField` | `TextField` cru |
| E-mail / senha / telefone / moeda | `AppEmailField`, `AppPasswordField`, `AppPhoneField`, `AppMoneyField` | `AppTextField` + formatters manuais |
| Busca / select / horário | `AppSearchField`, `AppDropdownField`, `AppTimeField` | `InputDecoration` custom inline |
| CTA / ações | `AppButton`, `AppIconButton` | `ElevatedButton`, `IconButton` cru |
| Seleção | `AppRadioGroup`, `AppSegmentedControl`, `AppChipGroup` | `RadioListTile`, `SegmentedButton`, `FilterChip` cru |
| Card de listagem | `AppCard` | `Card` sem tema |
| Empty / erro / loading | `AppEmptyState`, `AppErrorState`, `AppLoadingState` | placeholder ad hoc |
| SnackBar | extensões em `app_feedback.dart` | `SnackBar` manual sem tema |

### `AppButton`

| Variante | Material base | Uso |
|----------|---------------|-----|
| `primary` | `FilledButton` | 1 CTA por seção |
| `secondary` | `OutlinedButton` | cancelar, alternativa |
| `destructive` | `FilledButton` + `scheme.error` | exclusão (com confirmação) |

| Tamanho | Altura |
|---------|--------|
| `compact` | 40px |
| `defaultSize` | 48px |
| `cta` | 52px |

`isLoading: true` desabilita o botão e exibe spinner — não duplicar lógica na feature.

### `AppIconButton`

Variantes: `primary`, `secondary`, `tertiary`, `destructive`. **Obrigatório** `tooltip` em ações icon-only (a11y).

## Formulários

Padrão obrigatório — ver `.cursor/rules/agendamentos-form-layout.mdc`:

```dart
Scaffold(
  appBar: AppBar(title: const Text('Título')),
  body: Form(
    key: _formKey,
    child: ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        MinhaSecaoDeCampos(), // filho DIRETO do ListView
        const SizedBox(height: AppSpacing.md),
      ],
    ),
  ),
  bottomNavigationBar: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppButton(label: 'Salvar', onPressed: _save),
    ),
  ),
);
```

**Proibido:** `ListView` → `Center` → `Column` → `Row(Expanded)` (colapso de largura 0).

Referências: `service_form_page.dart`, `expense_batch_page.dart`, `service_form_body.dart`.

Validação: `FormValidators.*` via `lib/core/forms/forms.dart` — limites de domínio no Cubit/domain, não na page.

## Estado e feedback

| Situação | Padrão no projeto |
|----------|-------------------|
| Dados de tela | Cubit + `BlocBuilder` / `BlocListener` |
| Submit assíncrono | `AppButton(isLoading: state.isSaving)` |
| Sucesso / erro | `context.showSuccess()` / `showError()` ou `BlocListener` |
| Lista vazia | `AppEmptyState` com CTA opcional |
| `setState` | só com `// ui-local` (tabs, animação) |

## Performance de layout

Antes de tokens visuais, validar estrutura — [layout-performance.md](layout-performance.md):

- Listas longas: `ListView.builder` / `.separated`
- Formulário: `Form` → `ListView`; seções com `mainAxisSize: min`
- Rebuild: `BlocBuilder` + `buildWhen` por seção; `ListenableBuilder` em preview
- Rede repetida: `InteractionDebouncer` + `_loadRequestId` no Cubit
- Loading local: `AppLoadingState` / `AppButton(isLoading:)` — não bloquear shell inteiro

## Exceções documentadas

- `// design-exception: <motivo>` — layout ou estilo único (ex.: composer de chat)
- `// layout-exception: <motivo>` — estrutura de scroll excepcional testada em múltiplos viewports

## Mapa papel UI → token local

| Papel UI | Token / API do projeto |
|----------|------------------------|
| Fundo da página | `scheme.surface` |
| Card / input | `scheme.surfaceContainerHighest` |
| Título | `textTheme.headlineSmall` / `titleLarge` |
| Texto secundário | `scheme.onSurfaceVariant` |
| Borda | `scheme.outlineVariant` |
| CTA primário | `AppButton(variant: primary)` |
| Sucesso / aviso / info | `AppSemanticColors.success` / `.warning` / `.info` |
| Gap campo→campo | `AppSpacing.md` (16) |
| Gap seção→seção | `AppSpacing.xl` (32) |
| Padding de página | `EdgeInsets.all(AppSpacing.md)` |
| Raio de botão/card | `AppSizes.radiusMd` |

## Skills relacionadas

| Skill | Quando usar junto |
|-------|-------------------|
| [flutter-components](../../flutter-components/SKILL.md) | Criar ou modularizar widgets `App*` / feature |
| [design](../../design/SKILL.md) | Implementação de alta fidelidade a partir de Figma/mockup |
| `design-heuristics-aesthetic-optimizer` (skill global Cursor) | Auditoria Nielsen/WCAG sem implementar código |
