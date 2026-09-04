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

const List<ScripturePassage> lesson005Scriptures = [
  ScripturePassage(
    id: 'genesis_1_5_hebrew',
    reference: 'Gênesis 1:5',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text:
        'וַיִּקְרָא אֱלֹהִים לָאוֹר יוֹם וְלַחֹשֶׁךְ קָרָא לָיְלָה וַיְהִי־עֶרֶב וַיְהִי־בֹקֶר יוֹם אֶחָד׃',
    transliteration:
        'Vayyiqra Elohim la’or yom, velachoshekh qara laylah; vayehi-erev vayehi-voqer, yom echad.',
    literalPt:
        'E Deus chamou à luz “dia”, e à escuridão chamou “noite”; e houve tarde, e houve manhã: dia um.',
    naturalPt:
        'Deus chamou a luz de “dia” e a escuridão de “noite”. Houve tarde e houve manhã: o primeiro dia.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'A camada literal preserva יוֹם אֶחָד como “dia um”. “Primeiro dia” é uma tradução natural possível do valor ordinal no contexto da sequência. O curso mantém essa diferença visível em vez de trocar silenciosamente cardinal por ordinal.',
    tokens: [
      ScriptureToken(
        surface: 'וַיִּקְרָא',
        transliteration: 'vayyiqra',
        glossPt: 'e chamou',
        lemma: 'קרא',
        morphology: 'conjunção ו + Qal wayyiqtol, 3ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'אֱלֹהִים',
        transliteration: 'Elohim',
        glossPt: 'Deus',
        lemma: 'אֱלֹהִים',
        morphology: 'substantivo masculino plural; referente singular neste contexto',
      ),
      ScriptureToken(
        surface: 'לָאוֹר',
        transliteration: 'la’or',
        glossPt: 'à luz',
        lemma: 'ל + ה + אוֹר',
        morphology: 'preposição ל + artigo definido + substantivo comum singular',
      ),
      ScriptureToken(
        surface: 'יוֹם',
        transliteration: 'yom',
        glossPt: 'dia',
        lemma: 'יוֹם',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'וְלַחֹשֶׁךְ',
        transliteration: 'velachoshekh',
        glossPt: 'e à escuridão',
        lemma: 'ו + ל + ה + חֹשֶׁךְ',
        morphology: 'conjunção + preposição ל + artigo + substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'קָרָא',
        transliteration: 'qara',
        glossPt: 'chamou',
        lemma: 'קרא',
        morphology: 'Qal perfeito, 3ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'לָיְלָה',
        transliteration: 'laylah',
        glossPt: 'noite',
        lemma: 'לַיְלָה',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'וַיְהִי־',
        transliteration: 'vayehi',
        glossPt: 'e houve / e veio a ser',
        lemma: 'היה',
        morphology: 'conjunção ו + Qal wayyiqtol, 3ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'עֶרֶב',
        transliteration: 'erev',
        glossPt: 'tarde / entardecer',
        lemma: 'עֶרֶב',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'בֹקֶר',
        transliteration: 'voqer',
        glossPt: 'manhã',
        lemma: 'בֹּקֶר',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'יוֹם אֶחָד',
        transliteration: 'yom echad',
        glossPt: 'dia um / primeiro dia no contexto',
        lemma: 'יוֹם + אֶחָד',
        morphology: 'substantivo masculino singular + numeral masculino singular',
      ),
    ],
  ),
  ScripturePassage(
    id: 'mark_1_15_greek',
    reference: 'Marcos 1:15',
    language: BiblicalLanguage.koineGreek,
    text:
        'καὶ λέγων ὅτι Πεπλήρωται ὁ καιρὸς καὶ ἤγγικεν ἡ βασιλεία τοῦ θεοῦ· μετανοεῖτε καὶ πιστεύετε ἐν τῷ εὐαγγελίῳ.',
    transliteration:
        'kai legōn hoti Peplērōtai ho kairos kai ēngiken hē basileia tou theou; metanoeite kai pisteuete en tō euangeliō.',
    literalPt:
        'e dizendo que: “Cumpriu-se o tempo e aproximou-se o reino de Deus; arrependei-vos e crede no evangelho”.',
    naturalPt:
        'e dizendo: “O tempo se cumpriu, e o reino de Deus está próximo. Arrependam-se e creiam no evangelho”.',
    sourceEdition: _greekEdition,
    sourceLicense: _greekLicense,
    sourceAttribution: _greekAttribution,
    translationNotePt:
        'καιρός pode designar tempo apropriado, ocasião ou período decisivo, não simplesmente duração cronológica. πεπλήρωται é perfeito médio/passivo indicativo 3sg e ἤγγικεν é perfeito ativo indicativo 3sg; o curso destaca o estado resultante dessas formas sem converter aspecto verbal, sozinho, em conclusão teológica.',
    tokens: [
      ScriptureToken(
        surface: 'καὶ',
        transliteration: 'kai',
        glossPt: 'e',
        lemma: 'καί',
        morphology: 'conjunção coordenativa',
      ),
      ScriptureToken(
        surface: 'λέγων',
        transliteration: 'legōn',
        glossPt: 'dizendo',
        lemma: 'λέγω',
        morphology: 'particípio presente ativo, nominativo masculino singular',
      ),
      ScriptureToken(
        surface: 'ὅτι',
        transliteration: 'hoti',
        glossPt: 'que',
        lemma: 'ὅτι',
        morphology: 'conjunção subordinativa',
      ),
      ScriptureToken(
        surface: 'Πεπλήρωται',
        transliteration: 'peplērōtai',
        glossPt: 'cumpriu-se / está cumprido',
        lemma: 'πληρόω',
        morphology: 'perfeito médio/passivo do indicativo, 3ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'ὁ καιρὸς',
        transliteration: 'ho kairos',
        glossPt: 'o tempo / a ocasião apropriada',
        lemma: 'ὁ + καιρός',
        morphology: 'artigo + substantivo masculino, nominativo singular',
      ),
      ScriptureToken(
        surface: 'ἤγγικεν',
        transliteration: 'ēngiken',
        glossPt: 'aproximou-se / chegou perto',
        lemma: 'ἐγγίζω',
        morphology: 'perfeito ativo do indicativo, 3ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'ἡ βασιλεία',
        transliteration: 'hē basileia',
        glossPt: 'o reino / reinado',
        lemma: 'ἡ + βασιλεία',
        morphology: 'artigo + substantivo feminino, nominativo singular',
      ),
      ScriptureToken(
        surface: 'τοῦ θεοῦ',
        transliteration: 'tou theou',
        glossPt: 'de Deus',
        lemma: 'ὁ + θεός',
        morphology: 'artigo + substantivo masculino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'μετανοεῖτε',
        transliteration: 'metanoeite',
        glossPt: 'arrependei-vos / mudem de mente e direção',
        lemma: 'μετανοέω',
        morphology: 'presente ativo do imperativo, 2ª pessoa plural',
      ),
      ScriptureToken(
        surface: 'πιστεύετε',
        transliteration: 'pisteuete',
        glossPt: 'crede / creiam',
        lemma: 'πιστεύω',
        morphology: 'presente ativo do imperativo, 2ª pessoa plural',
      ),
      ScriptureToken(
        surface: 'ἐν τῷ εὐαγγελίῳ',
        transliteration: 'en tō euangeliō',
        glossPt: 'no evangelho / na boa notícia',
        lemma: 'ἐν + ὁ + εὐαγγέλιον',
        morphology: 'preposição + artigo neutro dativo singular + substantivo neutro dativo singular',
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

final List<ComparativePattern> lesson005Patterns = [
  ComparativePattern(
    id: 'l005_p01',
    title: '01 · DIA',
    explanationPt: 'O primeiro marcador concreto da sequência diária.',
    lines: [_pt('dia'), _eo('tago'), _he('יוֹם', 'yom'), _gr('ἡμέρα', 'hēmera', note: 'ponte lexical')],
  ),
  ComparativePattern(
    id: 'l005_p02',
    title: '02 · NOITE',
    explanationPt: 'O par dia/noite prepara a leitura da alternância em Gênesis.',
    lines: [_pt('noite'), _eo('nokto'), _he('לַיְלָה', 'laylah'), _gr('νύξ', 'nyx', note: 'ponte lexical')],
  ),
  ComparativePattern(
    id: 'l005_p03',
    title: '03 · TARDE / ENTARDECER',
    explanationPt: 'עֶרֶב aparece na fórmula temporal recorrente da criação.',
    lines: [_pt('tarde / entardecer'), _eo('vespero'), _he('עֶרֶב', 'erev'), _gr('ἑσπέρα', 'hespera', note: 'ponte lexical')],
  ),
  ComparativePattern(
    id: 'l005_p04',
    title: '04 · MANHÃ',
    explanationPt: 'בֹקֶר completa o par narrativo tarde → manhã.',
    lines: [_pt('manhã'), _eo('mateno'), _he('בֹקֶר', 'voqer'), _gr('πρωί', 'prōi', note: 'ponte lexical')],
  ),
  ComparativePattern(
    id: 'l005_p05',
    title: '05 · DIA UM / PRIMEIRO DIA',
    explanationPt: 'A camada literal preserva o numeral cardinal; a tradução natural pode expressar a posição na série.',
    lines: [_pt('dia um / primeiro dia'), _eo('tago unu / unua tago'), _he('יוֹם אֶחָד', 'yom echad'), _gr('ἡμέρα μία', 'hēmera mia', note: 'ponte pedagógica')],
  ),
  ComparativePattern(
    id: 'l005_p06',
    title: '06 · E HOUVE',
    explanationPt: 'A sequência temporal é narrada por וַיְהִי, já conhecido da Lesson 003.',
    lines: [_pt('e houve'), _eo('kaj estis / ekestis'), _he('וַיְהִי', 'vayehi'), _gr('καὶ ἐγένετο', 'kai egeneto', note: 'ponte narrativa')],
  ),
  ComparativePattern(
    id: 'l005_p07',
    title: '07 · TEMPO / OCASIÃO',
    explanationPt: 'καιρός não é simplesmente “quantidade de tempo”; pode marcar a ocasião apropriada ou decisiva.',
    lines: [_pt('tempo / ocasião apropriada'), _eo('tempo / konvena tempo'), _he('עֵת', 'et', note: 'ponte lexical'), _gr('καιρός', 'kairos')],
  ),
  ComparativePattern(
    id: 'l005_p08',
    title: '08 · O TEMPO SE CUMPRIU',
    explanationPt: 'O perfeito de πληρόω apresenta o cumprimento como estado relevante no presente do anúncio.',
    lines: [_pt('o tempo se cumpriu / está cumprido'), _eo('la tempo plenumiĝis'), _he('מָלְאָה הָעֵת', 'mal’ah ha-et', note: 'ponte pedagógica'), _gr('Πεπλήρωται ὁ καιρὸς', 'Peplērōtai ho kairos')],
  ),
  ComparativePattern(
    id: 'l005_p09',
    title: '09 · APROXIMOU-SE',
    explanationPt: 'ἤγγικεν é perfeito ativo e descreve aproximação com resultado presente.',
    lines: [_pt('aproximou-se / está próximo'), _eo('alproksimiĝis'), _he('קָרַב', 'qarav', note: 'ponte lexical'), _gr('ἤγγικεν', 'ēngiken')],
  ),
  ComparativePattern(
    id: 'l005_p10',
    title: '10 · REINO DE DEUS',
    explanationPt: 'O genitivo τοῦ θεοῦ liga “reino/reinado” a Deus.',
    lines: [_pt('reino de Deus'), _eo('regno de Dio'), _he('מַלְכוּת אֱלֹהִים', 'malkhut Elohim', note: 'ponte lexical'), _gr('ἡ βασιλεία τοῦ θεοῦ', 'hē basileia tou theou')],
  ),
  ComparativePattern(
    id: 'l005_p11',
    title: '11 · ARREPENDEI-VOS',
    explanationPt: 'Marcos 1:15 muda do anúncio temporal para um imperativo dirigido aos ouvintes.',
    lines: [_pt('arrependei-vos / arrependam-se'), _eo('pentu'), _he('שׁוּבוּ', 'shuvu', note: 'ponte bíblica: “voltai/retornai”'), _gr('μετανοεῖτε', 'metanoeite')],
  ),
  ComparativePattern(
    id: 'l005_p12',
    title: '12 · CREDE NO EVANGELHO',
    explanationPt: 'O segundo imperativo fecha a Lesson ligando resposta humana e boa notícia.',
    lines: [_pt('crede no evangelho'), _eo('kredu je la evangelio'), _he('הַאֲמִינוּ בַּבְּשׂוֹרָה', 'ha’aminu babesorah', note: 'ponte lexical/pedagógica'), _gr('πιστεύετε ἐν τῷ εὐαγγελίῳ', 'pisteuete en tō euangeliō')],
  ),
];

final BiblicalLesson lesson005TempoEDias = BiblicalLesson(
  id: 'biblical_lesson_005',
  number: 5,
  title: 'YOM · KAIROS · TEMPO E DIAS',
  subtitle: 'Gênesis 1:5 + Marcos 1:15 · sequência, ocasião e aspecto verbal',
  objectivePt:
      'Distinguir vocabulário de dia e ciclo temporal de expressões de ocasião decisiva, reconhecendo sequência narrativa hebraica, numeral em יוֹם אֶחָד e os perfeitos gregos πεπλήρωται e ἤγγικεν sem reduzir aspecto verbal a interpretação teológica.',
  scriptures: lesson005Scriptures,
  patterns: lesson005Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_005',
    patterns: lesson005Patterns,
  ),
  challenge: const LessonChallenge(
    id: 'decode_time_sequence_and_kairos',
    promptPt:
        'Compare וַיְהִי־עֶרֶב וַיְהִי־בֹקֶר יוֹם אֶחָד com Πεπλήρωται ὁ καιρὸς. O que cada construção faz linguisticamente?',
    answer:
        'Gênesis encadeia uma sequência narrativa concreta: “houve tarde, houve manhã: dia um”. Marcos usa καιρός e um verbo no perfeito para anunciar que uma ocasião/tempo chegou ao seu estado de cumprimento. As construções tratam temporalidade de modos diferentes e não são equivalentes gramaticais.',
    hintPt: 'Revise as estruturas 05, 06, 07 e 08.',
  ),
);
