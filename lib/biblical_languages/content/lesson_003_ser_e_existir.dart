import '../models/biblical_lesson.dart';
import 'drill_factory.dart';

const _hebrewEdition = 'Open Scriptures Hebrew Bible / WLC base text';
const _hebrewLicense = 'WLC text: Public Domain · OSHB morphology: CC BY 4.0';
const _hebrewAttribution = 'Open Scriptures Hebrew Bible Project';
const _greekEdition = 'SBL Greek New Testament (SBLGNT) v1.2';
const _greekLicense =
    'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA';
const _greekAttribution =
    'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.';

const List<ScripturePassage> lesson003Scriptures = [
  ScripturePassage(
    id: 'genesis_1_3_hebrew',
    reference: 'Gênesis 1:3',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text: 'וַיֹּאמֶר אֱלֹהִים יְהִי אוֹר וַיְהִי־אוֹר׃',
    transliteration: 'Vayomer Elohim: yehi or; vayehi-or.',
    literalPt: 'E disse Deus: “Que haja luz”; e houve luz.',
    naturalPt: 'Deus disse: “Haja luz”, e houve luz.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'יְהִי é uma forma jussiva de היה, enquanto וַיְהִי é uma forma narrativa consecutiva do mesmo verbo. O valor de “ser/existir” depende da forma verbal e do contexto.',
    tokens: [
      ScriptureToken(
        surface: 'וַיֹּאמֶר',
        transliteration: 'vayomer',
        glossPt: 'e disse',
        lemma: 'אמר',
        morphology: 'conjunção ו + Qal consecutivo imperfeito, 3ms',
      ),
      ScriptureToken(
        surface: 'אֱלֹהִים',
        transliteration: 'Elohim',
        glossPt: 'Deus',
        lemma: 'אֱלֹהִים',
        morphology: 'substantivo masculino plural; referente singular neste contexto',
      ),
      ScriptureToken(
        surface: 'יְהִי',
        transliteration: 'yehi',
        glossPt: 'haja / que exista',
        lemma: 'היה',
        morphology: 'Qal jussivo, 3ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'אוֹר',
        transliteration: 'or',
        glossPt: 'luz',
        lemma: 'אוֹר',
        morphology: 'substantivo comum singular',
      ),
      ScriptureToken(
        surface: 'וַיְהִי־',
        transliteration: 'vayehi',
        glossPt: 'e houve / e veio a existir',
        lemma: 'היה',
        morphology: 'conjunção ו + Qal consecutivo imperfeito, 3ms',
      ),
    ],
  ),
  ScripturePassage(
    id: 'john_1_3_ab_greek',
    reference: 'João 1:3a–b',
    language: BiblicalLanguage.koineGreek,
    text: 'πάντα δι’ αὐτοῦ ἐγένετο, καὶ χωρὶς αὐτοῦ ἐγένετο οὐδὲ ἕν.',
    transliteration:
        'Panta di’ autou egeneto, kai chōris autou egeneto oude hen.',
    literalPt:
        'Todas as coisas por meio dele vieram a existir, e sem ele não veio a existir nem uma [coisa].',
    naturalPt:
        'Todas as coisas vieram a existir por meio dele; sem ele, nem uma só coisa veio a existir.',
    sourceEdition: _greekEdition,
    sourceLicense: _greekLicense,
    sourceAttribution: _greekAttribution,
    translationNotePt:
        'A Lesson isola João 1:3a–b até οὐδὲ ἕν. Questões editoriais envolvendo ὃ γέγονεν ficam para níveis avançados.',
    tokens: [
      ScriptureToken(
        surface: 'πάντα',
        transliteration: 'panta',
        glossPt: 'todas as coisas / tudo',
        lemma: 'πᾶς',
        morphology: 'adjetivo, nominativo neutro plural',
      ),
      ScriptureToken(
        surface: 'δι’',
        transliteration: 'di’',
        glossPt: 'por meio de',
        lemma: 'διά',
        morphology: 'preposição; aqui rege genitivo',
      ),
      ScriptureToken(
        surface: 'αὐτοῦ',
        transliteration: 'autou',
        glossPt: 'dele',
        lemma: 'αὐτός',
        morphology: 'pronome, genitivo masculino singular',
      ),
      ScriptureToken(
        surface: 'ἐγένετο',
        transliteration: 'egeneto',
        glossPt: 'veio a existir / aconteceu',
        lemma: 'γίνομαι',
        morphology: 'aoristo médio do indicativo, 3ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'χωρὶς',
        transliteration: 'chōris',
        glossPt: 'sem / à parte de',
        lemma: 'χωρίς',
        morphology: 'preposição; aqui rege genitivo',
      ),
      ScriptureToken(
        surface: 'οὐδὲ',
        transliteration: 'oude',
        glossPt: 'nem / nem mesmo',
        lemma: 'οὐδέ',
        morphology: 'conjunção/advérbio negativo',
      ),
      ScriptureToken(
        surface: 'ἕν',
        transliteration: 'hen',
        glossPt: 'um / uma coisa',
        lemma: 'εἷς',
        morphology: 'numeral/adjetivo, nominativo neutro singular',
      ),
    ],
  ),
];

