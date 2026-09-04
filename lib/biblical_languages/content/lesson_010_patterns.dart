import '../models/biblical_lesson.dart';

LanguageLine _pt(String s) => LanguageLine(language: BiblicalLanguage.portuguese, label: 'Português', text: s);
LanguageLine _eo(String s) => LanguageLine(language: BiblicalLanguage.esperanto, label: 'Esperanto', text: s);
LanguageLine _he(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.biblicalHebrew, label: 'Hebraico Bíblico', text: s, transliteration: t, direction: ScriptDirection.rtl, note: n);
LanguageLine _gr(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.koineGreek, label: 'Grego Koiné', text: s, transliteration: t, note: n);
ComparativePattern _p(int n, String t, String e, List<LanguageLine> l) => ComparativePattern(id: 'l010_p${n.toString().padLeft(2, '0')}', title: '${n.toString().padLeft(2, '0')} · $t', explanationPt: e, lines: l);

final lesson010Patterns = <ComparativePattern>[
  _p(1, 'VOZ', 'O eixo profético começa por uma voz que anuncia.', [_pt('voz'), _eo('voĉo'), _he('קוֹל', 'qol'), _gr('φωνή', 'phōnē')]),
  _p(2, 'CLAMANDO', 'Particípios descrevem a voz em ação.', [_pt('clamando'), _eo('kriante'), _he('קוֹרֵא', 'qore', n: 'Qal particípio ms'), _gr('βοῶντος', 'boōntos', n: 'particípio presente ativo genitivo ms')]),
  _p(3, 'NO DESERTO', 'O mesmo campo espacial aparece nos dois corpora, com sintaxes próprias.', [_pt('no deserto'), _eo('en la dezerto'), _he('בַּמִּדְבָּר', 'bamidbar'), _gr('ἐν τῇ ἐρήμῳ', 'en tē erēmō')]),
  _p(4, 'PREPAREM', 'Imperativo plural em Hebraico e Grego.', [_pt('preparem'), _eo('preparu'), _he('פַּנּוּ', 'pannu', n: 'Piel imperativo mp'), _gr('Ἑτοιμάσατε', 'hetoimasate', n: 'aoristo ativo imperativo 2pl')]),
  _p(5, 'CAMINHO DO SENHOR', 'Relação nominal/construto versus genitivo.', [_pt('caminho do Senhor'), _eo('vojo de la Sinjoro'), _he('דֶּרֶךְ יְהוָה', 'derekh YHWH'), _gr('τὴν ὁδὸν κυρίου', 'tēn hodon kyriou')]),
  _p(6, 'ENDIREITEM / FAÇAM RETAS', 'Dois sistemas expressam a ordem de tornar reto.', [_pt('endireitem / façam retas'), _eo('rektigu'), _he('יַשְּׁרוּ', 'yashsheru'), _gr('εὐθείας ποιεῖτε', 'eutheias poieite')]),
  _p(7, 'ESTRADA / VEREDAS', 'Léxico concreto de caminho é ampliado sem equivalência absoluta.', [_pt('estrada / veredas'), _eo('ŝoseo / vojetoj'), _he('מְסִלָּה', 'mesillah'), _gr('τὰς τρίβους', 'tas tribous')]),
  _p(8, 'PARA NOSSO DEUS', 'Sufixo possessivo hebraico contrasta com formas genitivas gregas.', [_pt('para nosso Deus'), _eo('por nia Dio'), _he('לֵאלֹהֵינוּ', 'le-Elohenu'), _gr('τοῦ θεοῦ ἡμῶν', 'tou theou hēmōn', n: 'ponte de Isaías LXX')]),
  _p(9, 'COMO ESTÁ ESCRITO', 'Marcos sinaliza explicitamente uma citação escrita.', [_pt('como está escrito'), _eo('kiel estas skribite'), _he('כַּכָּתוּב', 'kakkatuv', n: 'ponte pedagógica'), _gr('Καθὼς γέγραπται', 'kathōs gegraptai')]),
  _p(10, 'O PROFETA', 'Título profético entra como marcador de fonte.', [_pt('o profeta'), _eo('la profeto'), _he('הַנָּבִיא', 'hannavi', n: 'ponte lexical'), _gr('τῷ προφήτῃ', 'tō prophētē')]),
  _p(11, 'ENVIO MEU MENSAGEIRO', 'O bloco de Marcos incorpora material além de Isaías 40:3.', [_pt('envio meu mensageiro'), _eo('mi sendas mian senditon'), _he('שֹׁלֵחַ מַלְאָכִי', 'sholeach malakhi', n: 'ponte lexical; não é Isaías 40:3'), _gr('ἀποστέλλω τὸν ἄγγελόν μου', 'apostellō ton angelon mou')]),
  _p(12, 'CITAÇÃO COMPOSTA', 'Marcos 1:2–3 combina material profético; correspondência direta com Isaías concentra-se no v.3.', [_pt('Isaías 40:3 + ecos anteriores'), _eo('Jesaja 40:3 + pli fruaj eĥoj'), _he('קוֹל קוֹרֵא … פַּנּוּ', 'qol qore … pannu'), _gr('φωνὴ βοῶντος … Ἑτοιμάσατε', 'phōnē boōntos … hetoimasate')]),
];