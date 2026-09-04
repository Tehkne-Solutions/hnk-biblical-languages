# HNK Biblical Languages — Product Blueprint

Status: FOUNDATION ACTIVE / LESSONS 001–006 IMPLEMENTED

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

Os seis modos são gerados por `content/drill_factory.dart`.

## Runtime e registry

`BiblicalLessonScreen` é o motor reutilizável.
`content/course_registry.dart` é a fonte única das Lessons implementadas e elimina contador/switch manual do catálogo.

O runtime suporta:

- Hebraico RTL;
- Português, Esperanto e transliteração on/off;
- Scripture cards;
- CODEX por token;
- 12 comparative patterns;
- 72 drills com posição persistente;
- Final Quest;
- conclusão e desbloqueio da Lesson seguinte.

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

## Conteúdo atual

### 001 — Portal da Linguagem
Gênesis 1:1 + João 1:1.

### 002 — Identidade
Êxodo 3:14 + João 1:6.

### 003 — Ser e Existir
Gênesis 1:3 + João 1:3a–b.

### 004 — Casa e Família
Gênesis 12:1 + Lucas 1:27.

### 005 — Tempo e Dias
Gênesis 1:5 + Marcos 1:15.

Eixos: `יוֹם אֶחָד`, sequência com `וַיְהִי`, `καιρός`, perfeitos `πεπλήρωται` / `ἤγγικεν`, imperativos de resposta.

### 006 — Corpo e Ações
Deuteronômio 6:5 + Marcos 12:30.

Eixos:

- `וְאָהַבְתָּ`: Qal perfeito 2ms em discurso de mandamento;
- `ἀγαπήσεις`: futuro ativo indicativo 2sg com função de comando na citação;
- `לֵבָב`, `נֶפֶשׁ`, `מְאֹד` preservados em seus campos próprios;
- `καρδία`, `ψυχή`, `διάνοια`, `ἰσχύς` preservados como quatro domínios explícitos de Marcos;
- `מְאֹדֶךָ` não reduzido morfologicamente ao substantivo português “força”;
- nenhuma quarta categoria hebraica é inventada para fazer a lista coincidir com Marcos.

## Progressão

001 é aberta. Cada Lesson 002–006 exige conclusão da imediatamente anterior. Níveis 7–12 permanecem visíveis como produção futura.

## Métrica atual

```text
6 Lessons × 72 drills = 432 drills
```

## Próximo slice

Lesson 007 — Natureza e Criação:

- Gênesis 1 + João 1:3–5;
- terra, céu, água, luz, vida e descrição;
- substantivos concretos e relações de criação;
- 12 estruturas;
- 72 drills;
- Final Quest;
- desbloqueio após Lesson 006.
