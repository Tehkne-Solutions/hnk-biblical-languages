# HNK Biblical Languages — Product Blueprint

Status: FOUNDATION ACTIVE / LESSONS 001–007 IMPLEMENTED

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

## Runtime

`BiblicalLessonScreen` é o motor reutilizável. `course_registry.dart` é a fonte única das Lessons implementadas. Lessons extensas podem separar corpora hebraico, grego e patterns em módulos menores e auditáveis.

O runtime suporta RTL, filtros de camadas, CODEX por token, 12 patterns, 72 drills persistentes, Final Quest e desbloqueio sequencial.

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

- 001 — Gênesis 1:1 + João 1:1.
- 002 — Êxodo 3:14 + João 1:6.
- 003 — Gênesis 1:3 + João 1:3a–b.
- 004 — Gênesis 12:1 + Lucas 1:27.
- 005 — Gênesis 1:5 + Marcos 1:15.
- 006 — Deuteronômio 6:5 + Marcos 12:30.
- 007 — Gênesis 1:11–12 + João 1:3–5.

### Lesson 007 — Natureza e Criação

Eixos:

- `תַּדְשֵׁא`: Hifil imperfeito jussivo 3fs;
- `וַתּוֹצֵא`: Hifil consecutivo imperfeito 3fs;
- convocação volitiva → realização narrativa;
- `γέγονεν`: perfeito ativo;
- `φαίνει`: presente ativo;
- `κατέλαβεν`: aoristo ativo;
- `καταλαμβάνω` permanece lexicalmente aberto a valores como apreender/alcançar/dominar;
- a fronteira editorial de `ὃ γέγονεν` não vira conclusão exegética automática.

## Progressão

001 é aberta. Cada Lesson 002–007 exige a conclusão da imediatamente anterior. Níveis 8–12 permanecem visíveis como produção futura.

## Métrica atual

```text
7 Lessons × 72 drills = 504 drills
```

## Próximo slice

Lesson 008 — Reis, Povos e Lugares:

- 1 Samuel 8:5 + Mateus 2:1;
- títulos, nomes próprios, direção, território e relações políticas;
- 12 estruturas;
- 72 drills;
- Final Quest;
- desbloqueio após Lesson 007.
