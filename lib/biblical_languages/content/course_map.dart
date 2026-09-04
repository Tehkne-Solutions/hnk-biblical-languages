class BiblicalCourseLevel {
  const BiblicalCourseLevel({
    required this.number,
    required this.title,
    required this.focusPt,
    required this.anchor,
    required this.outcomePt,
  });

  final int number;
  final String title;
  final String focusPt;
  final String anchor;
  final String outcomePt;
}

const List<BiblicalCourseLevel> biblicalLanguagesCourseMap = [
  BiblicalCourseLevel(
    number: 1,
    title: 'Portal da Linguagem',
    focusPt: 'Alfabetos, sons, direção de escrita, transliteração e lógica comparativa.',
    anchor: 'Gênesis 1:1 · João 1:1',
    outcomePt: 'Reconhecer as primeiras estruturas e navegar entre Português, Esperanto, Hebraico e Grego.',
  ),
  BiblicalCourseLevel(
    number: 2,
    title: 'Identidade',
    focusPt: 'Pronomes, nomes, apresentação, gênero e frases nominais.',
    anchor: 'Êxodo 3:14 · João 1:6',
    outcomePt: 'Construir e reconhecer enunciados simples de identidade.',
  ),
  BiblicalCourseLevel(
    number: 3,
    title: 'Ser e Existir',
    focusPt: 'Cópula, εἰμί, היה, existência e contraste entre presente e passado.',
    anchor: 'Gênesis 1:3 · João 1:1–3',
    outcomePt: 'Distinguir como cada língua expressa ser, estar, haver e acontecer.',
  ),
  BiblicalCourseLevel(
    number: 4,
    title: 'Casa e Família',
    focusPt: 'Posse, relações, construto hebraico, genitivo grego e vocabulário doméstico.',
    anchor: 'Gênesis 12:1 · Lucas 1:27',
    outcomePt: 'Ler relações de pertencimento e parentesco em frases bíblicas curtas.',
  ),
  BiblicalCourseLevel(
    number: 5,
    title: 'Tempo e Dias',
    focusPt: 'Dias, números, sequência narrativa, aspecto verbal e marcadores temporais.',
    anchor: 'Gênesis 1:5 · Marcos 1:15',
    outcomePt: 'Reconhecer quando e em que sequência uma ação ocorre.',
  ),
  BiblicalCourseLevel(
    number: 6,
    title: 'Corpo e Ações',
    focusPt: 'Verbos frequentes, imperativos, partes do corpo, movimento e ação.',
    anchor: 'Deuteronômio 6:5 · Marcos 12:30',
    outcomePt: 'Interpretar comandos e ações centrais sem depender de tradução palavra por palavra.',
  ),
  BiblicalCourseLevel(
    number: 7,
    title: 'Natureza e Criação',
    focusPt: 'Terra, céu, água, luz, animais, adjetivos e descrição.',
    anchor: 'Gênesis 1 · João 1:3–5',
    outcomePt: 'Ler descrições da criação e expandir o léxico concreto.',
  ),
  BiblicalCourseLevel(
    number: 8,
    title: 'Reis, Povos e Lugares',
    focusPt: 'Títulos, nomes próprios, preposições, direção, território e estruturas políticas.',
    anchor: '1 Samuel 8:5 · Mateus 2:1',
    outcomePt: 'Rastrear pessoas, lugares e relações políticas dentro de uma narrativa.',
  ),
  BiblicalCourseLevel(
    number: 9,
    title: 'Sabedoria e Lei',
    focusPt: 'Paralelismo, instrução, negação, condição e vocabulário ético-jurídico.',
    anchor: 'Salmo 1:1 · Mateus 5:17',
    outcomePt: 'Ler máximas, mandamentos e argumentos curtos com consciência sintática.',
  ),
  BiblicalCourseLevel(
    number: 10,
    title: 'Profetas e Evangelhos',
    focusPt: 'Discurso, citação, partículas, conectores e progressão narrativa.',
    anchor: 'Isaías 40:3 · Marcos 1:2–3',
    outcomePt: 'Comparar fórmulas proféticas e seu reaproveitamento no Novo Testamento.',
  ),
  BiblicalCourseLevel(
    number: 11,
    title: 'Leitura Bíblica Guiada',
    focusPt: 'Leitura contínua com redução gradual de transliteração e tradução.',
    anchor: 'Gênesis 1–3 · João 1',
    outcomePt: 'Ler blocos maiores usando léxico, morfologia e contexto como ferramentas.',
  ),
  BiblicalCourseLevel(
    number: 12,
    title: 'Exegese Linguística Integrada',
    focusPt: 'Sintaxe, semântica, variantes de tradução, discurso e limites interpretativos.',
    anchor: 'Textos integradores do Tanakh e do Novo Testamento',
    outcomePt: 'Produzir análise linguística separando texto, tradução, inferência e interpretação teológica.',
  ),
];
