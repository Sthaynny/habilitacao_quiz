# Nielsen — Padrões de Implementação em Código

Cada heurística com **sinais em código** e snippets aplicáveis.

## 1. Visibilidade do status do sistema

```tsx
// Botão com loading — bloqueia double-submit
<Button disabled={isPending} aria-busy={isPending}>
  {isPending ? <Spinner /> : 'Salvar'}
</Button>
```

```dart
AppButton(isLoading: state.isSaving, onPressed: state.canSave ? cubit.save : null)
```

- Skeleton/`AppLoadingState` enquanto lista carrega
- `aria-live="polite"` em toasts; `assertive` para erros críticos
- Progress em wizards: step indicator no código, não só visual

## 2. Correspondência com o mundo real

- Labels de campo em linguagem do usuário (`Telefone`, não `MSISDN`)
- `Intl` / `DateFormat` para datas localizadas
- Mapear erros de API para mensagens legíveis no client:

```ts
const USER_MESSAGES: Record<string, string> = {
  INVALID_EMAIL: 'Informe um e-mail válido.',
  NETWORK_ERROR: 'Sem conexão. Tente novamente.',
};
```

## 3. Controle e liberdade do usuário

```tsx
<Dialog>
  <DialogContent onEscapeKeyDown={onClose} onPointerDownOutside={onClose}>
    <DialogFooter>
      <Button variant="outline" onClick={onClose}>Cancelar</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

- `Esc` fecha modal (Radix/M3 padrão)
- Ações destrutivas: `AlertDialog` com confirmação explícita
- Rotas com `back` funcional; não prender em fluxo sem saída

## 4. Consistência e padrões

- **Mesma ação = mesmo componente + mesmo label** em todo o app
- Variantes de botão via enum/union type — não estilos ad hoc por tela
- Ícones: trash = excluir em todo lugar; não alternar ícones para mesma ação

```tsx
// Glossary no código — constantes compartilhadas
export const LABELS = {
  save: 'Salvar',
  cancel: 'Cancelar',
  delete: 'Excluir',
} as const;
```

## 5. Prevenção de erros

```html
<input type="email" required pattern="[^@]+@[^@]+\.[^@]+" />
```

```dart
AppEmailField(validator: FormValidators.email)
```

- Validar no `onBlur` / `validator` antes do submit
- `disabled` no submit até formulário válido (`formState.isValid`)
- `type="number"` com `min`/`max`; date pickers em vez de texto livre para datas
- Confirmação em código para delete/pagamento

## 6. Reconhecimento em vez de memorização

- Navegação visível; não esconder ações críticas só em menu de contexto
- Hints persistentes (`aria-describedby`, `helperText`) — não só placeholder
- Prefill de contexto (`defaultValues` do usuário logado)
- Máscaras de input com formato visível

## 7. Flexibilidade e eficiência

- Atalhos de teclado documentados em `tooltip` (`⌘K`)
- `Collapsible` / `Accordion` para opções avançadas
- Lembrar preferências (`localStorage`, `SharedPreferences`): tema, densidade, ordenação

## 8. Design estético e minimalista

```tsx
// Um primário por seção
<section>
  <h2 className="text-xl font-semibold">Dados pessoais</h2>
  <div className="mt-6 flex flex-col gap-4">...</div>
  <div className="mt-8 flex justify-end gap-3">
    <Button variant="outline">Cancelar</Button>
    <Button>Salvar</Button>  {/* único default/solid */}
  </div>
</section>
```

- Colapsar seções secundárias; mover legal para footer
- Remover widgets com peso visual igual — priorizar via `text-*` e `gap`

## 9. Reconhecer, diagnosticar e recuperar erros

```tsx
<Input aria-invalid={!!error} aria-describedby="field-error" />
{error && <p id="field-error" role="alert" className="text-sm text-destructive">{error}</p>}
```

Estrutura da mensagem: **o quê** + **por quê** + **o que fazer**.

- Focar primeiro campo inválido no submit (`focus()` / `Scrollable.ensureVisible`)
- **Não** limpar formulário após erro de rede
- Log técnico no servidor; UI só mensagem legível

## 10. Ajuda e documentação

```tsx
<EmptyState
  title="Nenhum projeto"
  description="Crie seu primeiro projeto para começar."
  action={<Button>Criar projeto</Button>}
/>
```

- Empty states com CTA de primeiro passo
- `HelpCircle` com link contextual — não PDF externo para tarefa simples
- Onboarding dismissível; não bloquear usuário recorrente

## Template de auditoria rápida

Por tela, marcar heurísticas fracas (1–5) e corrigir no código as 3 piores primeiro.
