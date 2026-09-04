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
2. **DRILL** — prática interativa derivada dos 864 drills canônicos, com resposta objetiva, Daily Session 12, feedback imediato, XP, streak, mastery, revisão espaçada, Player Progression, Learning Analytics e Mastery Map.
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
- resposta errada mantém exatamente o cursor atual e entra imediatamente na fila de revisão;
- resposta correta só avança o cursor quando o drill respondido está à frente;
- revisar um drill antigo **nunca regride o cursor salvo da Lesson**;
- intervalos de revisão por mastery: **1, 3, 7, 14 e 30 dias**;
- streak é diário e reinicia após um dia sem prática;
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
- a sessão usa `recordDrillResult` e `buildDrillPracticeQuestion`, sem criar um segundo motor de aprendizagem;
- ao concluir, a sessão é registrada no histórico do jogador.

### PLAYER PROGRESSION V1

A progressão do jogador é uma camada meta sobre os cinco modos pedagógicos; ela **não cria títulos espirituais** e não substitui domínio linguístico por pontos.

Ranks atuais por XP:

```text
1 · Aprendiz
2 · Leitor
3 · Decodificador
4 · Escriba
5 · Leitor Avançado
6 · Analista
7 · Exegeta em Formação
```

O dashboard de Player Progression, acessível pelo perfil no DRILL, mostra:

- rank atual, barra até o próximo rank e XP restante;
- meta diária concluída ou pendente;
- XP total e streak;
- sessões concluídas;
- média de acurácia das 7 sessões mais recentes;
- quantidade de drills em mastery ≥1, ≥3 e =5;
- **12 conquistas** baseadas em prática observável, como streak, XP, Lessons, mastery, sessão perfeita e número de sessões;
- histórico das 12 sessões mais recentes na interface.

O progresso persistente usa **schema v3** e mantém migração automática de saves v1 e v2. O histórico persistido é limitado às **90 sessões mais recentes**, evitando crescimento indefinido do armazenamento local.

### LEARNING ANALYTICS V1

O Analytics V1 deriva o perfil de aprendizagem diretamente do progresso canônico já salvo, sem criar um novo schema de telemetria.

Ele calcula:

- mastery médio por **Hebraico Bíblico**, **Grego Koiné** e **Esperanto**;
- mastery médio por **modo cognitivo 1–6**;
- quantidade de drills efetivamente tentados por dimensão;
- revisões vencidas por idioma e modo;
- idioma e modo atualmente mais frágeis;
- foco recomendado visível no dashboard de Analytics.

Mapeamento dos modos para idioma-alvo:

```text
1 / 4 → Hebraico Bíblico
2 / 5 → Grego Koiné
3 / 6 → Esperanto
```

A adaptação da Daily Session é deliberadamente conservadora:

```text
revisões vencidas continuam primeiro
→ conteúdo novo continua sequencial
→ somente o reforço adaptativo usa o perfil de fraqueza
→ mastery individual continua sendo o critério principal
→ idioma mais fraco só desempata drills com mastery equivalente
```

Assim, personalização nunca quebra unlock, ordem pedagógica ou revisão espaçada.

### MASTERY MAP V1

O Mastery Map transforma o mesmo progresso canônico numa visão **12 Lessons × 6 modos cognitivos**, sem novo schema e sem pontuação paralela.

Cada uma das 72 células resume os 12 drills daquela Lesson/modo e mostra:

- drills tentados / 12;
- mastery médio apenas dos itens realmente tentados;
- sinal de revisões vencidas;
- idioma-alvo do modo: **HE / GR / EO**.

Cada linha da Lesson também mostra cobertura da Lesson e mastery agregado. O cabeçalho resume cobertura global sobre os **864 drills**, mastery médio e total de revisões vencidas.

Fluxo de navegação:

```text
DRILL → PLAYER PROGRESSION → LEARNING ANALYTICS → MASTERY MAP
```

O mapa é responsivo: os seis modos aparecem em duas linhas de três células por Lesson, evitando uma tabela horizontal extensa em mobile.

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
      player_progression.dart
      learning_analytics.dart
      mastery_map.dart
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
      player_progress_screen.dart
      learning_analytics_screen.dart
      mastery_map_screen.dart
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
- migração de progresso v1/v2 → v3;
- XP, streak, mastery e scheduling de revisão;
- resposta errada → retry → resposta correta no runtime DRILL;
- revisão antiga não regride o cursor da Lesson;
- Daily Session 12: revisão → novo → reforço;
- sessão nunca inclui Lesson bloqueada;
- resumo de sessão com XP e acurácia reais;
- histórico de sessões e meta diária;
- ranks e conquistas derivados do progresso real;
- dashboard Player Progression;
- Analytics por idioma e modo cognitivo;
- reforço adaptativo preservando mastery e ordem pedagógica;
- navegação Player Progression → Learning Analytics;
- Mastery Map 12×6 com 864 drills canônicos;
- navegação Learning Analytics → Mastery Map;
- navegação Academy → Lesson;
- fluxo avançado Plano → Estudo → Catálogo;
- conclusão end-to-end 12/12;
- navegação e dados dos cinco modos da plataforma.
