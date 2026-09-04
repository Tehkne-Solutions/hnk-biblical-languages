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

const List<ScripturePassage> lesson001Scriptures = [
  ScripturePassage(
    id: 'genesis_1_1_hebrew',
    reference: 'Gênesis 1:1',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text: 'בְּרֵאשִׁית בָּרָא אֱלֹהִים אֵת הַשָּׁמַיִם וְאֵת הָאָרֶץ',
    transliteration: "Bereshit bara Elohim et hashamayim ve'et ha'aretz.",
    literalPt:
        'No princípio criou Deus [marcador de objeto] os céus e [marcador de objeto] a terra.',
    naturalPt: 'No princípio, Deus criou os céus e a terra.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'O curso usa “No princípio” como tradução-base. A relação sintática completa de בְּרֵאשִׁית com a oração é tratada separadamente da morfologia básica.',
    tokens: [
      ScriptureToken(
        surface: 'בְּרֵאשִׁית',
        transliteration: 'bereshit',
        glossPt: 'no princípio / no começo',
        lemma: 'רֵאשִׁית',
        morphology: 'preposição בְּ + substantivo feminino singular',
      ),
      ScriptureToken(
        surface: 'בָּרָא',
        transliteration: 'bara',
        glossPt: 'criou',
        lemma: 'ברא',
        morphology: 'Qal perfeito, 3ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'אֱלֹהִים',
        transliteration: 'Elohim',
        glossPt: 'Deus',
        lemma: 'אֱלֹהִים',
        morphology: 'substantivo masculino plural; nesta oração o verbo está no singular',
      ),
      ScriptureToken(
        surface: 'אֵת',
        transliteration: 'et',
        glossPt: 'marcador de objeto direto definido',
        lemma: 'אֵת',
        morphology: 'partícula de objeto direto',
      ),
      ScriptureToken(
        surface: 'הַשָּׁמַיִם',
        transliteration: 'hashamayim',
        glossPt: 'os céus',
        lemma: 'שָׁמַיִם',
        morphology: 'artigo definido + substantivo masculino plural',
      ),
      ScriptureToken(
        surface: 'הָאָרֶץ',
        transliteration: "ha'aretz",
        glossPt: 'a terra',
        lemma: 'אֶרֶץ',
        morphology: 'artigo definido + substantivo feminino singular',
      ),
    ],
  ),
  ScripturePassage(
    id: 'john_1_1_greek',
    reference: 'João 1:1',
    language: BiblicalLanguage.koineGreek,
    text:
        'Ἐν ἀρχῇ ἦν ὁ λόγος, καὶ ὁ λόγος ἦν πρὸς τὸν θεόν, καὶ θεὸς ἦν ὁ λόγος.',
    transliteration:
        'En archē ēn ho logos, kai ho logos ēn pros ton theon, kai theos ēn ho logos.',
    literalPt:
        'No princípio era o Logos, e o Logos era para/com Deus, e Deus era o Logos.',
    naturalPt:
        'No princípio era o Verbo, e o Verbo estava com Deus, e o Verbo era Deus.',
    sourceEdition: _greekEdition,
    sourceLicense: _greekLicense,
    sourceAttribution: _greekAttribution,
    translationNotePt:
        'πρὸς com acusativo tem campo semântico mais amplo que “com”; a tradução natural do curso preserva “com Deus”, enquanto o CODEX mantém a informação gramatical.',
    tokens: [
      ScriptureToken(
        surface: 'Ἐν',
        transliteration: 'en',
        glossPt: 'em',
        lemma: 'ἐν',
        morphology: 'preposição que rege dativo',
      ),
      ScriptureToken(
        surface: 'ἀρχῇ',
        transliteration: 'archē',
        glossPt: 'princípio',
        lemma: 'ἀρχή',
        morphology: 'substantivo feminino, dativo singular',
      ),
      ScriptureToken(
        surface: 'ἦν',
        transliteration: 'ēn',
        glossPt: 'era / estava',
        lemma: 'εἰμί',
        morphology: 'imperfeito ativo do indicativo, 3ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'λόγος',
        transliteration: 'logos',
        glossPt: 'palavra / Verbo / Logos',
        lemma: 'λόγος',
        morphology: 'substantivo masculino, nominativo singular',
      ),
      ScriptureToken(
        surface: 'πρὸς',
        transliteration: 'pros',
        glossPt: 'para / em direção a; no contexto, com',
        lemma: 'πρός',
        morphology: 'preposição que aqui rege acusativo',
      ),
      ScriptureToken(
        surface: 'θεόν',
        transliteration: 'theon',
        glossPt: 'Deus',
        lemma: 'θεός',
        morphology: 'substantivo masculino, acusativo singular',
      ),
    ],
  ),
];

LanguageLine _pt(String text) => LanguageLine(
      language: BiblicalLanguage.portuguese,
      label: 'Português',
      text: text,
    );
LanguageLine _eo(String text) => LanguageLine(
      language: BiblicalLanguage.esperanto,
      label: 'Esperanto',
      text: text,
    );
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

