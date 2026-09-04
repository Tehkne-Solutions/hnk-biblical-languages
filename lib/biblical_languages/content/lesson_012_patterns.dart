import '../models/biblical_lesson.dart';

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

ComparativePattern _p(
  int number,
  String title,
  String explanation,
  List<LanguageLine> lines,
) =>
    ComparativePattern(
      id: 'l012_p${number.toString().padLeft(2, '0')}',
      title: '${number.toString().padLeft(2, '0')} · $title',
      explanationPt: explanation,
      lines: lines,
    );

final lesson012Patterns = <ComparativePattern>[
  _p(
    1,
    'ESTABELEÇA O TEXTO-FONTE',
    'Comece pela forma realmente impressa na edição declarada, antes de tradução, tradição ou comentário.',
    [
      _pt('texto-fonte primeiro'),
      _eo('fontoteksto unue'),
      _he('בְּרֵאשִׁית בָּרָא', 'bereshit bara', note: 'Gênesis 1:1'),
      _gr('Ἐν ἀρχῇ ἦν', 'en archē ēn', note: 'João 1:1'),
    ],
  ),
  _p(
    2,
    'DELIMITE A UNIDADE',
    'Defina qual oração, sintagma ou sequência está sendo analisada; não atribua a uma palavra o que pertence ao contexto maior.',
    [
      _pt('delimite a oração'),
      _eo('limigu la propozicion'),
      _he('אֶהְיֶה אֲשֶׁר אֶהְיֶה', 'ehyeh asher ehyeh'),
      _gr('οὐκ ἦλθον καταλῦσαι', 'ouk ēlthon katalysai'),
    ],
  ),
  _p(
    3,
    'IDENTIFIQUE O LEMA',
    'Separe a forma encontrada no texto de sua entrada lexical. O lema organiza o léxico; não substitui o contexto.',
    [
      _pt('forma → lema'),
      _eo('formo → lemo'),
      _he('אֶהְיֶה → היה', 'ehyeh → hayah'),
      _gr('ἦν → εἰμί', 'ēn → eimi'),
    ],
  ),
  _p(
    4,
    'FAÇA A MORFOLOGIA',
    'Pessoa, número, caso, estado e forma verbal vêm antes de interpretações sobre o que a forma “significa teologicamente”.',
    [
      _pt('analise a forma gramatical'),
      _eo('analizu la gramatikan formon'),
      _he('אֶהְיֶה', 'ehyeh', note: 'Qal imperfeito 1cs'),
      _gr('ἦν', 'ēn', note: 'imperfeito ativo do indicativo 3sg'),
    ],
  ),
  _p(
    5,
    'ESTABELEÇA A SINTAXE',
    'Pergunte quem desempenha cada função na oração e como os termos se relacionam; ordem de palavras não basta.',
    [
      _pt('função sintática antes da conclusão'),
      _eo('sintaksa funkcio antaŭ konkludo'),
      _he('בָּרָא אֱלֹהִים', 'bara Elohim', note: 'verbo + sujeito em Gênesis 1:1'),
      _gr('θεὸς ἦν ὁ λόγος', 'theos ēn ho logos', note: 'ὁ λόγος sujeito; θεός predicativo'),
    ],
  ),
  _p(
    6,
    'MAPEIE O CAMPO SEMÂNTICO',
    'Um gloss é ponto de partida, não uma tradução automática. Liste sentidos plausíveis e elimine os que o contexto não sustenta.',
    [
      _pt('campo semântico, não palavra mágica'),
      _eo('semantika kampo, ne magia vorto'),
      _he('היה · ser / estar / acontecer', 'hayah'),
      _gr('πληρόω · cumprir / completar / encher', 'plēroō'),
    ],
  ),
  _p(
    7,
    'LEIA O DISCURSO E O GÊNERO',
    'Narrativa, poesia sapiencial e discurso direto organizam o sentido de modos diferentes.',
    [
      _pt('gênero e discurso importam'),
      _eo('ĝenro kaj diskurso gravas'),
      _he('אַשְׁרֵי הָאִישׁ', 'ashrei ha’ish', note: 'abertura sapiencial do Salmo 1'),
      _gr('Μὴ νομίσητε', 'mē nomisēte', note: 'proibição em discurso de ensino'),
    ],
  ),
  _p(
    8,
    'PRODUZA A TRADUÇÃO LITERAL',
    'A camada literal deve mostrar a estrutura mesmo quando o Português fica menos natural.',
    [
      _pt('preserve a estrutura visível'),
      _eo('konservu la videblan strukturon'),
      _he('אֶהְיֶה · serei / estarei', 'ehyeh'),
      _gr('καταλῦσαι · abolir / desfazer', 'katalysai'),
    ],
  ),
  _p(
    9,
    'PRODUZA A TRADUÇÃO NATURAL',
    'Depois da literal, formule uma tradução idiomática e identifique o que precisou ser explicitado ou suavizado.',
    [
      _pt('traduza naturalmente e marque decisões'),
      _eo('traduku nature kaj marku decidojn'),
      _he('אֶהְיֶה אֲשֶׁר אֶהְיֶה', 'ehyeh asher ehyeh', note: 'a tradição “EU SOU O QUE SOU” é uma decisão de tradução'),
      _gr('ἀλλὰ πληρῶσαι', 'alla plērōsai', note: '“mas cumprir/completar” exige escolha lexical'),
    ],
  ),
  _p(
    10,
    'COMPARE OPÇÕES DE TRADUÇÃO',
    'Quando mais de uma tradução é linguisticamente defensável, torne a alternativa visível em vez de escondê-la.',
    [
      _pt('compare opções defensáveis'),
      _eo('komparu defendeblajn elektojn'),
      _he('אֶהְיֶה · “serei/estarei” ↔ “EU SOU”', 'ehyeh'),
      _gr('πληρῶσαι · “cumprir” ↔ “completar”', 'plērōsai'),
    ],
  ),
  _p(
    11,
    'DECLARE A INFERÊNCIA JUSTIFICADA',
    'Diga apenas o que as evidências linguísticas sustentam diretamente e identifique quais premissas adicionais seriam necessárias para ir além.',
    [
      _pt('afirme somente o que os dados sustentam'),
      _eo('asertu nur tion, kion la datumoj subtenas'),
      _he('אֶהְיֶה = forma de היה, Qal imperfeito 1cs', 'ehyeh'),
      _gr('πληρῶσαι = infinitivo aoristo ativo de πληρόω', 'plērōsai'),
    ],
  ),
  _p(
    12,
    'MARQUE O LIMITE INTERPRETATIVO',
    'A etapa final impede que morfologia ou sintaxe sejam apresentadas como prova automática de uma doutrina, filosofia ou conclusão histórica.',
    [
      _pt('gramática ≠ conclusão teológica automática'),
      _eo('gramatiko ≠ aŭtomata teologia konkludo'),
      _he('מִבְנֶה לְשׁוֹנִי ≠ מַסְקָנָה אֱמוּנִית', 'estrutura linguística ≠ conclusão de fé', note: 'frase metalinguística pedagógica'),
      _gr('γραμματική ≠ αὐτόματον θεολογικὸν συμπέρασμα', 'grammatikē ≠ automaton theologikon symperasma', note: 'frase metalinguística pedagógica'),
    ],
  ),
];