LanguageLine _pt(String text) => LanguageLine(language: BiblicalLanguage.portuguese, label: 'Português', text: text);
LanguageLine _eo(String text) => LanguageLine(language: BiblicalLanguage.esperanto, label: 'Esperanto', text: text);
LanguageLine _he(String text, String tr, {String? note}) => LanguageLine(
      language: BiblicalLanguage.biblicalHebrew,
      label: 'Hebraico Bíblico',
      text: text,
      transliteration: tr,
      direction: ScriptDirection.rtl,
      note: note,
    );
LanguageLine _gr(String text, String tr, {String? note}) => LanguageLine(
      language: BiblicalLanguage.koineGreek,
      label: 'Grego Koiné',
      text: text,
      transliteration: tr,
      note: note,
    );

final List<ComparativePattern> lesson003Patterns = [
  ComparativePattern(
    id: 'l003_p01',
    title: '01 · SER / ESTAR / EXISTIR',
    explanationPt: 'Um gloss não é equivalência absoluta: forma e contexto controlam o sentido.',
    lines: [_pt('ser / estar / existir'), _eo('esti'), _he('היה', 'hayah'), _gr('εἰμί', 'eimi')],
  ),
  ComparativePattern(
    id: 'l003_p02',
    title: '02 · HAJA',
    explanationPt: 'O Hebraico usa jussivo; a linha grega preserva a ponte curta da LXX de Gênesis 1:3.',
    lines: [_pt('haja / que venha a existir'), _eo('estu / ekestu'), _he('יְהִי', 'yehi', note: 'Qal jussivo 3ms'), _gr('γενηθήτω', 'genēthētō', note: 'LXX Gn 1:3')],
  ),
  ComparativePattern(
    id: 'l003_p03',
    title: '03 · HOUVE / VEIO A EXISTIR',
    explanationPt: 'Resultado narrativo hebraico e γίνομαι colocados lado a lado.',
    lines: [_pt('houve / veio a existir'), _eo('ekestis'), _he('וַיְהִי', 'vayehi'), _gr('ἐγένετο', 'egeneto')],
  ),
  ComparativePattern(
    id: 'l003_p04',
    title: '04 · LUZ',
    explanationPt: 'Vocabulário concreto usado para fixar as formas verbais.',
    lines: [_pt('luz'), _eo('lumo'), _he('אוֹר', 'or'), _gr('φῶς', 'phōs')],
  ),
  ComparativePattern(
    id: 'l003_p05',
    title: '05 · TODAS AS COISAS',
    explanationPt: 'João 1:3 amplia a ideia de existência para a totalidade.',
    lines: [_pt('todas as coisas'), _eo('ĉio / ĉiuj aferoj'), _he('כֹּל', 'kol', note: 'ponte lexical'), _gr('πάντα', 'panta')],
  ),
  ComparativePattern(
    id: 'l003_p06',
    title: '06 · POR MEIO DELE',
    explanationPt: 'Relação de mediação expressa por preposição e pronome.',
    lines: [_pt('por meio dele'), _eo('per li'), _he('עַל־יָדוֹ', 'al-yado', note: 'ponte pedagógica'), _gr('δι’ αὐτοῦ', 'di’ autou')],
  ),
  ComparativePattern(
    id: 'l003_p07',
    title: '07 · SEM ELE',
    explanationPt: 'Contraste negativo direto com a cláusula anterior.',
    lines: [_pt('sem ele'), _eo('sen li'), _he('בִּלְעָדָיו', 'biladav'), _gr('χωρὶς αὐτοῦ', 'chōris autou')],
  ),
  ComparativePattern(
    id: 'l003_p08',
    title: '08 · NEM UM',
    explanationPt: 'Negação + numeral formam uma unidade semântica forte.',
    lines: [_pt('nem um / nem uma coisa'), _eo('eĉ ne unu'), _he('אַף לֹא אֶחָד', 'af lo echad', note: 'ponte pedagógica'), _gr('οὐδὲ ἕν', 'oude hen')],
  ),
  ComparativePattern(
    id: 'l003_p09',
    title: '09 · E',
    explanationPt: 'A coordenação narrativa reaparece nos dois corpora.',
    lines: [_pt('e'), _eo('kaj'), _he('וְ', 've-/we-'), _gr('καί', 'kai')],
  ),
  ComparativePattern(
    id: 'l003_p10',
    title: '10 · DEUS DISSE',
    explanationPt: 'A existência em Gênesis aparece como parte de uma sequência narrativa.',
    lines: [_pt('Deus disse'), _eo('Dio diris'), _he('וַיֹּאמֶר אֱלֹהִים', 'vayomer Elohim'), _gr('εἶπεν ὁ θεός', 'eipen ho theos')],
  ),
  ComparativePattern(
    id: 'l003_p11',
    title: '11 · SER × TORNAR-SE',
    explanationPt: 'εἰμί e γίνομαι não são intercambiáveis; o curso mantém a distinção entre estado e vir-a-ser.',
    lines: [_pt('ser × tornar-se'), _eo('esti × fariĝi'), _he('היה', 'hayah', note: 'campo depende da forma'), _gr('εἰμί × γίνομαι', 'eimi × ginomai')],
  ),
  ComparativePattern(
    id: 'l003_p12',
    title: '12 · HAJA LUZ',
    explanationPt: 'A frase inteira fecha o ciclo: comando/jussivo → existência realizada.',
    lines: [_pt('Haja luz'), _eo('Estu lumo'), _he('יְהִי אוֹר', 'yehi or'), _gr('γενηθήτω φῶς', 'genēthētō phōs', note: 'LXX Gn 1:3')],
  ),
];

final BiblicalLesson lesson003SerEExistir = BiblicalLesson(
  id: 'biblical_lesson_003',
  number: 3,
  title: 'YEHI · EGENETO · SER E EXISTIR',
  subtitle: 'Gênesis 1:3 + João 1:3 · ser, existir e vir a existir',
  objectivePt:
      'Distinguir estado, existência, jussivo, narrativa e vir-a-ser usando היה, εἰμί e γίνομαι sem reduzir os verbos a equivalências de dicionário.',
  scriptures: lesson003Scriptures,
  patterns: lesson003Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_003',
    patterns: lesson003Patterns,
  ),
  challenge: const LessonChallenge(
    id: 'decode_genesis_1_3',
    promptPt: 'Explique a diferença entre יְהִי אוֹר e וַיְהִי־אוֹר.',
    answer: 'יְהִי אוֹר = “Haja luz”; וַיְהִי־אוֹר = “e houve/veio a existir luz”.',
    hintPt: 'Compare as estruturas 02, 03 e 12.',
  ),
);
