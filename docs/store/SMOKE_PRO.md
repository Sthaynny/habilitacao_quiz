# Smoke test — AAB Free e Pro

Use após `flutter build appbundle` com [BUILD.md](./BUILD.md). Marque cada item ao validar.

## Última validação automática

| Campo | Valor |
| :--- | :--- |
| **Data** | 2026-07-30 |
| **Agente** | `feature-store-publish` (T15 — compilação) |
| **Ambiente** | Windows 10, Flutter (host local) |

### Comandos

```bash
flutter pub get
flutter build apk --flavor free
flutter build apk --flavor pro --dart-define=HABILITACAO_QUIZ_PRO=true
```

### Resultado

| Build | Exit code | Artefato |
| :--- | :---: | :--- |
| Free (`assembleFreeRelease`) | 0 | `build/app/outputs/flutter-apk/app-free-release.apk` (50.7 MB) |
| Pro (`assembleProRelease`) | 0 | `build/app/outputs/flutter-apk/app-pro-release.apk` (53.2 MB) |

**Nota:** validação cobre apenas **compilação** release APK. Checklists manuais abaixo (instalação, quotas, launcher, CTAs) **não** foram executados nesta rodada.

---

**Responsável:** _______________  
**Data:** _______________  
**Versão (versionName):** _______________

## Pré-requisitos

- [ ] `key.properties` configurado para release (ou usar APK debug para smoke rápido)
- [ ] Dois artefatos gerados: flavor `free` e flavor `pro` com `HABILITACAO_QUIZ_PRO=true`

## Instalação

| Build | Comando / origem | Instalado? |
| :--- | :--- | :---: |
| Free | `app-free-release.aab` (bundletool / Play internal) ou `apk --flavor free` | [ ] |
| Pro | `app-pro-release.aab` ou `apk --flavor pro` + dart-define Pro | [ ] |

## Free (`HABILITACAO_QUIZ_PRO=false`)

- [ ] Nome no launcher: **Habilitação Quiz**
- [ ] Application ID: `br.com.sthaynny.habilitacao_quiz`
- [ ] Quiz por tema: no máximo **15** questões por sessão
- [ ] Simulado: **15** questões
- [ ] Segundo simulado no **mesmo dia** bloqueado (mensagem + CTA **+**)
- [ ] Histórico: após **10** resultados, o 11º remove o mais antigo (FIFO) ou aviso de limite
- [ ] Banner / CTA **Habilitação Quiz+** visível na Home (ou fluxo promo)
- [ ] CTA “Ver na loja” abre URL do app **+** na Play (`isProPublished`)

## Pro (`HABILITACAO_QUIZ_PRO=true`)

- [ ] Nome no launcher: **Habilitação Quiz+**
- [ ] Application ID: `br.com.sthaynny.habilitacao_quiz.pro`
- [ ] Quiz por tema: banco completo (sem cap de 15)
- [ ] Simulado: **30** questões
- [ ] Vários simulados no mesmo dia permitidos
- [ ] Salvar **15+** resultados no histórico sem FIFO
- [ ] **Sem** banners promocionais do **+**

## Regressão comum

- [ ] Aviso legal abre e lista fontes oficiais
- [ ] Nenhum crash ao abrir questionário e concluir quiz
- [ ] `flutter analyze` sem erros nos arquivos do lote GATE

## Assinatura

| Papel | Nome | OK |
| :--- | :--- | :---: |
| Dev | | [ ] |
| QA / produto | | [ ] |
