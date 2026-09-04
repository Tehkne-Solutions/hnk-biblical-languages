# HNK Biblical Languages

Curso/plataforma gamificada e comparativa de **Esperanto + Hebraico Bíblico + Grego Koiné**, construída a partir do DNA pedagógico SimpleWay em repositório independente.

## Cadeia pedagógica

```text
Português → Esperanto → Hebraico Bíblico + Grego Koiné → Escrituras → Exegese linguística responsável
```

## Estado atual

### Curso V1

- **12/12 níveis implementados**.
- 12 estruturas × 6 modos cognitivos = **72 drills por Lesson**.
- **864 drills** no mapa completo.
- Lessons 001–010: fundamentos comparativos, morfologia, CODEX, Scripture e Final Quest.
- 011 — **Leitura Bíblica Guiada** — checkpoints selecionados de Gênesis 1–3 + João 1.
- 012 — **Exegese Linguística Integrada** — protocolo SOURCE → MORPHOLOGY → SYNTAX → SEMANTICS → TRANSLATION → INFERENCE → LIMIT.
- Hebraico RTL; PT/Esperanto/transliteração desligáveis.
- Registry central; progressão e unlock derivados dinamicamente.
- ScripturePassages auditados são reutilizados entre Lessons em vez de duplicados.
- Jornada end-to-end até 12/12 coberta por testes.

### Plataforma — Fase 2 ativa

O app não abre mais diretamente em uma única tela de curso. O entrypoint usa um hub com cinco modos funcionais:

1. **ACADEMY** — mapa completo de 12 níveis, progressão e Lessons.
2. **DRILL** — retoma automaticamente a primeira Lesson pendente e sua posição de 1/72 a 72/72.
3. **CODEX** — índice pesquisável por escrita original, transliteração, lema, gloss, morfologia e referência; detalhe mostra proveniência e licença.
4. **SCRIPTURE** — biblioteca deduplicada das passagens canônicas usadas pelo curso, com texto-fonte, transliteração, tradução pedagógica e atribuição.
5. **QUEST** — os 12 Final Quests, desbloqueados pela mesma progressão canônica do curso.

A biblioteca compartilhada é produzida por `content/biblical_library.dart`, evitando duplicar textos e tokens entre modos.

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
      biblical_library.dart
      lesson_001...lesson_012
    models/
    progress/
    ui/
      biblical_languages_platform_shell.dart
      biblical_languages_catalog_screen.dart
      drill_mode_screen.dart
      codex_mode_screen.dart
      scripture_mode_screen.dart
      quest_mode_screen.dart
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

## Gates

O `main` deve permanecer verde em:

- `flutter analyze --no-fatal-infos`;
- contratos linguísticos/proveniência;
- progressão e persistência;
- navegação Academy → Lesson;
- fluxo avançado Plano → Estudo → Catálogo;
- conclusão end-to-end 12/12;
- navegação e dados dos cinco modos da plataforma.
