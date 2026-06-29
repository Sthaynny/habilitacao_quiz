# Flutter — Padrões Material 3 em Código

Índice: [NaRisca](#narisca-agendamentos) · [Detecção](#detecção) · [Theme](#theme) · [Layout](#layout) · [Performance](#performance-de-layout) · [Botões](#botões) · [Forms](#formulários) · [Feedback](#feedback) · [Anti-padrões](#anti-padrões)

## NaRisca (agendamentos)

**Cenário A** — usar exclusivamente o DS do repositório. Referência canônica: [narisca-ds.md](narisca-ds.md).

| Necessidade | Usar |
|-------------|------|
| Inputs | `AppTextField`, `AppPhoneField`, `AppMoneyField`, … via `widgets.dart` |
| Botões | `AppButton`, `AppIconButton` |
| Spacing / raios | `AppSpacing.*`, `AppSizes.*` |
| Cores | `colorScheme` + `AppSemanticColors.of(context)` |
| Breakpoints | `AppBreakpoints.compact` (600), `medium` (800), `expanded` (1024) |
| Form layout | `Form` → `ListView` — `.cursor/rules/agendamentos-form-layout.mdc` |
| Estado | Cubit — `.cursor/rules/agendamentos-cubit-state.mdc` |
| Novos widgets | `.cursor/skills/flutter-components/SKILL.md` |
| Performance layout | [layout-performance.md](layout-performance.md) |

## Detecção

```
pubspec.yaml + lib/**/*.dart     → Flutter
lib/core/theme/                  → tokens do projeto (AppSpacing, AppSizes, AppColors)
lib/core/widgets/                → design system App* (usar antes de Material cru)
.cursor/rules/agendamentos-design-system.mdc
```

## Theme

```dart
final scheme = Theme.of(context).colorScheme;
final textTheme = Theme.of(context).textTheme;
final semantic = AppSemanticColors.of(context);

// Superfícies
scheme.surface / scheme.onSurface
scheme.surfaceContainerHighest   // cards, inputs
scheme.onSurfaceVariant          // texto secundário

// Ações
scheme.primary / scheme.onPrimary
scheme.error / scheme.onError

// Feedback além do ColorScheme
semantic.success / semantic.warning / semantic.info
```

| Papel | textTheme | Mínimo |
|-------|-----------|--------|
| Título página | `headlineSmall` / `headlineMedium` | 24sp |
| Seção | `titleLarge` | 20sp |
| Corpo | `bodyLarge` | 16sp |
| Caption | `bodySmall` | 12sp |

**Regras:**
- Nunca `Colors.grey[600]` em features — usar `scheme.onSurfaceVariant`
- Validar contraste em `ThemeMode.light` e `.dark` (`color_contrast.dart`)
- `MediaQuery.textScalerOf(context)` — layout não pode clipar em 200%

## Layout

### Formulário (padrão obrigatório no NaRisca)

```dart
Scaffold(
  appBar: AppBar(title: const Text('Título')),
  body: Form(
    key: _formKey,
    child: ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        MinhaSecao(), // filho DIRETO — sem Center envolvendo Row+Expanded
        const SizedBox(height: AppSpacing.xl),
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

### Página de leitura / dashboard

```dart
Scaffold(
  appBar: AppBar(title: const Text('Título')),
  body: SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text('Título', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.lg),
        // conteúdo
      ],
    ),
  ),
);
```

### Breakpoints (`AppBreakpoints`)

```dart
final width = MediaQuery.sizeOf(context).width;
final isCompact = width < AppBreakpoints.compact;      // 600
final isMedium = width >= AppBreakpoints.compact &&
    width < AppBreakpoints.expanded;                   // 600–1024
