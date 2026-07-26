# Google Play Console — Habilitação Quiz+

Ações **manuais** no [Play Console](https://play.google.com/console). Este arquivo registra o que deve estar configurado quando o épico GATE+STORE estiver em produção.

## Apps

| App | Package | Tipo |
| :--- | :--- | :--- |
| Habilitação Quiz | `br.com.sthaynny.habilitacao_quiz` | Grátis |
| Habilitação Quiz+ | `br.com.sthaynny.habilitacao_quiz.pro` | Pago (compra única) |

Textos de ficha: `google_play/store_listing_*.txt` (Free) e `google_play/store_listing_pro_*.txt` (**+**).

## T17 — Preço do **+**

- [ ] Criar app **Habilitação Quiz+** no console (package `.pro`)
- [ ] Produto: **compra única** (não assinatura no MVP)
- [ ] Faixa sugerida no plano de produto: **R$ 19,90 – R$ 34,90** ([PRODUCT_PLAN](../product/PRODUCT_PLAN.md) §4.3)
- [ ] País principal: Brasil
- [ ] Após publicar, confirmar que o link em `AppStoreConstants.playStoreListingUrl` abre a ficha correta

*Não é possível definir preço via repositório; apenas documentar e validar no console.*

## T19 — Privacidade e Data safety (versão Free)

App **Free** e **Pro** **sem** rede de anúncios (sem AdMob). Atualizar formulários de ambos os apps:

### Política de privacidade

- URL pública apontando para política do desenvolvedor (mesma ou específica por app, conforme jurídico)

### Data safety (Free)

Declarar de forma consistente com o código atual:

| Tipo | Coletado? | Compartilhado? | Notas |
| :--- | :---: | :---: | :--- |
| Dados de desempenho / histórico de quizzes | Sim (local) | Não | `SharedPreferences` — histórico e quota de simulado |
| Identificadores de publicidade | **Não** | **Não** | Sem SDK de ads na versão alvo |
| Dados financeiros | Não (Free) | Não | Compra ocorre no app **+** separado |

### Data safety (Pro)

- Mesma base local; sem ads
- Compra processada pela Google Play (declarar conforme formulário “compras no app” / dados da loja)

### Checklist console

- [ ] Data safety do **Free** revisado — **nenhum** tipo “Advertising” / ads SDK
- [ ] Data safety do **+** revisado
- [ ] Descrição longa do Free pode mencionar o **+** (sem exigir segundo app)

## Ícone **+**

- [ ] Ícone 512×512 do **+** enviado na ficha Pro (`google_play/` — adicionar asset quando disponível; usar ícone distinto do Free na loja)
