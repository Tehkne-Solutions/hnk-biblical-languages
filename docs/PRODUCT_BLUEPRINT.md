# HNK Biblical Languages — Product Blueprint

Status: FOUNDATION ACTIVE / LESSONS 001–011 IMPLEMENTED

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
12 structures × 6 cognitive variants = 72 drills por Lesson
```

`BiblicalLessonScreen` é o runtime reutilizável; `course_registry.dart` é a fonte única das Lessons implementadas. Progressão e testes de unlock derivam do registry.

## Lesson 011 — Leitura Bíblica Guiada

Âncora curricular: Gênesis 1–3 + João 1, trabalhados por checkpoints selecionados em vez de reprodução integral de capítulos.

Checkpoints:

- Gênesis 1:1 — reutilizado da Lesson 001.
- Gênesis 1:3 — reutilizado da Lesson 003.
- Gênesis 2:7 — novo.
- Gênesis 3:9 — novo.
- João 1:1 — reutilizado da Lesson 001.
- João 1:3–5 — reutilizado da Lesson 007.
- João 1:14 — novo.

Novo metadado `ReadingStage`:

1. ASSISTED — PT + transliteração + CODEX.
2. BRIDGE OFF — sem PT.
3. SOURCE FIRST — sem PT nem transliteração.
4. COLD READ — sem CODEX durante a primeira tentativa.
5. VERIFY — reabrir apoios para corrigir hipóteses.

O nível mantém 12 estruturas × 6 = 72 drills, mas o objetivo deixa de ser frase isolada e passa a ser leitura em cadeia.

## Progressão

001 é aberta; cada Lesson seguinte exige a anterior. Apenas o Nível 012 permanece como produção futura.

## Métrica atual

```text
11 Lessons × 72 drills = 792 drills
```

## Próximo slice

Lesson 012 — Exegese Linguística Integrada.
