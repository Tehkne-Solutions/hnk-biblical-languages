# HNK Biblical Languages — Product Blueprint

Status: FOUNDATION ACTIVE / LESSONS 001–010 IMPLEMENTED

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

`BiblicalLessonScreen` é o runtime reutilizável; `course_registry.dart` é a fonte única das Lessons implementadas. Progressão e testes de unlock são derivados do registry.

## Implementado

001 Gênesis 1:1 + João 1:1
002 Êxodo 3:14 + João 1:6
003 Gênesis 1:3 + João 1:3a–b
004 Gênesis 12:1 + Lucas 1:27
005 Gênesis 1:5 + Marcos 1:15
006 Deuteronômio 6:5 + Marcos 12:30
007 Gênesis 1:11–12 + João 1:3–5
008 1 Samuel 8:5 + Mateus 2:1
009 Salmo 1:1 + Mateus 5:17
010 Isaías 40:3 + Marcos 1:2–3

### Lesson 010 — Profetas e Evangelhos

- `קוֹרֵא`: particípio Qal masculino singular.
- `פַּנּוּ` e `יַשְּׁרוּ`: imperativos Piel masculinos plurais.
- `γέγραπται`: perfeito passivo indicativo.
- `Ἑτοιμάσατε`: imperativo aoristo ativo 2pl.
- `ποιεῖτε`: imperativo presente ativo 2pl.
- Marcos 1:2–3 é ensinado como bloco de citação composto: correspondência direta com Isaías 40:3 concentra-se no v.3; o v.2 ecoa também Êxodo 23:20/Malaquias 3:1.
- descrição textual precede implicações exegéticas.

## Progressão

001 é aberta; cada Lesson seguinte exige a anterior. Níveis 011–012 permanecem visíveis como produção futura.

## Métrica atual

```text
10 Lessons × 72 drills = 720 drills
```

## Próximo slice

Lesson 011 — Leitura Bíblica Guiada — Gênesis 1–3 + João 1.
