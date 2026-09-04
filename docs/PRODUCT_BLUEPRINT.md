# HNK Biblical Languages — Product Blueprint

Status: FOUNDATION ACTIVE / LESSONS 001–008 IMPLEMENTED

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

`BiblicalLessonScreen` é o runtime reutilizável; `course_registry.dart` é a fonte única das Lessons implementadas. Os testes de desbloqueio derivam do registry, evitando duplicação conforme o curso cresce.

## Conteúdo implementado

- 001 — Gênesis 1:1 + João 1:1.
- 002 — Êxodo 3:14 + João 1:6.
- 003 — Gênesis 1:3 + João 1:3a–b.
- 004 — Gênesis 12:1 + Lucas 1:27.
- 005 — Gênesis 1:5 + Marcos 1:15.
- 006 — Deuteronômio 6:5 + Marcos 12:30.
- 007 — Gênesis 1:11–12 + João 1:3–5.
- 008 — 1 Samuel 8:5 + Mateus 2:1.

### Lesson 008 — Reis, Povos e Lugares

Eixos:

- `שִׂימָה־לָּנוּ`: imperativo Qal + dativo/pronominal “para nós”;
- `מֶלֶךְ`: título político “rei”;
- `לְשָׁפְטֵנוּ`: infinitivo construto Qal + sufixo 1cp;
- `הַגּוֹיִם`: nações/povos;
- `γεννηθέντος`: particípio aoristo passivo genitivo;
- `τοῦ βασιλέως`: título em genitivo;
- `ἀπὸ ἀνατολῶν`: origem;
- `παρεγένοντο`: chegada em aoristo médio;
- `εἰς Ἱεροσόλυμα`: destino.

## Progressão

001 é aberta. Cada Lesson posterior exige a conclusão da anterior. Níveis 009–012 permanecem visíveis como produção futura.

## Métrica atual

```text
8 Lessons × 72 drills = 576 drills
```

## Próximo slice

Lesson 009 — Sabedoria e Lei — Salmo 1:1 + Mateus 5:17.
