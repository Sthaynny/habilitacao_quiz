# Apresentação — stakeholders (5 slides)

Use com [PRODUCT_PLAN.md](../product/PRODUCT_PLAN.md) e [features/README.md](../features/README.md) como anexo.

---

## Slide 1 — Contexto e decisão

- App **Habilitação Quiz** em produção (v1.9.x): quizzes + simulado 30q + histórico **10 últimos**.
- Hoje: **AdMob** na Home → vira **promo do Habilitação Quiz+** (sem rede de terceiros).
- Modelo **dois apps** (como Cura.li): mesmo código, IDs `…habilitacao_quiz` e `….pro`.
- Free = degustação; **+** = compra única na loja (R$ 19,90–34,90 sugerido).

---

## Slide 2 — Experiência Free

- 5 matérias; **15 questões/sessão**; simulado **15q, 1×/dia**.
- Histórico: **10 resultados** (já funciona assim).
- Banners = **conhecer o Quiz+**, não propaganda externa.
- Área Aprender (fase 3): resumos e trilha básica.

---

## Slide 3 — Habilitação Quiz+

- Simulado **30 questões**, ilimitado, formato da prova.
- Banco completo por tema; histórico ilimitado + detalhe e gráficos.
- Modo prova, revisão de erros, fichas; **IA** para explicar erros (fase 4).
- Posicionamento: **reta final da CNH**.

---

## Slide 4 — Plano técnico

- `HABILITACAO_QUIZ_PRO` + `ProGate` no domínio.
- **Onda 1:** gate + promo + builds Free/Pro.
- **Onda 2–4:** histórico rico → Aprender → IA.
- Risco lojas: ícone **+**, ficha e benefícios distintos.

---

## Slide 5 — Métricas e próximos passos

- KPIs: D7, % simulado, clique promo → instalação **+**, nota loja.
- Migração: comunicar troca AdMob → promo **+**; dados de histórico preservados.
- **Decisão:** aprovar matriz, preço, data alvo Onda 1.
- Docs: `docs/` (features, tasks, planning).

---

## One-pager para demo

| Pergunta | Resposta curta |
| :--- | :--- |
| Por que dois apps? | Preço claro; Pro sempre desbloqueado; sem IAP complexo |
| Free é inútil? | Estuda de verdade com limites justos |
| Por que tirar AdMob? | Substituir por promo do **+** — mesma área, melhor conversão e UX |
| O que já existe? | Cap 10 histórico; 203 questões; simulado 30q no código atual |
| Próximo commit? | `ProGate` + banner **+** na Home |
