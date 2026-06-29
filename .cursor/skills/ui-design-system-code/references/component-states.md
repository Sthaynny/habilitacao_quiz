# Estados de Componente — Anatomia em Código

Todo interativo implementa estes estados. Índice: [Matriz](#matriz-de-estados) · [Web](#web-tailwind--cva) · [shadcn](#shadcn--radix) · [Flutter](#flutter-m3) · [Feedback](#feedback-assíncrono)

## Matriz de estados

| Estado | Visual | Comportamento | ARIA |
|--------|--------|---------------|------|
| Default | estilos base | — | — |
| Hover | bg/border sutil | desktop only | — |
| Focus-visible | ring outline | só teclado | — |
| Active/Pressed | tom mais escuro | feedback tátil | — |
| Disabled | opacidade reduzida | `pointer-events: none` | `disabled` / `aria-disabled` |
| Loading | spinner | bloqueia re-submit | `aria-busy="true"` |
| Error | border/text vermelho | — | `aria-invalid="true"` |
| Selected | bg accent | tabs, chips | `aria-selected` / `data-state` |

## Web (Tailwind + cva)

```tsx
const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-lg text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90 active:bg-primary/80",
        outline: "border border-input bg-background hover:bg-accent active:bg-accent/80",
        ghost: "hover:bg-accent active:bg-accent/80",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
      },
      size: {
        default: "h-10 px-4 py-2",
        lg: "h-11 px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: { variant: "default", size: "default" },
  }
);
```

**Input com erro:**

```html
<input
  class="border-input focus-visible:ring-ring aria-invalid:border-destructive aria-invalid:ring-destructive/20"
  aria-invalid="true"
  aria-describedby="error-msg"
/>
<p id="error-msg" role="alert" class="text-sm text-destructive">E-mail inválido</p>
```

## shadcn / Radix

Estados expostos via `data-*`:

```html
<button class="data-[state=open]:bg-accent data-[disabled]:opacity-50">
```

| Componente | Atributos úteis |
|------------|-----------------|
| Dialog | `data-state=open|closed` |
| Tabs | `data-state=active` no trigger |
| Accordion | `data-state=open` |
| Switch | `data-state=checked` |

**Dialog canônico** — ver [web-react-shadcn-patterns.md](web-react-shadcn-patterns.md).

## Flutter M3

### NaRisca — usar wrappers do projeto

```dart
AppButton(
  label: 'Salvar',
  variant: AppButtonVariant.primary,
  isLoading: state.isSaving,
  onPressed: state.canSave ? cubit.save : null,
)

AppTextField(
  controller: _emailController,
  label: 'E-mail',
  validator: FormValidators.email,
  // errorText via validator → InputDecoration.errorText automático
)
```

| Estado | Implementação NaRisca |
|--------|----------------------|
| Disabled | `onPressed: null` em `AppButton` |
| Loading | `AppButton(isLoading: true)` — spinner + onPressed null |
| Error field | `validator:` com `FormValidators.*` |
| Selected chip/segmento | `AppChipGroup`, `AppSegmentedControl` |
| Icon-only | `AppIconButton` + `tooltip` obrigatório |

Detalhes: [narisca-ds.md](narisca-ds.md), [flutter-patterns.md](flutter-patterns.md).

### Material cru (só se design-exception documentada)

```dart
FilledButton.styleFrom(
  minimumSize: Size.fromHeight(AppSizes.buttonHeightDefault),
  // preferir AppButton em código novo
)
```

## Hierarquia de botões (código)

| Variante | Web | Flutter (NaRisca) | Uso |
|----------|-----|-------------------|-----|
| Primary | `default` / solid | `AppButton(primary)` | 1 por seção |
| Secondary | `outline` | `AppButton(secondary)` | cancelar, alternativa |
| Tertiary | `ghost` | `AppIconButton(tertiary)` | baixa ênfase icon-only |
| Destructive | `destructive` | `AppButton(destructive)` | delete com confirm |

## Feedback assíncrono

| Situação | Web | Flutter |
|----------|-----|---------|
| Lista carregando | Skeleton / `aria-busy` | `CircularProgressIndicator`, skeleton |
| Botão submit | Spinner + disabled | `isLoading: true` |
| Sucesso | Toast `aria-live="polite"` | `SnackBar` |
| Erro rede | Toast + preservar input | `SnackBar` + manter controllers |
| Empty | Empty state + CTA | `AppEmptyState` |

```tsx
async function onSubmit() {
  setPending(true);
  try {
    await api.save(data);
    toast.success('Salvo com sucesso');
  } catch {
    toast.error('Não foi possível salvar. Tente novamente.');
  } finally {
    setPending(false);
  }
}
```

## Motion

```css
transition-colors duration-150;
```

```dart
AnimatedContainer(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut, ...)
```

- Duração UI: **150–300ms**
- Respeitar `prefers-reduced-motion` / `MediaQuery.disableAnimationsOf`
