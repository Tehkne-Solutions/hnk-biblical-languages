# HNK Biblical Languages — Product Blueprint

Status: FOUNDATION ACTIVE / LESSONS 001–005 IMPLEMENTED

## Thesis

```text
Português
  ↓
Esperanto — língua-ponte regular
  ↓
Hebraico Bíblico + Grego Koiné
  ↓
Leitura das Escrituras
  ↓
Exegese linguística responsável
```

## Product modes

1. ACADEMY — progressão guiada.
2. DRILL — recuperação ativa e prática rápida.
3. CODEX — lema, gloss, morfologia, proveniência e notas.
4. SCRIPTURE — leitura bíblica guiada.
5. QUEST — desafios de decodificação e mastery gates.

## Numerology contract

O mapa possui 12 níveis.

Cada Lesson implementada usa:

```text
12 structures × 6 cognitive variants = 72 drills
```

Os seis modos são gerados por `content/drill_factory.dart` e avançam de leitura assistida para reconstrução ativa.

## 12 níveis

1. Portal da Linguagem.
2. Identidade.
3. Ser e Existir.
4. Casa e Família.
5. Tempo e Dias.
6. Corpo e Ações.
7. Natureza e Criação.
8. Reis, Povos e Lugares.
9. Sabedoria e Lei.
10. Profetas e Evangelhos.
11. Leitura Bíblica Guiada.
12. Exegese Linguística Integrada.

O mapa executável está em `lib/biblical_languages/content/course_map.dart`.

## Runtime

`BiblicalLessonScreen` é o motor reutilizável. Uma nova Lesson deve ser majoritariamente conteúdo canônico, não uma cópia de UI.

O runtime suporta:

- Hebraico RTL;
- Português, Esperanto e transliteração on/off;
- Scripture cards;
- CODEX por token;
- 12 comparative patterns;
- 72 drills com posição persistente;
- Final Quest;
- conclusão e desbloqueio da Lesson seguinte.

## Conteúdo atual

### Lesson 001 — Portal da Linguagem
Gênesis 1:1 + João 1:1.

### Lesson 002 — Identidade
Êxodo 3:14 + João 1:6.

### Lesson 003 — Ser e Existir
Gênesis 1:3 + João 1:3a–b.

### Lesson 004 — Casa e Família
Gênesis 12:1 + Lucas 1:27.

Eixo gramatical:
- construto hebraico;
- sufixo possessivo;
- genitivo grego;
- particípio perfeito passivo + dativo;
- mecanismos de relação nominal tratados como diferentes.

### Lesson 005 — Tempo e Dias
Gênesis 1:5 + Marcos 1:15.

Eixo gramatical:
- dia, noite, tarde e manhã;
- `יוֹם אֶחָד` preservado literalmente como “dia um” antes da tradução natural “primeiro dia”;
- sequência narrativa com `וַיְהִי`;
- `καιρός` como tempo/ocasião apropriada, não mera duração;
- `πεπλήρωται` como perfeito médio/passivo;
- `ἤγγικεν` como perfeito ativo;
- imperativos `μετανοεῖτε` e `πιστεύετε`;
- aspecto verbal separado de inferência teológica.

## Progressão

Lesson 001 é aberta.
Lesson 002 exige conclusão da 001.
Lesson 003 exige conclusão da 002.
Lesson 004 exige conclusão da 003.
Lesson 005 exige conclusão da 004.
Níveis 6–12 permanecem visíveis, mas não são apresentados como conteúdo já implementado.

## Métrica atual

```text
5 Lessons × 72 drills = 360 drills
```

## Próximo slice

Lesson 006 — Corpo e Ações:

- Deuteronômio 6:5 + Marcos 12:30;
- verbos frequentes, comandos e partes do corpo;
- ação, agência e imperativos;
- 12 estruturas;
- 72 drills;
- Final Quest;
- desbloqueio após Lesson 005.
