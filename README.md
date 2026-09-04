# HNK Biblical Languages

Curso gamificado e comparativo de **Esperanto + Hebraico Bíblico + Grego Koiné**, construído a partir do DNA pedagógico SimpleWay em repositório independente.

## Cadeia pedagógica

```text
Português → Esperanto → Hebraico Bíblico + Grego Koiné → Escrituras → Exegese linguística responsável
```

## Estado atual

- **12/12 níveis implementados**.
- 12 estruturas × 6 modos cognitivos = **72 drills por Lesson**.
- **864 drills** no mapa completo.
- Lessons 001–010: fundamentos comparativos, morfologia, CODEX, Scripture e Final Quest.
- 011 — **Leitura Bíblica Guiada** — checkpoints selecionados de Gênesis 1–3 + João 1.
- 012 — **Exegese Linguística Integrada** — protocolo SOURCE → MORPHOLOGY → SYNTAX → SEMANTICS → TRANSLATION → INFERENCE → LIMIT.
- Hebraico RTL; PT/Esperanto/transliteração desligáveis.
- CODEX por token com lema, gloss, morfologia, edição, licença, atribuição e notas.
- Registry central; progressão e testes de desbloqueio derivados dinamicamente.
- Lessons 011/012 exibem um plano pedagógico antes de abrir o runtime de estudo.
- ScripturePassages auditados são reutilizados entre Lessons em vez de duplicados.
- Final Quest por Lesson.
- Flutter CI com analyzer e testes contratuais.

## Contrato editorial

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

Morfologia, tradução, inferência e conclusão teológica permanecem camadas separadas.

## Arquitetura principal

```text
lib/
  main.dart
  biblical_languages/
    content/
      course_map.dart
      course_registry.dart
      drill_factory.dart
      lesson_001...lesson_012
    models/
    progress/
    ui/
      biblical_languages_catalog_screen.dart
      biblical_lesson_plan_screen.dart
      biblical_lesson_screen.dart

docs/
  PRODUCT_BLUEPRINT.md
  SOURCES_AND_LICENSES.md

test/
```

## Executar

```bash
flutter pub get
flutter run
```

## Marco atual

O mapa pedagógico V1 está completo em conteúdo e arquitetura. O gate final de publicação continua sendo o CI: analyzer + testes devem permanecer verdes no `main`.
