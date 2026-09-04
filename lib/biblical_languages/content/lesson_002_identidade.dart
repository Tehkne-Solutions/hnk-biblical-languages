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

const List<ScripturePassage> lesson002Scriptures = [
  ScripturePassage(
    id: 'exodus_3_14_hebrew',
    reference: 'Êxodo 3:14',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text:
        'וַיֹּאמֶר אֱלֹהִים אֶל־מֹשֶׁה אֶהְיֶה אֲשֶׁר אֶהְיֶה וַיֹּאמֶר כֹּה תֹאמַר לִבְנֵי יִשְׂרָאֵל אֶהְיֶה שְׁלָחַנִי אֲלֵיכֶם׃',
    transliteration:
        'Vayomer Elohim el-Moshe: Ehyeh asher ehyeh. Vayomer: koh tomar livnei Yisrael, Ehyeh shelachani aleikhem.',
    literalPt:
        'E Deus disse a Moisés: “Serei/estarei o que serei/estarei”. E disse: “Assim dirás aos filhos de Israel: Ehyeh me enviou a vocês”.',
    naturalPt:
        'Deus disse a Moisés: “EU SOU O QUE SOU”. E disse: “Assim dirás aos filhos de Israel: EU SOU me enviou a vocês”.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'אֶהְיֶה é Qal imperfeito 1ª pessoa comum singular de היה. “EU SOU” é mantido apenas na camada natural tradicional; a morfologia, sozinha, não é transformada em conclusão teológica.',
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
        surface: 'מֹשֶׁה',
        transliteration: 'Moshe',
        glossPt: 'Moisés',
        lemma: 'מֹשֶׁה',
        morphology: 'nome próprio masculino singular',
      ),
      ScriptureToken(
        surface: 'אֶהְיֶה',
        transliteration: 'ehyeh',
        glossPt: 'serei / estarei; tradicionalmente “EU SOU”',
        lemma: 'היה',
        morphology: 'Qal imperfeito, 1ª pessoa comum singular',
      ),
      ScriptureToken(
        surface: 'אֲשֶׁר',
        transliteration: 'asher',
        glossPt: 'que / o qual / aquilo que',
        lemma: 'אֲשֶׁר',
        morphology: 'pronome relativo',
      ),
      ScriptureToken(
        surface: 'תֹאמַר',
        transliteration: 'tomar',
        glossPt: 'tu dirás / você dirá',
        lemma: 'אמר',
        morphology: 'Qal imperfeito, 2ª pessoa masculina singular',
      ),
      ScriptureToken(
        surface: 'שְׁלָחַנִי',
        transliteration: 'shelachani',
        glossPt: 'ele me enviou',
        lemma: 'שלח',
        morphology: 'Qal perfeito 3ms + sufixo objeto 1cs',
      ),
    ],
  ),
  ScripturePassage(
    id: 'john_1_6_greek',
    reference: 'João 1:6',
    language: BiblicalLanguage.koineGreek,
    text: 'Ἐγένετο ἄνθρωπος ἀπεσταλμένος παρὰ θεοῦ, ὄνομα αὐτῷ Ἰωάννης·',
    transliteration:
        'Egeneto anthrōpos apestalmenos para theou, onoma autō Iōannēs.',
    literalPt:
        'Veio a existir um homem, tendo sido enviado da parte de Deus; nome a ele: João.',
    naturalPt: 'Houve um homem enviado por Deus; seu nome era João.',
    sourceEdition: _greekEdition,
    sourceLicense: _greekLicense,
    sourceAttribution: _greekAttribution,
    translationNotePt:
        'ὄνομα αὐτῷ Ἰωάννης é uma construção nominal com dativo de posse: literalmente algo como “nome a ele, João”, traduzida naturalmente como “seu nome era João”.',
    tokens: [
      ScriptureToken(
        surface: 'Ἐγένετο',
        transliteration: 'egeneto',
        glossPt: 'veio a existir / aconteceu / houve',
        lemma: 'γίνομαι',
        morphology: 'aoristo médio do indicativo, 3ª pessoa singular',
      ),
      ScriptureToken(
        surface: 'ἄνθρωπος',
        transliteration: 'anthrōpos',
        glossPt: 'homem / pessoa',
        lemma: 'ἄνθρωπος',
        morphology: 'substantivo masculino, nominativo singular',
      ),
      ScriptureToken(
        surface: 'ἀπεσταλμένος',
        transliteration: 'apestalmenos',
        glossPt: 'tendo sido enviado / enviado',
        lemma: 'ἀποστέλλω',
        morphology: 'particípio perfeito médio/passivo, nominativo masculino singular',
      ),
      ScriptureToken(
        surface: 'θεοῦ',
        transliteration: 'theou',
        glossPt: 'de Deus',
        lemma: 'θεός',
        morphology: 'substantivo masculino, genitivo singular',
      ),
      ScriptureToken(
        surface: 'ὄνομα',
        transliteration: 'onoma',
        glossPt: 'nome',
        lemma: 'ὄνομα',
        morphology: 'substantivo neutro, nominativo singular',
      ),
      ScriptureToken(
        surface: 'αὐτῷ',
        transliteration: 'autō',
        glossPt: 'a ele / dele neste uso possessivo',
        lemma: 'αὐτός',
        morphology: 'pronome, dativo masculino singular',
      ),
      ScriptureToken(
        surface: 'Ἰωάννης',
        transliteration: 'Iōannēs',
        glossPt: 'João',
        lemma: 'Ἰωάννης',
        morphology: 'nome próprio masculino, nominativo singular',
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

final List<ComparativePattern> lesson002Patterns = [
  ComparativePattern(
    id: 'l002_p01',
    title: '01 · EU SOU / EU SEREI',
    explanationPt: 'אֶהְיֶה é imperfeito; ἐγώ εἰμι é presente. O curso mantém essa diferença visível.',
    lines: [_pt('eu sou / eu serei'), _eo('mi estas / mi estos'), _he('אֶהְיֶה', 'ehyeh', note: 'Qal imperfeito 1cs'), _gr('ἐγώ εἰμι', 'egō eimi')],
  ),
  ComparativePattern(
    id: 'l002_p02',
    title: '02 · QUE / O QUAL',
    explanationPt: 'Pronomes relativos conectam identidade e descrição.',
    lines: [_pt('que / o qual'), _eo('kiu'), _he('אֲשֶׁר', 'asher'), _gr('ὅς', 'hos')],
  ),
  ComparativePattern(
    id: 'l002_p03',
    title: '03 · NOME',
    explanationPt: 'Identidade também é expressa por nome, não apenas por verbo.',
    lines: [_pt('nome'), _eo('nomo'), _he('שֵׁם', 'shem'), _gr('ὄνομα', 'onoma')],
  ),
  ComparativePattern(
    id: 'l002_p04',
    title: '04 · HOMEM / PESSOA',
    explanationPt: 'Vocabulário humano básico em contraste entre sistemas.',
    lines: [_pt('homem / pessoa'), _eo('homo'), _he('אָדָם', 'adam'), _gr('ἄνθρωπος', 'anthrōpos')],
  ),
  ComparativePattern(
    id: 'l002_p05',
    title: '05 · ENVIAR',
    explanationPt: 'O eixo do envio liga Êxodo e João.',
    lines: [_pt('enviar'), _eo('sendi'), _he('שָׁלַח', 'shalach'), _gr('ἀποστέλλω', 'apostellō')],
  ),
  ComparativePattern(
    id: 'l002_p06',
    title: '06 · ELE ME ENVIOU',
    explanationPt: 'O Hebraico incorpora o objeto pronominal na forma verbal.',
    lines: [_pt('ele me enviou'), _eo('li sendis min'), _he('שְׁלָחַנִי', 'shelachani'), _gr('ἀπέστειλέν με', 'apesteilen me')],
  ),
  ComparativePattern(
    id: 'l002_p07',
    title: '07 · DE DEUS',
    explanationPt: 'O genitivo grego torna a relação de origem explícita.',
    lines: [_pt('de Deus'), _eo('de Dio'), _he('מֵאֱלֹהִים', 'me-Elohim'), _gr('θεοῦ', 'theou')],
  ),
  ComparativePattern(
    id: 'l002_p08',
    title: '08 · A ELE / DELE',
    explanationPt: 'João 1:6 usa αὐτῷ em uma construção possessiva nominal.',
    lines: [_pt('a ele / dele'), _eo('al li / lia'), _he('לוֹ', 'lo'), _gr('αὐτῷ', 'autō')],
  ),
  ComparativePattern(
    id: 'l002_p09',
    title: '09 · SEU NOME ERA JOÃO',
    explanationPt: 'A tradução natural esconde uma estrutura nominal mais compacta no Grego.',
    lines: [_pt('seu nome era João'), _eo('lia nomo estis Johano'), _he('שְׁמוֹ יוֹחָנָן', 'shemo Yochanan', note: 'ponte pedagógica hebraica'), _gr('ὄνομα αὐτῷ Ἰωάννης', 'onoma autō Iōannēs')],
  ),
  ComparativePattern(
    id: 'l002_p10',
    title: '10 · DEUS DISSE',
    explanationPt: 'A identidade é apresentada dentro de discurso, não isoladamente.',
    lines: [_pt('Deus disse'), _eo('Dio diris'), _he('וַיֹּאמֶר אֱלֹהִים', 'vayomer Elohim'), _gr('εἶπεν ὁ θεός', 'eipen ho theos')],
  ),
  ComparativePattern(
    id: 'l002_p11',
    title: '11 · VOCÊ DIRÁ',
    explanationPt: 'Pessoa verbal explícita prepara o aluno para paradigmas posteriores.',
    lines: [_pt('você dirá'), _eo('vi diros'), _he('תֹאמַר', 'tomar'), _gr('ἐρεῖς', 'ereis')],
  ),
  ComparativePattern(
    id: 'l002_p12',
    title: '12 · IDENTIDADE E MISSÃO',
    explanationPt: 'Nome, ser e envio são mantidos como categorias distintas.',
    lines: [_pt('eu sou · meu nome · fui enviado'), _eo('mi estas · mia nomo · mi estis sendita'), _he('אֶהְיֶה · שֵׁם · שָׁלַח', 'ehyeh · shem · shalach'), _gr('εἰμί · ὄνομα · ἀποστέλλω', 'eimi · onoma · apostellō')],
  ),
];

final BiblicalLesson lesson002Identidade = BiblicalLesson(
  id: 'biblical_lesson_002',
  number: 2,
  title: 'EHYEH · ONOMA · IDENTIDADE',
  subtitle: 'Êxodo 3:14 + João 1:6 · ser, nome e envio',
  objectivePt:
      'Distinguir identidade expressa por verbo, nome, relação e missão, preservando a diferença entre morfologia e tradução tradicional.',
  scriptures: lesson002Scriptures,
  patterns: lesson002Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_002',
    patterns: lesson002Patterns,
  ),
  challenge: const LessonChallenge(
    id: 'decode_john_1_6',
    promptPt: 'Decifre: ὄνομα αὐτῷ Ἰωάννης',
    answer: 'Literalmente: “nome a ele: João”. Naturalmente: “seu nome era João”.',
    hintPt: 'Use as estruturas 03, 08 e 09.',
  ),
);
