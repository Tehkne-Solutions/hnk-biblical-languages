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

const List<ScripturePassage> lesson006Scriptures = [
  ScripturePassage(
    id: 'deuteronomy_6_5_hebrew',
    reference: 'Deuteronômio 6:5',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text:
        'וְאָהַבְתָּ אֵת יְהוָה אֱלֹהֶיךָ בְּכָל־לְבָבְךָ וּבְכָל־נַפְשְׁךָ וּבְכָל־מְאֹדֶךָ׃',
    transliteration:
        'Ve’ahavta et YHWH Elohekha bekhol-levavekha uvekhol-nafshekha uvekhol-me’odekha.',
    literalPt:
        'E amarás YHWH, teu Deus, com todo o teu coração, com toda a tua alma e com todo o teu muito/força.',
    naturalPt:
        'Amarás o SENHOR, teu Deus, de todo o teu coração, de toda a tua alma e de toda a tua força.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'וְאָהַבְתָּ é Qal perfeito 2ms coordenado por וְ, mas dentro deste discurso legal funciona como mandamento/obrigação futura. מְאֹדֶךָ é formalmente baseado em מְאֹד (“muito, intensidade”) com sufixo 2ms; traduções naturais como “força” ou “recursos/muito” interpretam o idiomatismo. A morfologia não deve ser apagada pela tradução.',
    tokens: [
      ScriptureToken(
        surface: 'וְאָהַבְתָּ',
        transliteration: 've’ahavta',
        glossPt: 'e amarás / e deves amar',
        lemma: 'אהב',
        morphology: 'conjunção ו + Qal perfeito, 2ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'אֵת',
        transliteration: 'et',
        glossPt: 'marcador de objeto direto definido',
        lemma: 'אֵת',
        morphology: 'partícula de objeto direto',
      ),
      ScriptureToken(
        surface: 'יְהוָה',
        transliteration: 'YHWH / Adonai na leitura tradicional',
        glossPt: 'YHWH / o SENHOR',
        lemma: 'יהוה',
        morphology: 'nome próprio divino',
      ),
      ScriptureToken(
        surface: 'אֱלֹהֶיךָ',
        transliteration: 'Elohekha',
        glossPt: 'teu Deus',
        lemma: 'אֱלֹהִים',
        morphology: 'substantivo masculino plural em forma ligada + sufixo possessivo 2ms',
      ),
      ScriptureToken(
        surface: 'בְּכָל־',
        transliteration: 'bekhol',
        glossPt: 'com todo / em toda extensão de',
        lemma: 'ב + כֹּל',
        morphology: 'preposição ב + substantivo כֹּל em relação construta',
      ),
      ScriptureToken(
        surface: 'לְבָבְךָ',
        transliteration: 'levavekha',
        glossPt: 'teu coração',
        lemma: 'לֵבָב',
        morphology: 'substantivo masculino singular + sufixo possessivo 2ms',
      ),
      ScriptureToken(
        surface: 'וּבְכָל־',
        transliteration: 'uvekhol',
        glossPt: 'e com todo',
        lemma: 'ו + ב + כֹּל',
        morphology: 'conjunção + preposição ב + substantivo כֹּל em relação construta',
      ),
      ScriptureToken(
        surface: 'נַפְשְׁךָ',
        transliteration: 'nafshekha',
        glossPt: 'tua alma / tua vida / teu ser',
        lemma: 'נֶפֶשׁ',
        morphology: 'substantivo feminino singular + sufixo possessivo 2ms',
      ),
      ScriptureToken(
        surface: 'מְאֹדֶךָ',
        transliteration: 'me’odekha',
        glossPt: 'teu muito / tua força, idiomaticamente',
        lemma: 'מְאֹד',
        morphology: 'advérbio/intensificador מְאֹד + sufixo pronominal 2ms',
      ),
    ],
  ),
  ScripturePassage(
    id: 'mark_12_30_greek',
    reference: 'Marcos 12:30',
    language: BiblicalLanguage.koineGreek,
    text:
        'καὶ ἀγαπήσεις κύριον τὸν θεόν σου ἐξ ὅλης τῆς καρδίας σου καὶ ἐξ ὅλης τῆς ψυχῆς σου καὶ ἐξ ὅλης τῆς διανοίας σου καὶ ἐξ ὅλης τῆς ἰσχύος σου.',
    transliteration:
        'kai agapēseis kyrion ton theon sou ex holēs tēs kardias sou kai ex holēs tēs psychēs sou kai ex holēs tēs dianoias sou kai ex holēs tēs ischyos sou.',
    literalPt:
        'e amarás [o] Senhor, o Deus teu, de toda a tua coração, e de toda a tua alma, e de toda a tua mente, e de toda a tua força.',
    naturalPt:
        'Amarás o Senhor, teu Deus, de todo o teu coração, de toda a tua alma, de todo o teu entendimento e de toda a tua força.',
    sourceEdition: _greekEdition,
    sourceLicense: _greekLicense,
    sourceAttribution: _greekAttribution,
    translationNotePt:
        'ἀγαπήσεις é futuro ativo indicativo 2sg, não imperativo morfológico, mas funciona como comando na citação. Marcos explicita quatro domínios — καρδία, ψυχή, διάνοια e ἰσχύς — enquanto Deuteronômio 6:5 apresenta לֵבָב, נֶפֶשׁ e מְאֹד. O curso não força correspondência antropológica de um-para-um entre as listas.',
    tokens: [
      ScriptureToken(
        surface: 'καὶ',
        transliteration: 'kai',
        glossPt: 'e',
        lemma: 'καί',
        morphology: 'conjunção coordenativa',
      ),
      ScriptureToken(
        surface: 'ἀγαπήσεις',
        transliteration: 'agapēseis',
        glossPt: 'amarás',
        lemma: 'ἀγαπάω',
        morphology: 'futuro ativo do indicativo, 2ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'κύριον',
        transliteration: 'kyrion',
        glossPt: 'Senhor',
        lemma: 'κύριος',
        morphology: 'substantivo/adjetivo masculino, acusativo singular',
      ),
      ScriptureToken(
        surface: 'τὸν θεόν',
        transliteration: 'ton theon',
        glossPt: 'o Deus',
        lemma: 'ὁ + θεός',
        morphology: 'artigo + substantivo masculino, acusativo singular',
      ),
      ScriptureToken(
        surface: 'σου',
        transliteration: 'sou',
        glossPt: 'teu / de ti',
        lemma: 'σύ',
        morphology: 'pronome pessoal, genitivo 2ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'ἐξ ὅλης',
        transliteration: 'ex holēs',
        glossPt: 'de toda / com toda',
        lemma: 'ἐκ + ὅλος',
        morphology: 'preposição ἐκ + adjetivo feminino genitivo singular',
      ),
      ScriptureToken(
        surface: 'τῆς καρδίας',
        transliteration: 'tēs kardias',
        glossPt: 'do coração',
        lemma: 'ὁ + καρδία',
        morphology: 'artigo + substantivo feminino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'τῆς ψυχῆς',
        transliteration: 'tēs psychēs',
        glossPt: 'da alma / vida',
        lemma: 'ὁ + ψυχή',
        morphology: 'artigo + substantivo feminino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'τῆς διανοίας',
        transliteration: 'tēs dianoias',
        glossPt: 'da mente / entendimento',
        lemma: 'ὁ + διάνοια',
        morphology: 'artigo + substantivo feminino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'τῆς ἰσχύος',
        transliteration: 'tēs ischyos',
        glossPt: 'da força / poder',
        lemma: 'ὁ + ἰσχύς',
        morphology: 'artigo + substantivo feminino, genitivo singular',
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

final List<ComparativePattern> lesson006Patterns = [
  ComparativePattern(
    id: 'l006_p01',
    title: '01 · AMAR',
    explanationPt: 'A Lesson começa pelo verbo antes de comparar suas formas discursivas.',
    lines: [_pt('amar'), _eo('ami'), _he('אָהַב', 'ahav'), _gr('ἀγαπάω', 'agapaō')],
  ),
  ComparativePattern(
    id: 'l006_p02',
    title: '02 · AMARÁS',
    explanationPt: 'Duas formas não imperativas podem cumprir função de mandamento no discurso.',
    lines: [_pt('amarás / deves amar'), _eo('vi amos / vi devas ami'), _he('וְאָהַבְתָּ', 've’ahavta', note: 'Qal perfeito 2ms em discurso de mandamento'), _gr('ἀγαπήσεις', 'agapēseis', note: 'futuro ativo indicativo 2sg')],
  ),
  ComparativePattern(
    id: 'l006_p03',
    title: '03 · O SENHOR, TEU DEUS',
    explanationPt: 'Posse e objeto aparecem de maneiras diferentes nas duas línguas bíblicas.',
    lines: [_pt('o SENHOR, teu Deus'), _eo('la Eternulon, vian Dion'), _he('יְהוָה אֱלֹהֶיךָ', 'YHWH Elohekha'), _gr('κύριον τὸν θεόν σου', 'kyrion ton theon sou')],
  ),
  ComparativePattern(
    id: 'l006_p04',
    title: '04 · COM TODO / DE TODA',
    explanationPt: 'בְּכָל e ἐξ ὅλης introduzem os domínios de totalidade sem serem preposições equivalentes palavra por palavra.',
    lines: [_pt('com todo / de toda'), _eo('per via tuta / el la tuta'), _he('בְּכָל־', 'bekhol'), _gr('ἐξ ὅλης', 'ex holēs')],
  ),
  ComparativePattern(
    id: 'l006_p05',
    title: '05 · CORAÇÃO',
    explanationPt: 'לֵבָב e καρδία são importantes termos de interioridade, mas seus campos semânticos não devem ser achatados.',
    lines: [_pt('coração'), _eo('koro'), _he('לֵבָב', 'levav'), _gr('καρδία', 'kardia')],
  ),
  ComparativePattern(
    id: 'l006_p06',
    title: '06 · ALMA / VIDA / SER',
    explanationPt: 'נֶפֶשׁ e ψυχή podem alcançar sentidos como vida e ser pessoal; “alma” não resolve todo o campo semântico.',
    lines: [_pt('alma / vida / ser'), _eo('animo / vivo'), _he('נֶפֶשׁ', 'nefesh'), _gr('ψυχή', 'psychē')],
  ),
  ComparativePattern(
    id: 'l006_p07',
    title: '07 · FORÇA / MUITO',
    explanationPt: 'מְאֹד é formalmente um intensificador; ἰσχύς é substantivo “força”. A tradução pode aproximá-los sem tornar as formas idênticas.',
    lines: [_pt('força / intensidade'), _eo('forto / intenseco'), _he('מְאֹד', 'me’od', note: 'advérbio/intensificador'), _gr('ἰσχύς', 'ischys', note: 'substantivo')],
  ),
  ComparativePattern(
    id: 'l006_p08',
    title: '08 · MENTE / ENTENDIMENTO',
    explanationPt: 'Marcos explicita διάνοια como quarto domínio; Deuteronômio 6:5 não possui um quarto termo correspondente.',
    lines: [_pt('mente / entendimento'), _eo('menso / kompreno'), _he('לֵבָב', 'levav', note: 'ponte funcional: o coração bíblico também pode envolver pensamento; não é termo separado no verso'), _gr('διάνοια', 'dianoia')],
  ),
  ComparativePattern(
    id: 'l006_p09',
    title: '09 · TEU / TUA',
    explanationPt: 'O Hebraico anexa -ךָ aos nomes; o Grego usa σου no genitivo.',
    lines: [_pt('teu / tua'), _eo('via'), _he('־ךָ', '-kha', note: 'sufixo possessivo 2ms'), _gr('σου', 'sou', note: 'genitivo 2sg')],
  ),
  ComparativePattern(
    id: 'l006_p10',
    title: '10 · COM TODO O TEU CORAÇÃO',
    explanationPt: 'Uma unidade completa fixa totalidade + domínio + posse.',
    lines: [_pt('com todo o teu coração'), _eo('per via tuta koro'), _he('בְּכָל־לְבָבְךָ', 'bekhol-levavekha'), _gr('ἐξ ὅλης τῆς καρδίας σου', 'ex holēs tēs kardias sou')],
  ),
  ComparativePattern(
    id: 'l006_p11',
    title: '11 · COM TODA A TUA ALMA',
    explanationPt: 'A mesma moldura gramatical permite comparar outro domínio sem confundir os lexemas.',
    lines: [_pt('com toda a tua alma'), _eo('per via tuta animo'), _he('וּבְכָל־נַפְשְׁךָ', 'uvekhol-nafshekha'), _gr('καὶ ἐξ ὅλης τῆς ψυχῆς σου', 'kai ex holēs tēs psychēs sou')],
  ),
  ComparativePattern(
    id: 'l006_p12',
    title: '12 · AMAR COM TODO O SER',
    explanationPt: 'A síntese final preserva as listas diferentes: três domínios explícitos no Hebraico e quatro no Grego de Marcos.',
    lines: [_pt('amar com todo o coração, alma, mente e força'), _eo('ami per la tuta koro, animo, menso kaj forto'), _he('בְּכָל־לְבָבְךָ · וּבְכָל־נַפְשְׁךָ · וּבְכָל־מְאֹדֶךָ', 'bekhol-levavekha · uvekhol-nafshekha · uvekhol-me’odekha'), _gr('ἐξ ὅλης τῆς καρδίας · ψυχῆς · διανοίας · ἰσχύος', 'ex holēs tēs kardias · psychēs · dianoias · ischyos')],
  ),
];

final BiblicalLesson lesson006CorpoEAcoes = BiblicalLesson(
  id: 'biblical_lesson_006',
  number: 6,
  title: 'AHAV · AGAPĒSEIS · CORPO E AÇÕES',
  subtitle: 'Deuteronômio 6:5 + Marcos 12:30 · amar, totalidade e pessoa',
  objectivePt:
      'Ler o mandamento de amar distinguindo forma verbal e função discursiva, reconhecer coração, alma, mente e força em seus próprios sistemas linguísticos e evitar equivalências antropológicas automáticas entre לֵבָב, נֶפֶשׁ, מְאֹד, καρδία, ψυχή, διάνοια e ἰσχύς.',
  scriptures: lesson006Scriptures,
  patterns: lesson006Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_006',
    patterns: lesson006Patterns,
  ),
  challenge: const LessonChallenge(
    id: 'decode_love_command_forms',
    promptPt:
        'Compare וְאָהַבְתָּ e ἀγαπήσεις. Por que ambos podem ser traduzidos “amarás” embora suas morfologias sejam diferentes?',
    answer:
        'וְאָהַבְתָּ é Qal perfeito 2ms coordenado por וְ em contexto de mandamento; ἀγαπήσεις é futuro ativo indicativo 2sg. A função de obrigação/comando vem do discurso e da construção, não de ambos serem morfologicamente imperativos.',
    hintPt: 'Revise as estruturas 01, 02, 07 e 08.',
  ),
);