final isExpanded = width >= AppBreakpoints.expanded;   // 1024
```

| Largura | Layout |
|---------|--------|
| < 600 | coluna, `AppButton(fullWidth: true)`, `AppSpacing.md` padding |
| 600–1024 | 2 colunas opcional em seções que são filho direto do `ListView` |
| ≥ 1024 | max `AppBreakpoints.contentMaxWidth` (1200), sidebar + content |

**`Row` + `Expanded`:** permitido só quando a seção é filho direto do `ListView`; em `< AppBreakpoints.compact` empilhar em `Column`.

### Listas

- Conteúdo estático curto → `Column` em `ListView` / `SingleChildScrollView`
- Lista longa → `ListView.builder` ou `ListView.separated`
- Header + lista → `CustomScrollView` + slivers

### Cards

```dart
AppCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: AppSpacing.sm,
    children: [
      Text('Título', style: textTheme.titleMedium),
      Text(
        'Descrição',
        style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
    ],
  ),
)
```

## Performance de layout

Detalhes: [layout-performance.md](layout-performance.md). Resumo:

| Cenário | Padrão |
|---------|--------|
| 50+ itens | `ListView.builder` — não `Column` + loop |
| Várias seções na page | `BlocBuilder` com `buildWhen` por seção |
| Preview ao digitar | `ListenableBuilder` no preview apenas |
| Calendário / busca com rede | `InteractionDebouncer` + request id |
| Formulário | `Form` → `ListView`; sem scroll aninhado desnecessário |

## Botões

Usar `AppButton` — não `FilledButton` cru em telas novas.

| Variante | Enum | Uso |
|----------|------|-----|
| Primary | `AppButtonVariant.primary` | 1 por seção |
| Secondary | `AppButtonVariant.secondary` | cancelar, alternativa |
| Destructive | `AppButtonVariant.destructive` | delete + confirm |

| Tamanho | Enum | Altura |
|---------|------|--------|
| Compact | `AppButtonSize.compact` | 40px |
| Default | `AppButtonSize.defaultSize` | 48px |
| CTA | `AppButtonSize.cta` | 52px |

```dart
AppButton(
  label: 'Salvar',
  variant: AppButtonVariant.primary,
  size: AppButtonSize.defaultSize,
  isLoading: state.isSaving,
  onPressed: state.canSave ? cubit.save : null,
)
```

`AppIconButton` — variantes `primary`, `secondary`, `tertiary`, `destructive`; **`tooltip` obrigatório**.

Touch target mínimo: **`AppSizes.touchTargetMin` (48)**.

## Formulários

Wrappers do projeto — import `package:agendamentos/core/widgets/widgets.dart`:

```dart
AppEmailField(
  controller: _emailController,
  validator: FormValidators.email,
  textInputAction: TextInputAction.next,
)

AppPhoneField(
  controller: _phoneController,
  validator: FormValidators.phone,
)

AppMoneyField(
  controller: _priceController,
  validator: FormValidators.positiveMoney,
)
```

- Label visível sempre (`label` no `AppTextField`, não só hint)
- `SizedBox(height: AppSpacing.md)` entre campos; `AppSpacing.xl` entre seções
- Estado de submit via Cubit + `AppButton(isLoading:)`, não `setState`
- Validação: `FormValidators.*` de `lib/core/forms/forms.dart`
- Exibição BRL: `FormatUtils.currencyBrl`; parse: `MoneyUtils.parseBrl`

## Semantics

```dart
AppIconButton(
  tooltip: 'Excluir',  // obrigatório
  icon: Icons.delete_outline,
  onPressed: onDelete,
)

Semantics(
  label: 'Agendar consulta',
  button: true,
  child: customTile,
)

ExcludeSemantics(child: Icon(Icons.decorative))
```

## Feedback

| Situação | Padrão NaRisca |
|----------|----------------|
| Lista loading | `AppLoadingState` |
| Botão submit | `AppButton(isLoading: true)` |
| Empty | `AppEmptyState` + CTA opcional |
| Erro de lista | `AppErrorState(onRetry: ...)` |
| Sucesso | `context.showSuccess(...)` (`app_feedback.dart`) |
| Erro | `context.showError(...)`; preservar controllers |
| Navegação pós-ação | `BlocListener`, não SnackBar em `build` |

## Micro-interactions

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  decoration: BoxDecoration(
    color: selected ? scheme.primaryContainer : scheme.surface,
    borderRadius: AppSizes.borderRadiusMd,
  ),
  child: child,
)
```

- 150–300ms para feedback UI
- `MediaQuery.disableAnimationsOf(context)` respeitado

## Anti-padrões

| Evitar | Preferir |
|--------|----------|
| `Colors.red` | `scheme.error` |
| `ElevatedButton` / `TextField` em telas novas | `AppButton` / `AppTextField` |
| `RadioListTile`, `FilterChip` cru | `AppRadioGroup`, `AppChipGroup` |
| `setState` para listas | Cubit + `BlocBuilder` |
| `fontSize: 13` hardcoded | `textTheme.bodyMedium` |
| `EdgeInsets.all(12)` | `AppSpacing.md` |
| `BorderRadius.circular(12)` inline | `AppSizes.borderRadiusMd` |
| `ListView` → `Center` → `Row(Expanded)` | form-layout rule |
| `Column` com dezenas de filhos em scroll | `ListView.builder` |
| Page inteira em `BlocBuilder` sem `buildWhen` | seções isoladas |
| `opacity: 0.3` disabled | `onSurface.withValues(alpha: 0.38)` |

## Checklist Flutter (NaRisca)

- [ ] Um `AppButton(primary)` por seção de viewport
- [ ] `AppSpacing.md` padding horizontal em mobile
- [ ] `AppSpacing` em múltiplos de 4/8
- [ ] `tooltip` em todo `AppIconButton`
- [ ] Tema central — zero `Colors.*` em features
- [ ] Formulário: `Form` → `ListView` sem colapso de largura
- [ ] Listas longas virtualizadas (`ListView.builder`)
