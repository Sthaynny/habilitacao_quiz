# Protocolo de commit — agentes implementadores

Agentes de feature **commitam** o próprio lote após `flutter analyze` limpo nos arquivos alterados.

## Antes do commit

```bash
git status
git diff
flutter pub get
flutter analyze
flutter test <paths relevantes>
```

## Segurança

- Nunca alterar `git config`.
- Nunca `git push --force` em `main`/`master`.
- Nunca `--no-verify` salvo pedido explícito do usuário.
- Não commitar `.env`, `key.properties`, credenciais.
- Evitar `git add .` — adicionar só arquivos do lote.

## Mensagem

- 1–2 frases focadas no **porquê** (português ou inglês, alinhado ao `git log`).
- Um commit por fatia lógica (ex.: “ProGate + testes”, “CTA Quiz+ na home”).
- Usar HEREDOC:

```bash
git add <paths>
git commit -m "$(cat <<'EOF'
Mensagem aqui.

EOF
)"
```

## Após falha de hook

- Corrigir o problema e criar **novo** commit — não `--amend` salvo regras do usuário.

## Backlog

- Mover tarefas concluídas para `docs/tasks/FINALIZADAS.md` quando o lote fechar o critério de pronto.
