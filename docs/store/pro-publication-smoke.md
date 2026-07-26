# Publicação Pro — smoke e flag `isProPublished`

Checklist para **ativar** o funil “Ver na Play Store” no app Free (HQ-P13).

## Pré-requisitos

1. App **Habilitação Quiz+** publicado (ou em teste interno com URL pública estável) na Play Console.
2. Package: `br.com.sthaynny.habilitacao_quiz.pro` (ver `AppStoreConstants.androidPackagePro`).

## Flag de compile-time

| Define | Efeito |
| :--- | :--- |
| `HABILITACAO_QUIZ_PRO_PUBLISHED=false` (padrão) | Botão mostra “Em breve”; `openHabilitacaoQuizPlusStore` **não** abre URL — snackbar |
| `HABILITACAO_QUIZ_PRO_PUBLISHED=true` | Abre listing com UTM quando `useUtm: true` |

Exemplo release Free com loja ativa:

```bash
flutter build appbundle \
  --dart-define=HABILITACAO_QUIZ_PRO_PUBLISHED=true
```

Build Pro (sem CTAs internos):

```bash
flutter build appbundle \
  --flavor pro \
  --dart-define=HABILITACAO_QUIZ_PRO=true
```

## Smoke manual (Free)

1. Instalar build Free com `HABILITACAO_QUIZ_PRO_PUBLISHED=true`.
2. Home → banner **+** → tela `/habilitacao-quiz-plus`.
3. “Ver na Play Store” → abre navegador/Play na ficha Pro (URL com `utm_source=app_free`).
4. Repetir com flag `false`: mesmo botão mostra “Em breve”; toque → snackbar, **sem** abrir URL.

## Rollback

Se a ficha Pro sair do ar, voltar builds Free com `HABILITACAO_QUIZ_PRO_PUBLISHED=false` até corrigir a listing.
