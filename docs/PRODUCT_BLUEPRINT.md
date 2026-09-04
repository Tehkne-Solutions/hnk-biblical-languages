# HNK Biblical Languages — Product Blueprint

Status: **V1 COURSE MAP COMPLETE / LESSONS 001–012 IMPLEMENTED**

## Thesis

```text
Português → Esperanto → Hebraico Bíblico + Grego Koiné → Escrituras → Exegese linguística responsável
```

## Product modes

1. ACADEMY — progressão guiada.
2. DRILL — recuperação ativa.
3. CODEX — lema, gloss, morfologia, proveniência e notas.
4. SCRIPTURE — leitura bíblica guiada.
5. QUEST — desafios de decodificação.

## Contrato numérico

```text
12 níveis
12 estruturas × 6 variantes cognitivas = 72 drills por Lesson
12 Lessons × 72 drills = 864 drills
```

`BiblicalLessonScreen` é o runtime reutilizável; `course_registry.dart` é a fonte única das Lessons implementadas. Progressão e testes de unlock derivam do registry.

## Mapa completo

1. Portal da Linguagem — Gênesis 1:1 + João 1:1.
2. Identidade — Êxodo 3:14 + João 1:6.
3. Ser e Existir — Gênesis 1:3 + João 1:3a–b.
4. Casa e Família — Gênesis 12:1 + Lucas 1:27.
5. Tempo e Dias — Gênesis 1:5 + Marcos 1:15.
6. Corpo e Ações — Deuteronômio 6:5 + Marcos 12:30.
7. Natureza e Criação — Gênesis 1:11–12 + João 1:3–5.
8. Reis, Povos e Lugares — 1 Samuel 8:5 + Mateus 2:1.
9. Sabedoria e Lei — Salmo 1:1 + Mateus 5:17.
10. Profetas e Evangelhos — Isaías 40:3 + Marcos 1:2–3.
11. Leitura Bíblica Guiada — checkpoints de Gênesis 1–3 + João 1.
12. Exegese Linguística Integrada — estudos de caso reutilizados de Torá, Sabedoria e Evangelho.

## Lesson 011 — Leitura Bíblica Guiada

A 011 muda a unidade pedagógica de frase isolada para leitura em cadeia. Ela reutiliza ScripturePassages canônicos já auditados e acrescenta Gênesis 2:7, Gênesis 3:9 e João 1:14.

Plano:

1. ASSISTED — PT + transliteração + CODEX.
2. BRIDGE OFF — sem PT.
3. SOURCE FIRST — sem PT nem transliteração.
4. COLD READ — primeira passagem sem CODEX.
5. VERIFY — reabrir apoios para corrigir hipóteses.

O plano é exibido antes do runtime por `BiblicalLessonPlanScreen`.

## Lesson 012 — Exegese Linguística Integrada

A 012 reutiliza cinco passagens auditadas:

- Gênesis 1:1;
- Êxodo 3:14;
- Salmo 1:1;
- João 1:1;
- Mateus 5:17.

O protocolo final é:

1. SOURCE — estabelecer texto-fonte e delimitar a unidade.
2. MORPHOLOGY — identificar lema e parsing.
3. SYNTAX — estabelecer funções e relações.
4. SEMANTICS — mapear campo semântico contextual.
5. TRANSLATION — distinguir literal, natural e escolhas.
6. INFERENCE — declarar somente o que os dados sustentam.
7. LIMIT — declarar o que a análise linguística não prova sozinha.

As 12 estruturas da Lesson transformam esse protocolo em prática comparativa, e os 72 drills aplicam recuperação ativa ao método, não apenas ao vocabulário.

## Regra editorial central

```text
texto-fonte
→ transliteração
→ lema / gloss
→ morfologia
→ sintaxe
→ semântica
→ tradução literal
→ tradução natural
→ inferência
→ limite interpretativo
```

Nenhuma camada posterior pode ser apresentada como se estivesse automaticamente contida na anterior. Em particular, parsing morfológico ou sintático não constitui, sozinho, uma doutrina completa.

## Progressão

Lesson 001 é aberta. Cada Lesson 002–012 exige conclusão da imediatamente anterior. O catálogo deriva implementação, progresso e desbloqueio diretamente do registry.

## Métrica V1

```text
12 Lessons × 72 drills = 864 drills
```

## Gate V1

O mapa V1 só é considerado selado quando o `main` passa:

- `flutter analyze`;
- suíte completa de testes de conteúdo, proveniência, progressão e UI.
