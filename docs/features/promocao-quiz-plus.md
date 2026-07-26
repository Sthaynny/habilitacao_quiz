# Promoção do Habilitação Quiz+ no app Free

**Épico:** [PROMO]  
**Onda:** 1  
**Substitui:** `google_mobile_ads` / `AdHelper` / `BannerAd` em `home_screen.dart` e `historico_widget.dart`

## Visão

Os **mesmos espaços** hoje usados por AdMob passam a promover o app pago **Habilitação Quiz+** — sem rede de terceiros, sem distração de marca externa, funil claro para a loja.

## Situação atual vs desejada

| Aspecto | Atual | Desejado |
| :--- | :--- | :--- |
| Home — Quizzes | `BannerAd` no topo da lista (`QuizzesWidget.bottomAd`) | `HabilitacaoQuizPlusCtaBanner` |
| Histórico | AdMob carregado mas **não exibido** no build | CTA no fim da lista / limite |
| Funil Pro | Inexistente | Tela `/habilitacao-quiz-plus` + `AppStoreConstants` |
| Build Pro | — | Zero CTAs (`kIsPro`) |

## Superfícies (prioridade)

| Superfície | P | Comportamento |
| :--- | :---: | :--- |
| Topo aba Quizzes | P0 | Banner compacto + hint benefícios |
| Histórico (lista) | P1 | Rodapé: histórico ilimitado no **+** |
| Resultado pós-simulado Free | P1 | “No **+**, simulado de 30 questões” |
| Limite simulado / histórico | P1 | CTA contextual |
| Tela dedicada **+** | P0 | Benefícios + “Ver na loja” |
| Aviso legal | P2 | Item “Habilitação Quiz+” |

## UX

- Compra **outro app** na loja; sem IAP no MVP.
- `isProPublished == false` → “Em breve” + snackbar (não abrir URL 404).
- Sem countdown falso; fechar sempre visível.
- TalkBack: `Semantics` nos CTAs, alvo ≥ 48dp.

## Implementação

1. `app_edition.dart`, `app_store_constants.dart`, `app_store_launcher.dart`
2. `habilitacao_quiz_plus_cta.dart` (espelhar Cura.li `cura_li_plus_cta.dart`)
3. `HabilitacaoQuizPlusScreen` + rota GetX
4. Trocar slot na Home; limpar AdMob (`main.dart`, `pubspec.yaml`, manifest)
5. Testes widget Free vs Pro

## Critérios de pronto

- [x] Sem referências a `google_mobile_ads`
- [x] Free: CTA visível; Pro: nenhum CTA
- [x] `flutter analyze` + `flutter test` verdes

## Tarefas HQ-P01 … HQ-P13

Lista completa em [A_FAZER.md](../tasks/A_FAZER.md#promo--hq-p).
