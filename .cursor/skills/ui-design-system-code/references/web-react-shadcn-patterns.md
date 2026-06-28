# Web — React, shadcn/ui e Radix

Índice: [Filosofia](#filosofia) · [Button](#button-variants) · [Dialog](#dialog) · [Forms](#formulários) · [Select](#select-vs-native) · [cn](#cn-utility) · [Checklist](#checklist)

## Filosofia

- **Radix** — comportamento acessível (focus trap, teclado, ARIA)
- **shadcn** — componentes que você possui; Tailwind + `cn()`
- **Anatomia** — partes nomeadas: Trigger, Content, Header, Footer

Detectar: pasta `components/ui/`, imports `@radix-ui/*`, util `cn()`.

## Button variants

```tsx
import { cva } from "class-variance-authority";
import { cn } from "@/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline: "border border-input bg-background hover:bg-accent",
        secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/80",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 px-3",
        lg: "h-11 px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: { variant: "default", size: "default" },
  }
);

export function Button({ className, variant, size, ...props }) {
  return <button className={cn(buttonVariants({ variant, size }), className)} {...props} />;
}
```

Mapeamento hierárquico: `default` = primary, `outline`/`secondary` = secundário, `ghost` = terciário.

## Dialog

```tsx
<Dialog>
  <DialogTrigger asChild>
    <Button variant="outline">Abrir</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Título</DialogTitle>
      <DialogDescription>Texto de apoio para leitores de tela.</DialogDescription>
    </DialogHeader>
    {/* corpo */}
    <DialogFooter>
      <Button variant="outline">Cancelar</Button>
      <Button>Confirmar</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

Garantias Radix: focus trap, `Esc`, restore focus, `aria-modal`, Title obrigatório.

Estilo shadcn típico:
- Overlay: `fixed inset-0 bg-black/80`
- Content: `max-w-lg rounded-lg border shadow-lg`
- Animação: `data-[state=open]:animate-in`

## Formulários

```tsx
<div className="space-y-2">
  <Label htmlFor="email">E-mail</Label>
  <Input
    id="email"
    type="email"
    aria-describedby={error ? "email-error" : undefined}
    aria-invalid={!!error}
  />
  {error && <p id="email-error" className="text-sm text-destructive" role="alert">{error}</p>}
</div>
```

Com react-hook-form: `FormField` + `FormMessage` para ligação automática de erros.

## Select vs native

| Radix Select | `<select>` nativo |
|--------------|-------------------|
| Estilo custom, ícones | Listas simples, mobile perf |
| Poucas opções | Listas muito longas (100+) |
| Consistência visual | Máxima a11y com pouco JS |

Mobile-heavy: considerar native ou Combobox (Popover + cmdk).

## Primitivos — mapa rápido

| shadcn | Radix | Partes |
|--------|-------|--------|
| Dialog | react-dialog | Trigger, Content, Title, Description |
| DropdownMenu | react-dropdown-menu | Trigger, Content, Item |
| Select | react-select | Trigger, Content, Item |
| Tabs | react-tabs | List, Trigger, Content |
| Popover | react-popover | Trigger, Content |
| Tooltip | react-tooltip | Provider, Trigger, Content |

## Toast

- `sonner` ou shadcn Toast com `aria-live="polite"`
- Erros destrutivos: confirmar em Dialog, não só toast
- Limitar toasts simultâneos

## cn utility

```ts
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
```

Sempre merge consumer por último: `cn(buttonVariants({ variant }), className)`.

## Tabs — preservar estado

```tsx
<TabsContent value="account" forceMount className="data-[state=inactive]:hidden">
```

Não destruir tab com formulário preenchido ao trocar aba.

## Checklist

- [ ] `asChild` em triggers (evita button aninhado)
- [ ] `DialogTitle` sempre presente
- [ ] `focus-visible:ring-ring` nos interativos
- [ ] `prefers-reduced-motion` nas animações
- [ ] Botões ícone com `sr-only` ou `aria-label`
- [ ] Cores via `bg-primary`, não hex cru

## Correções comuns

| Issue | Fix |
|-------|-----|
| Double focus ring | Remover outline no child com `asChild` |
| Modal scroll bleed | Radix gerencia overflow no body |
| Focus invisível | Restaurar `focus-visible:ring-*` |
| Select width | `w-full` trigger; `min-w-[var(--radix-select-trigger-width)]` content |
