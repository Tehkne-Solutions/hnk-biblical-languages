# HNK Biblical Languages — Product Blueprint

Status: **V1 COURSE COMPLETE / PLATFORM PHASE 2 ACTIVE / SMART COACH V1**

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
12 estruturas × 6 variantes cognitivas = 72 drills por Lesson
12 Lessons × 72 drills = 864 drills
```

`BiblicalLessonScreen` é o runtime reutilizável; `course_registry.dart` é a fonte única das Lessons implementadas. Progressão e testes de unlock derivam do registry.

## Mapa completo

1. Portal da Linguagem — Gênesis 1:1 + João 1:1.
2. Identidade — Êxodo 3:14 + João 1:6.
3. Ser e Existir — Gênesis 1:3 + João 1:3a–b.
4. Casa e Família — Gênesis 12:1 + Lucas 1:27.
5. Tempo e Dias — Gênesis 1:5 + Marcos 1:15.
6. Corpo e Ações — Deuteronômio 6:5 + Marcos 12:30.
7. Natureza e Criação — Gênesis 1:11–12 + João 1:3–5.
8. Reis, Povos e Lugares — 1 Samuel 8:5 + Mateus 2:1.
9. Sabedoria e Lei — Salmo 1:1 + Mateus 5:17.
10. Profetas e Evangelhos — Isaías 40:3 + Marcos 1:2–3.
11. Leitura Bíblica Guiada — checkpoints de Gênesis 1–3 + João 1.
12. Exegese Linguística Integrada — estudos de caso reutilizados de Torá, Sabedoria e Evangelho.

## Lesson 011 — Leitura Bíblica Guiada

A 011 muda a unidade pedagógica de frase isolada para leitura em cadeia. Ela reutiliza ScripturePassages canônicos já auditados e acrescenta Gênesis 2:7, Gênesis 3:9 e João 1:14.

Plano:

1. ASSISTED — PT + transliteração + CODEX.
2. BRIDGE OFF — sem PT.
3. SOURCE FIRST — sem PT nem transliteração.
4. COLD READ — primeira passagem sem CODEX.
5. VERIFY — reabrir apoios para corrigir hipóteses.

O plano é exibido antes do runtime por `BiblicalLessonPlanScreen`.

## Lesson 012 — Exegese Linguística Integrada

A 012 reutiliza cinco passagens auditadas:

- Gênesis 1:1;
- Êxodo 3:14;
- Salmo 1:1;
- João 1:1;
- Mateus 5:17.

O protocolo final é:

1. SOURCE — estabelecer texto-fonte e delimitar a unidade.
2. MORPHOLOGY — identificar lema e parsing.
3. SYNTAX — estabelecer funções e relações.
4. SEMANTICS — mapear campo semântico contextual.
5. TRANSLATION — distinguir literal, natural e escolhas.
6. INFERENCE — declarar somente o que os dados sustentam.
7. LIMIT — declarar o que a análise linguística não prova sozinha.

As 12 estruturas da Lesson transformam esse protocolo em prática comparativa, e os 72 drills aplicam recuperação ativa ao método, não apenas ao vocabulário.

## Regra editorial central

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

Nenhuma camada posterior pode ser apresentada como se estivesse automaticamente contida na anterior. Em particular, parsing morfológico ou sintático não constitui, sozinho, uma doutrina completa.

## Progressão

Lesson 001 é aberta. Cada Lesson 002–012 exige conclusão da imediatamente anterior. O catálogo deriva implementação, progresso e desbloqueio diretamente do registry.

## Plataforma — Fase 2

A Fase 2 transforma o curso completo em plataforma de prática recorrente sem duplicar o conteúdo canônico.

```text
864 drills canônicos
→ DRILL Interactive
→ spaced repetition
→ Daily Session 12
→ Player Progression
→ Learning Analytics
→ Mastery Map 12×6
→ Smart Coach
```

### DRILL Interactive

- resposta objetiva derivada das quatro camadas linguísticas do próprio drill;
- resposta correta concede +10 XP e aumenta mastery até 5;
- resposta errada exige retry e agenda revisão imediata;
- revisão antiga não regride o cursor da Lesson;
- intervalos atuais de revisão: 1, 3, 7, 14 e 30 dias.

### Daily Session 12

A ordem canônica é:

```text
1. revisões vencidas
2. conteúdo novo sequencial da Lesson ativa
3. reforço de menor mastery
```

Lessons bloqueadas nunca entram como conteúdo novo. O mesmo `recordDrillResult` alimenta XP, mastery, streak e scheduling.

### Player Progression V1

A camada meta usa ranks de aprendizagem, conquistas, meta diária e histórico de sessões. Ela não cria títulos espirituais nem substitui competência linguística por pontos.

O progresso persiste em schema v3, com migração automática de v1/v2 e histórico limitado às 90 sessões mais recentes.

### Learning Analytics V1

O Analytics deriva dados do mesmo progresso persistido, sem telemetria paralela:

- mastery médio por Hebraico Bíblico, Grego Koiné e Esperanto;
- mastery médio por modo 1–6;
- drills tentados;
- revisões vencidas;
- idioma e modo mais frágeis.

Mapeamento:

```text
1 / 4 → Hebraico Bíblico
2 / 5 → Grego Koiné
3 / 6 → Esperanto
```

A Daily Session usa o idioma mais fraco apenas como desempate dentro do reforço; mastery individual permanece prioritário.

### Mastery Map V1

O mapa visualiza as 12 Lessons × 6 modos cognitivos = 72 células. Cada célula resume 12 drills e mostra cobertura, mastery médio e revisões vencidas. O mapa inteiro permanece derivado dos mesmos 864 drills.

### Smart Coach V1

O Smart Coach converte Analytics + Mastery Map em uma prescrição concreta de prática:

```text
idioma mais frágil
→ modo mais frágil dentro desse idioma
→ até 3 Lessons desbloqueadas com menor mastery nesse modo
→ sessão focada de até 12 itens
```

Regras de segurança pedagógica:

1. revisões vencidas continuam com prioridade absoluta;
2. o foco só usa drills já tentados pelo aluno;
3. somente Lessons desbloqueadas podem fornecer reforço focado;
4. conteúdo inédito continua exclusivamente pela sequência canônica;
5. se o foco não preencher a sessão, a Daily Session canônica completa as vagas;
6. XP, retry, mastery, streak, histórico e spaced repetition continuam no mesmo runtime;
7. sem dados suficientes, o Coach inicia uma sessão de linha de base na Lesson ativa;
8. a recomendação é linguística e pedagógica, nunca uma conclusão espiritual ou teológica.

Fluxo principal:

```text
DRILL
→ PLAYER PROGRESSION
→ LEARNING ANALYTICS
→ SMART COACH
→ SESSÃO FOCADA

LEARNING ANALYTICS
→ MASTERY MAP
```

## Métrica V1

```text
12 Lessons × 72 drills = 864 drills
```

## Gates

O `main` só é considerado saudável quando passa:

- `flutter analyze --no-fatal-infos`;
- contratos linguísticos e de proveniência;
- progressão e unlock 001–012;
- persistência e migração v1/v2 → v3;
- DRILL, XP, streak, mastery e spaced repetition;
- Daily Session: revisão → novo → reforço;
- Player Progression e histórico;
- Learning Analytics por idioma/modo;
- Mastery Map 12×6;
- Smart Coach: baseline, recomendação personalizada, due-first, bloqueio de Lessons futuras e navegação;
- conclusão end-to-end 12/12;
- navegação e dados dos cinco modos da plataforma.