final List<ComparativePattern> lesson001Patterns = [
  ComparativePattern(
    id: 'l001_p01',
    title: '01 · NO PRINCÍPIO',
    explanationPt: 'A primeira âncora conecta diretamente Gênesis 1:1 e João 1:1.',
    lines: [_pt('No princípio'), _eo('En la komenco'), _he('בְּרֵאשִׁית', 'bereshit'), _gr('Ἐν ἀρχῇ', 'en archē')],
  ),
  ComparativePattern(
    id: 'l001_p02',
    title: '02 · DEUS',
    explanationPt: 'Reconhecimento lexical central nos quatro sistemas.',
    lines: [_pt('Deus'), _eo('Dio'), _he('אֱלֹהִים', 'Elohim'), _gr('θεός', 'theos')],
  ),
  ComparativePattern(
    id: 'l001_p03',
    title: '03 · CRIOU',
    explanationPt: 'O Esperanto expõe o passado em -is; Hebraico e Grego usam sistemas próprios.',
    lines: [_pt('criou'), _eo('kreis'), _he('בָּרָא', 'bara', note: 'Qal perfeito 3ms'), _gr('ἐποίησεν', 'epoiēsen', note: 'ponte lexical da LXX')],
  ),
  ComparativePattern(
    id: 'l001_p04',
    title: '04 · OS CÉUS',
    explanationPt: 'Artigo e substantivo começam a aparecer dentro de frases reais.',
    lines: [_pt('os céus'), _eo('la ĉielon'), _he('הַשָּׁמַיִם', 'hashamayim'), _gr('τὸν οὐρανόν', 'ton ouranon')],
  ),
  ComparativePattern(
    id: 'l001_p05',
    title: '05 · A TERRA',
    explanationPt: 'O aluno reconhece definitude e substantivos concretos.',
    lines: [_pt('a terra'), _eo('la teron'), _he('הָאָרֶץ', "ha'aretz"), _gr('τὴν γῆν', 'tēn gēn')],
  ),
  ComparativePattern(
    id: 'l001_p06',
    title: '06 · E',
    explanationPt: 'Uma conjunção simples revela diferenças de escrita e ligação.',
    lines: [_pt('e'), _eo('kaj'), _he('וְ', 've-/we-'), _gr('καί', 'kai')],
  ),
  ComparativePattern(
    id: 'l001_p07',
    title: '07 · PALAVRA / LOGOS',
    explanationPt: 'λόγος ancora João 1:1; דָּבָר funciona como ponte lexical hebraica.',
    lines: [_pt('a Palavra / o Verbo'), _eo('la Vorto'), _he('דָּבָר', 'davar'), _gr('ὁ λόγος', 'ho logos')],
  ),
  ComparativePattern(
    id: 'l001_p08',
    title: '08 · ERA / ESTAVA',
    explanationPt: 'Introdução ao contraste entre ser/estar em sistemas diferentes.',
    lines: [_pt('era / estava'), _eo('estis'), _he('הָיָה', 'hayah'), _gr('ἦν', 'ēn')],
  ),
  ComparativePattern(
    id: 'l001_p09',
    title: '09 · COM DEUS',
    explanationPt: 'João 1:1 usa πρὸς τὸν θεόν; o curso separa tradução natural de análise gramatical.',
    lines: [_pt('com Deus'), _eo('kun Dio'), _he('עִם אֱלֹהִים', 'im Elohim'), _gr('πρὸς τὸν θεόν', 'pros ton theon')],
  ),
  ComparativePattern(
    id: 'l001_p10',
    title: '10 · DEUS DISSE',
    explanationPt: 'Estrutura narrativa recorrente e memorável.',
    lines: [_pt('Deus disse'), _eo('Dio diris'), _he('וַיֹּאמֶר אֱלֹהִים', 'vayomer Elohim'), _gr('εἶπεν ὁ θεός', 'eipen ho theos')],
  ),
  ComparativePattern(
    id: 'l001_p11',
    title: '11 · LUZ',
    explanationPt: 'Vocabulário concreto fecha o eixo da criação.',
    lines: [_pt('luz'), _eo('lumo'), _he('אוֹר', 'or'), _gr('φῶς', 'phōs')],
  ),
  ComparativePattern(
    id: 'l001_p12',
    title: '12 · EU SOU / EU ESTOU',
    explanationPt: 'No Hebraico Bíblico, frases nominais no presente podem omitir uma cópula explícita.',
    lines: [_pt('eu sou / eu estou'), _eo('mi estas'), _he('אֲנִי …', 'ani …', note: 'cópula presente pode ficar implícita'), _gr('ἐγώ εἰμι', 'egō eimi')],
  ),
];

final BiblicalLesson lesson001BereshitEnArche = BiblicalLesson(
  id: 'biblical_lesson_001',
  number: 1,
  title: 'BERESHIT · EN ARCHĒ · EN LA KOMENCO',
  subtitle: 'Gênesis 1:1 + João 1:1 · a linguagem começa no princípio',
  objectivePt:
      'Reconhecer 12 estruturas fundamentais, iniciar a leitura RTL do Hebraico, ler uma sentença real do Grego Koiné e usar Esperanto como língua-ponte.',
  scriptures: lesson001Scriptures,
  patterns: lesson001Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_001',
    patterns: lesson001Patterns,
  ),
  challenge: const LessonChallenge(
    id: 'decode_john_1_1',
    promptPt: 'Decifre sem tradução pronta: Ἐν ἀρχῇ ἦν ὁ λόγος',
    answer: 'No princípio era o Logos / o Verbo.',
    hintPt: 'Use as estruturas 01, 07 e 08.',
  ),
);
