import '../models/biblical_lesson.dart';
import 'drill_factory.dart';

const _hebrewEdition = 'Open Scriptures Hebrew Bible / WLC base text';
const _hebrewLicense = 'WLC text: Public Domain · OSHB morphology: CC BY 4.0';
const _hebrewAttribution = 'Open Scriptures Hebrew Bible Project';
const _greekEdition = 'SBL Greek New Testament (SBLGNT) v1.2';
const _greekLicense = 'SBLGNT electronic text: freely available under its published EULA · MorphGNT parsing: CC BY-SA';
const _greekAttribution =
    'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.';

const List<ScripturePassage> lesson004Scriptures = [
  ScripturePassage(
    id: 'genesis_12_1_hebrew',
    reference: 'Gênesis 12:1',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text:
        'וַיֹּאמֶר יְהוָה אֶל־אַבְרָם לֶךְ־לְךָ מֵאַרְצְךָ וּמִמּוֹלַדְתְּךָ וּמִבֵּית אָבִיךָ אֶל־הָאָרֶץ אֲשֶׁר אַרְאֶךָּ׃',
    transliteration:
        'Vayomer Adonai el-Avram: lekh-lekha me’artsekha u-mimmoladtekha u-mibbeit avikha el-ha’arets asher ar’ekka.',
    literalPt:
        'E disse YHWH a Abrão: “Vai para ti, de tua terra, de tua parentela/origem e da casa de teu pai, para a terra que eu te mostrarei”.',
    naturalPt:
        'O SENHOR disse a Abrão: “Sai da tua terra, da tua parentela e da casa de teu pai e vai para a terra que eu te mostrarei”.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'מוֹלֶדֶת pode apontar para origem, lugar de nascimento ou círculo de parentesco conforme o contexto. Em וּמִבֵּית אָבִיךָ, בֵּית é a forma construta de בַּיִת, ligada a אָבִיךָ (“teu pai”). A Lesson usa essa relação para introduzir o construto sem tratá-lo como simples equivalente da preposição portuguesa “de”.',
    tokens: [
      ScriptureToken(
        surface: 'וַיֹּאמֶר',
        transliteration: 'vayomer',
        glossPt: 'e disse',
        lemma: 'אמר',
        morphology: 'conjunção ו + Qal wayyiqtol, 3ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'יְהוָה',
        transliteration: 'YHWH / Adonai na leitura tradicional',
        glossPt: 'YHWH / o SENHOR',
        lemma: 'יהוה',
        morphology: 'nome próprio divino',
      ),
      ScriptureToken(
        surface: 'אֶל־אַבְרָם',
        transliteration: 'el-Avram',
        glossPt: 'a / para Abrão',
        lemma: 'אֶל + אַבְרָם',
        morphology: 'preposição + nome próprio',
      ),
      ScriptureToken(
        surface: 'לֶךְ־לְךָ',
        transliteration: 'lekh-lekha',
        glossPt: 'vai / sai; literalmente “vai para ti”',
        lemma: 'הלך + ל',
        morphology: 'Qal imperativo 2ms + preposição ל com sufixo 2ms',
      ),
      ScriptureToken(
        surface: 'מֵאַרְצְךָ',
        transliteration: 'me’artsekha',
        glossPt: 'de tua terra',
        lemma: 'מִן + אֶרֶץ',
        morphology: 'preposição מִן + substantivo feminino singular + sufixo possessivo 2ms',
      ),
      ScriptureToken(
        surface: 'וּמִמּוֹלַדְתְּךָ',
        transliteration: 'u-mimmoladtekha',
        glossPt: 'e de tua parentela / origem',
        lemma: 'ו + מִן + מוֹלֶדֶת',
        morphology: 'conjunção + preposição מִן + substantivo feminino singular + sufixo 2ms',
      ),
      ScriptureToken(
        surface: 'וּמִבֵּית',
        transliteration: 'u-mibbeit',
        glossPt: 'e da casa de',
        lemma: 'ו + מִן + בַּיִת',
        morphology: 'conjunção + preposição מִן + substantivo masculino singular construto',
      ),
      ScriptureToken(
        surface: 'אָבִיךָ',
        transliteration: 'avikha',
        glossPt: 'teu pai',
        lemma: 'אָב',
        morphology: 'substantivo masculino singular + sufixo possessivo 2ms',
      ),
      ScriptureToken(
        surface: 'אֶל־הָאָרֶץ',
        transliteration: 'el-ha’arets',
        glossPt: 'para a terra',
        lemma: 'אֶל + ה + אֶרֶץ',
        morphology: 'preposição + artigo definido + substantivo feminino singular',
      ),
      ScriptureToken(
        surface: 'אֲשֶׁר',
        transliteration: 'asher',
        glossPt: 'que / a qual',
        lemma: 'אֲשֶׁר',
        morphology: 'pronome relativo',
      ),
      ScriptureToken(
        surface: 'אַרְאֶךָּ',
        transliteration: 'ar’ekka',
        glossPt: 'eu te mostrarei',
        lemma: 'ראה',
        morphology: 'Hifil imperfeito 1cs + sufixo objeto 2ms',
      ),
    ],
  ),
  ScripturePassage(
    id: 'luke_1_27_greek',
    reference: 'Lucas 1:27',
    language: BiblicalLanguage.koineGreek,
    text:
        'πρὸς παρθένον ἐμνηστευμένην ἀνδρὶ ᾧ ὄνομα Ἰωσὴφ ἐξ οἴκου Δαυίδ, καὶ τὸ ὄνομα τῆς παρθένου Μαριάμ.',
    transliteration:
        'pros parthenon emnēsteumenēn andri hō onoma Iōsēph ex oikou Dauid, kai to onoma tēs parthenou Mariam.',
    literalPt:
        'a uma virgem, tendo sido desposada a um homem cujo nome [era] José, da casa de Davi; e o nome da virgem [era] Maria.',
    naturalPt:
        'a uma virgem prometida em casamento a um homem chamado José, da casa de Davi; o nome da virgem era Maria.',
    sourceEdition: _greekEdition,
    sourceLicense: _greekLicense,
    sourceAttribution: _greekAttribution,
    translationNotePt:
        'ἐμνηστευμένην é particípio perfeito passivo e concorda com παρθένον. ἀνδρί está no dativo, marcando o homem a quem ela estava prometida. Em ἐξ οἴκου Δαυίδ e τὸ ὄνομα τῆς παρθένου, o Grego expressa relações nominais por genitivo; isso não é estruturalmente idêntico ao construto hebraico.',
    tokens: [
      ScriptureToken(
        surface: 'πρὸς',
        transliteration: 'pros',
        glossPt: 'a / para',
        lemma: 'πρός',
        morphology: 'preposição; aqui rege acusativo',
      ),
      ScriptureToken(
        surface: 'παρθένον',
        transliteration: 'parthenon',
        glossPt: 'virgem',
        lemma: 'παρθένος',
        morphology: 'substantivo feminino, acusativo singular',
      ),
      ScriptureToken(
        surface: 'ἐμνηστευμένην',
        transliteration: 'emnēsteumenēn',
        glossPt: 'tendo sido desposada / prometida em casamento',
        lemma: 'μνηστεύω',
        morphology: 'particípio perfeito passivo, acusativo feminino singular',
      ),
      ScriptureToken(
        surface: 'ἀνδρὶ',
        transliteration: 'andri',
        glossPt: 'a um homem / a um marido',
        lemma: 'ἀνήρ',
        morphology: 'substantivo masculino, dativo singular',
      ),
      ScriptureToken(
        surface: 'ᾧ',
        transliteration: 'hō',
        glossPt: 'a quem / cujo, nesta construção',
        lemma: 'ὅς',
        morphology: 'pronome relativo, dativo masculino singular',
      ),
      ScriptureToken(
        surface: 'ὄνομα',
        transliteration: 'onoma',
        glossPt: 'nome',
        lemma: 'ὄνομα',
        morphology: 'substantivo neutro, nominativo singular',
      ),
      ScriptureToken(
        surface: 'Ἰωσὴφ',
        transliteration: 'Iōsēph',
        glossPt: 'José',
        lemma: 'Ἰωσήφ',
        morphology: 'nome próprio indeclinável',
      ),
      ScriptureToken(
        surface: 'ἐξ',
        transliteration: 'ex',
        glossPt: 'de / para fora de',
        lemma: 'ἐκ',
        morphology: 'preposição; aqui rege genitivo',
      ),
      ScriptureToken(
        surface: 'οἴκου',
        transliteration: 'oikou',
        glossPt: 'de casa / da casa',
        lemma: 'οἶκος',
        morphology: 'substantivo masculino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'Δαυίδ',
        transliteration: 'Dauid',
        glossPt: 'Davi',
        lemma: 'Δαυίδ',
        morphology: 'nome próprio indeclinável',
      ),
      ScriptureToken(
        surface: 'καὶ',
        transliteration: 'kai',
        glossPt: 'e',
        lemma: 'καί',
        morphology: 'conjunção coordenativa',
      ),
      ScriptureToken(
        surface: 'τὸ ὄνομα',
        transliteration: 'to onoma',
        glossPt: 'o nome',
        lemma: 'ὁ + ὄνομα',
        morphology: 'artigo neutro nominativo singular + substantivo neutro nominativo singular',
      ),
      ScriptureToken(
        surface: 'τῆς παρθένου',
        transliteration: 'tēs parthenou',
        glossPt: 'da virgem',
        lemma: 'ὁ + παρθένος',
        morphology: 'artigo + substantivo feminino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'Μαριάμ',
        transliteration: 'Mariam',
        glossPt: 'Maria',
        lemma: 'Μαριάμ',
        morphology: 'nome próprio indeclinável',
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

final List<ComparativePattern> lesson004Patterns = [
  ComparativePattern(
    id: 'l004_p01',
    title: '01 · CASA',
    explanationPt:
        'O vocabulário-base abre o tema doméstico antes das relações de posse.',
    lines: [_pt('casa'), _eo('domo'), _he('בַּיִת', 'bayit'), _gr('οἶκος', 'oikos')],
  ),
  ComparativePattern(
    id: 'l004_p02',
    title: '02 · DE / RELAÇÃO ENTRE NOMES',
    explanationPt:
        'Hebraico e Grego podem ligar substantivos sem copiar a estrutura portuguesa palavra por palavra.',
    lines: [
      _pt('casa de...'),
      _eo('domo de...'),
      _he('בֵּית ...', 'bet ...', note: 'forma construta de בַּיִת'),
      _gr('οἴκου ...', 'oikou ...', note: 'genitivo singular de οἶκος'),
    ],
  ),
  ComparativePattern(
    id: 'l004_p03',
    title: '03 · DA CASA DE...',
    explanationPt:
        'A preposição “de/desde” se combina com uma relação nominal nos dois textos-base.',
    lines: [
      _pt('da casa de...'),
      _eo('el la domo de...'),
      _he('מִבֵּית ...', 'mibbeit ...'),
      _gr('ἐξ οἴκου ...', 'ex oikou ...'),
    ],
  ),
  ComparativePattern(
    id: 'l004_p04',
    title: '04 · PAI',
    explanationPt:
        'Uma palavra central de parentesco prepara a leitura de אָבִיךָ.',
    lines: [_pt('pai'), _eo('patro'), _he('אָב', 'av'), _gr('πατήρ', 'patēr')],
  ),
  ComparativePattern(
    id: 'l004_p05',
    title: '05 · TEU PAI',
    explanationPt:
        'O Hebraico anexa o possuidor como sufixo; o Grego pode usar formas pronominais ou genitivas conforme a construção.',
    lines: [
      _pt('teu pai'),
      _eo('via patro'),
      _he('אָבִיךָ', 'avikha', note: 'אָב + sufixo possessivo 2ms'),
      _gr('ὁ πατήρ σου', 'ho patēr sou', note: 'ponte pedagógica: pronome no genitivo'),
    ],
  ),
  ComparativePattern(
    id: 'l004_p06',
    title: '06 · PARENTELA / ORIGEM',
    explanationPt:
        'מוֹלֶדֶת tem campo semântico mais amplo que uma única palavra portuguesa.',
    lines: [
      _pt('parentela / origem'),
      _eo('parencaro / deveno'),
      _he('מוֹלֶדֶת', 'moledet'),
      _gr('συγγένεια', 'syngeneia', note: 'ponte lexical'),
    ],
  ),
  ComparativePattern(
    id: 'l004_p07',
    title: '07 · TERRA / PAÍS',
    explanationPt:
        'Gênesis 12:1 usa a mesma raiz nominal com sufixo e depois com artigo definido.',
    lines: [_pt('terra / país'), _eo('lando'), _he('אֶרֶץ', 'erets'), _gr('γῆ', 'gē')],
  ),
  ComparativePattern(
    id: 'l004_p08',
    title: '08 · VAI / SAI',
    explanationPt:
        'לֶךְ־לְךָ é mais rico que um simples infinitivo de dicionário e é aprendido dentro da frase.',
    lines: [
      _pt('vai / sai'),
      _eo('iru / foriru'),
      _he('לֶךְ־לְךָ', 'lekh-lekha', note: 'imperativo 2ms + לְךָ'),
      _gr('πορεύου', 'poreuou', note: 'ponte verbal'),
    ],
  ),
  ComparativePattern(
    id: 'l004_p09',
    title: '09 · VIRGEM',
    explanationPt:
        'Lucas 1:27 apresenta παρθένος em duas formas casuais dentro do mesmo versículo.',
    lines: [_pt('virgem'), _eo('virgulino'), _he('בְּתוּלָה', 'betulah'), _gr('παρθένος', 'parthenos')],
  ),
  ComparativePattern(
    id: 'l004_p10',
    title: '10 · PROMETIDA EM CASAMENTO',
    explanationPt:
        'O Grego usa particípio perfeito passivo para descrever um estado resultante anterior à cena.',
    lines: [
      _pt('prometida em casamento / desposada'),
      _eo('fianĉigita'),
      _he('מְאֹרָשָׂה', 'me’orasah', note: 'ponte lexical bíblica'),
      _gr('ἐμνηστευμένη', 'emnēsteumenē', note: 'perfeito passivo, forma de lema pedagógica'),
    ],
  ),
  ComparativePattern(
    id: 'l004_p11',
    title: '11 · HOMEM / MARIDO',
    explanationPt:
        'ἀνήρ pode significar homem e, em certos contextos relacionais, marido; o contexto decide.',
    lines: [_pt('homem / marido'), _eo('viro / edzo'), _he('אִישׁ', 'ish'), _gr('ἀνήρ', 'anēr')],
  ),
  ComparativePattern(
    id: 'l004_p12',
    title: '12 · O NOME DA VIRGEM',
    explanationPt:
        'A estrutura final consolida relação nominal: uma ponte hebraica pedagógica ao lado do genitivo real de Lucas 1:27.',
    lines: [
      _pt('o nome da virgem'),
      _eo('la nomo de la virgulino'),
      _he('שֵׁם הַבְּתוּלָה', 'shem habetulah', note: 'ponte pedagógica com relação construta'),
      _gr('τὸ ὄνομα τῆς παρθένου', 'to onoma tēs parthenou', note: 'Lucas 1:27'),
    ],
  ),
];

final BiblicalLesson lesson004CasaEFamilia = BiblicalLesson(
  id: 'biblical_lesson_004',
  number: 4,
  title: 'BAYIT · OIKOS · CASA E FAMÍLIA',
  subtitle: 'Gênesis 12:1 + Lucas 1:27 · posse, parentesco, construto e genitivo',
  objectivePt:
      'Reconhecer vocabulário de casa e família e distinguir como o Hebraico Bíblico e o Grego Koiné codificam relações nominais por construto, sufixos, dativo e genitivo, sem reduzir sistemas diferentes à preposição portuguesa “de”.',
  scriptures: lesson004Scriptures,
  patterns: lesson004Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_004',
    patterns: lesson004Patterns,
  ),
  challenge: const LessonChallenge(
    id: 'decode_house_relations',
    promptPt:
        'Compare וּמִבֵּית אָבִיךָ e ἐξ οἴκου Δαυίδ. Como cada língua constrói a ideia “da casa de...”?',
    answer:
        'No Hebraico, בֵּית está em estado construto e se liga a אָבִיךָ (“teu pai”), com o possuidor também marcado por sufixo. No Grego, οἴκου está no genitivo depois de ἐξ, seguido pelo nome Δαυίδ. As duas expressam relação nominal, mas por mecanismos gramaticais diferentes.',
    hintPt: 'Revise as estruturas 02, 03, 05 e 12.',
  ),
);
