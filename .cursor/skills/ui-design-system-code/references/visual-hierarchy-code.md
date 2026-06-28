# Hierarquia Visual — Implementação em Código

Índice: [Tipografia](#tipografia) · [Cor](#cor-como-hierarquia) · [Espaço](#espaço-e-agrupamento) · [Profundidade](#profundidade) · [Diagnóstico](#diagnóstico)

## Tipografia

### Escala Web (Tailwind / CSS)

| Papel | Classes / token | Tamanho |
|-------|-----------------|---------|
| Display | `text-4xl font-bold tracking-tight` | 36–48px |
| H1 página | `text-3xl font-semibold` | 30px |
| H2 seção | `text-xl font-semibold` | 20px |
| H3 card | `text-lg font-medium` | 18px |
| Body | `text-base leading-relaxed` | 16px |
| Caption | `text-sm text-muted-foreground` | 14px |

```html
<h1 class="text-3xl font-semibold tracking-tight text-foreground">Pedidos</h1>
<p class="mt-2 text-base text-muted-foreground">Gerencie pedidos em andamento.</p>
<h2 class="text-xl font-semibold text-foreground">Filtros</h2>
```

### Escala Flutter

```dart
textTheme.headlineSmall   // título de página (24sp+)
textTheme.titleLarge      // seção (20sp)
textTheme.titleMedium     // título de card
textTheme.bodyLarge       // corpo (16sp)
textTheme.bodySmall       // caption (12sp)
```

**Regras em código:**
- Diferença entre níveis ≥ 1.25× — não usar `text-sm` e `text-base` como única distinção hierárquica
- Peso: bold em títulos, medium em labels de botão, regular em corpo
- Máximo 2 pesos diferentes no mesmo componente
- Cor + tamanho juntos — `onSurfaceVariant` para secundário, não só `fontSize` menor

## Cor como hierarquia

| Papel | Web | Flutter |
|-------|-----|---------|
| Primário | `text-foreground` | `scheme.onSurface` |
| Secundário | `text-muted-foreground` | `scheme.onSurfaceVariant` |
| CTA | `bg-primary text-primary-foreground` | `FilledButton` / `primary` |
| Destrutivo | `text-destructive` + ícone | `scheme.error` |

```tsx
// Um accent por view
<Button>Confirmar</Button>           {/* primary */}
<Button variant="outline">Voltar</Button>
<Button variant="ghost">Mais opções</Button>
```

## Espaço e agrupamento

**Proximidade via `gap`:**

```html
<!-- Itens relacionados: gap menor -->
<div class="flex flex-col gap-2">...</div>
<!-- Grupos distintos: gap maior -->
<div class="flex flex-col gap-8">...</div>
```

```dart
Column(
  spacing: 16,  // campos
  children: [
    _sectionA,
    SizedBox(height: 32), // ou seção separada com spacing 32
    _sectionB,
  ],
)
```

| Densidade | Section gap | Padding card |
|-----------|-------------|--------------|
| Comfortable | 32–48px | 24px |
| Standard | 24–32px | 16–24px |
| Compact | 16–24px | 12–16px |

## Profundidade

| Nível | Web | Uso |
|-------|-----|-----|
| 0 | sem shadow, `bg-background` | página |
| 1 | `shadow-sm border` | cards, inputs |
| 2 | `shadow-md` | dropdown, popover |
| 3 | `shadow-lg` | modal |

```dart
Card(elevation: 1)  // preferir border + elevation leve M3
```

## Focal point — checklist no código

Por componente de tela, verificar no diff:

- [ ] Exatamente um `variant="default"` / `FilledButton` primário por seção
- [ ] Título usa estilo `h1`/`headline*`, não `body*`
- [ ] Ações secundárias são `outline`/`ghost`/`TextButton`
- [ ] Mobile: CTA primário acessível (sticky footer ou fim do scroll natural)

## Diagnóstico

| Sintoma no código | Causa provável | Correção |
|-------------------|----------------|----------|
| Tudo `text-sm text-gray-500` | Sem níveis | Introduzir `text-3xl` + `text-base` + `text-muted` |
| 3+ `bg-primary` na mesma view | CTAs competindo | Um solid; demais outline |
| `mb-3`, `mt-5`, `p-[11px]` misturados | Sem grade | `gap-4`, `gap-6`, `p-4`, `p-6` |
| `fontSize: 13` espalhado | Fora do tema | `textTheme.bodyMedium` |
