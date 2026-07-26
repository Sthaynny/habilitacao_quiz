# UTMs — Play Store (Habilitação Quiz+)

Campanhas para medir cliques vindos do app **Free** na ficha do **Habilitação Quiz+** na Google Play.

## URL base

| Campo | Valor |
| :--- | :--- |
| Package Pro | `br.com.sthaynny.habilitacao_quiz.pro` |
| Listing | `https://play.google.com/store/apps/details?id=br.com.sthaynny.habilitacao_quiz.pro` |

Constantes em `lib/core/constants/app_store_constants.dart`.

## Parâmetros UTM (app)

| Parâmetro | Valor | Uso |
| :--- | :--- | :--- |
| `utm_source` | `app_free` | Origem: build Free |
| `utm_medium` | `cta` | Clique em CTA in-app |

URL com UTM (usada em `openHabilitacaoQuizPlusStore(useUtm: true)`):

```
https://play.google.com/store/apps/details?id=br.com.sthaynny.habilitacao_quiz.pro&utm_source=app_free&utm_medium=cta
```

## Superfícies que disparam UTM

- Tela **Habilitação Quiz+** — botão “Ver na Play Store”
- Outros CTAs que abrem a loja diretamente devem usar `useUtm: true` quando forem funil de promoção

## Play Console

Após publicar o **+**, validar em **Estatísticas → Aquisição de usuários** se campanhas/UTM aparecem (pode levar 24–48 h).

## iOS

`AppStoreConstants.appStoreIosUrl` é placeholder até haver App Store Connect ID; UTMs na App Store seguem outro modelo — documentar quando o **+** existir na Apple.
