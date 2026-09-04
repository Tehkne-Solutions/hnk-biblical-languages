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
2. **DRILL** — prática interativa derivada dos 864 drills canônicos, com resposta objetiva, Daily Session 12, feedback imediato, XP, streak, mastery e revisão espaçada.
3. **CODEX** — índice pesquisável por escrita original, transliteração, lema, gloss, morfologia e referência; detalhe mostra proveniência e licença.
4. **SCRIPTURE** — biblioteca deduplicada das passagens canônicas usadas pelo curso, com texto-fonte, transliteração, tradução pedagógica e atribuição.
5. **QUEST** — os 12 Final Quests, desbloqueados pela mesma progressão canônica do curso.

A biblioteca compartilhada é produzida por `content/biblical_library.dart`, evitando duplicar textos e tokens entre modos.

### DRILL INTERACTIVE V1

O DRILL não é mais apenas navegação para a Lesson. Cada atividade gera uma questão determinística a partir das próprias quatro camadas linguísticas da estrutura canônica.

```text
Drill canônico
→ pista em Português
→ alvo: Esperanto / Hebraico Bíblico / Grego Koiné
→ alternativas derivadas das estruturas da própria Lesson
→ resposta
→ feedback imediato
→ mastery / XP / streak
→ revisão espaçada
```

Regras atuais:

- resposta correta: **+10 XP**;
- mastery por drill: **0–5**;
- resposta errada não avança a posição e entra imediatamente na fila de revisão;
- resposta correta avança para o próximo drill;
- revisar um drill antigo **nunca regride o cursor salvo da Lesson**;
- intervalos de revisão por mastery: **1, 3, 7, 14 e 30 dias**;
- streak é diário e reinicia após um dia sem prática;
- saves antigos em schema v1 migram automaticamente para **schema v2**;
- posição de estudo e mastery permanecem conceitos separados.

### DAILY SESSION 12

A rotina diária monta uma fila de **12 itens** usando o mesmo motor canônico do DRILL.

Prioridade:

```text
1. revisões vencidas, ordenadas por dueAt
2. conteúdo novo da primeira Lesson pendente, a partir do cursor salvo
3. reforço por menor mastery quando ainda houver vagas
```

Regras:

- conteúdo de Lesson ainda bloqueada nunca entra na sessão;
- curso 12/12 concluído usa as vagas como reforço dos itens de menor mastery;
- erro conta como tentativa, agenda revisão e exige retry;
- somente o acerto conclui o item da sessão;
- resumo final mostra **XP ganho, acurácia, itens com mastery aumentado e streak**;
- a composição da sessão mostra quantos itens são revisão, novo conteúdo e reforço;
- a sessão usa `recordDrillResult` e `buildDrillPracticeQuestion`, sem criar um segundo motor de aprendizagem.

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
      drill_practice_factory.dart
      daily_session_factory.dart
      biblical_library.dart
      lesson_001...lesson_012
    models/
    progress/
      biblical_progress.dart
    ui/
      biblical_languages_platform_shell.dart
      biblical_languages_catalog_screen.dart
      drill_mode_screen.dart
      drill_practice_screen.dart
      daily_session_screen.dart
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
- migração de progresso v1 → v2;
- XP, streak, mastery e scheduling de revisão;
- resposta errada → retry → resposta correta no runtime DRILL;
- revisão antiga não regride o cursor da Lesson;
- Daily Session 12: revisão → novo → reforço;
- sessão nunca inclui Lesson bloqueada;
- resumo de sessão com XP e acurácia reais;
- navegação Academy → Lesson;
- fluxo avançado Plano → Estudo → Catálogo;
- conclusão end-to-end 12/12;
- navegação e dados dos cinco modos da plataforma.
