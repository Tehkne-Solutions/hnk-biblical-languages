# HNK Biblical Languages

Curso gamificado e comparativo de **Esperanto + Hebraico Bíblico + Grego Koiné**, construído a partir do DNA pedagógico SimpleWay, mas mantido como produto e repositório independentes.

## Cadeia pedagógica

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

Esperanto não é tratado como uma quarta tradução decorativa. Ele funciona como ponte gramatical previsível antes da morfologia e sintaxe mais densas das línguas bíblicas.

## Estado atual

- 12 níveis mapeados.
- Lesson 001 — **Portal da Linguagem** — Gênesis 1:1 + João 1:1.
- Lesson 002 — **Identidade** — Êxodo 3:14 + João 1:6.
- Lesson 003 — **Ser e Existir** — Gênesis 1:3 + João 1:3a–b.
- Lesson 004 — **Casa e Família** — Gênesis 12:1 + Lucas 1:27.
- Lesson 005 — **Tempo e Dias** — Gênesis 1:5 + Marcos 1:15.
- 12 estruturas × 6 modos cognitivos = **72 drills por Lesson**.
- **360 drills** nas cinco Lessons implementadas.
- Hebraico RTL.
- Camadas de Português, Esperanto e transliteração desligáveis.
- CODEX por palavra com lema, gloss, morfologia, edição, licença e atribuição.
- Progresso persistente e desbloqueio sequencial.
- Final Quest por Lesson.
- Flutter CI com analyzer e testes contratuais.

## Executar

```bash
flutter pub get
flutter run
```

## Estrutura

```text
lib/
  main.dart
  biblical_languages/
    content/
    models/
    progress/
    ui/

docs/
  PRODUCT_BLUEPRINT.md
  SOURCES_AND_LICENSES.md

test/
```

## Contrato editorial

Toda análise deve manter separadas as camadas:

```text
texto-fonte
→ transliteração
→ lema / gloss
→ morfologia
→ tradução literal
→ tradução natural
→ nota de tradução
→ interpretação teológica / exegética
```

Uma observação morfológica nunca deve ser apresentada automaticamente como conclusão teológica.

## Próximo nível

Lesson 006 — **Corpo e Ações** — Deuteronômio 6:5 + Marcos 12:30.
