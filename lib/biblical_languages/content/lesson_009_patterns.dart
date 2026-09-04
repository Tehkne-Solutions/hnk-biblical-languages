import '../models/biblical_lesson.dart';

LanguageLine _pt(String s) => LanguageLine(language: BiblicalLanguage.portuguese, label: 'Português', text: s);
LanguageLine _eo(String s) => LanguageLine(language: BiblicalLanguage.esperanto, label: 'Esperanto', text: s);
LanguageLine _he(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.biblicalHebrew, label: 'Hebraico Bíblico', text: s, transliteration: t, direction: ScriptDirection.rtl, note: n);
LanguageLine _gr(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.koineGreek, label: 'Grego Koiné', text: s, transliteration: t, note: n);
ComparativePattern _p(int n, String t, String e, List<LanguageLine> l) => ComparativePattern(id: 'l009_p${n.toString().padLeft(2, '0')}', title: '${n.toString().padLeft(2, '0')} · $t', explanationPt: e, lines: l);

final lesson009Patterns = <ComparativePattern>[
  _p(1, 'FELIZ / BEM-AVENTURADO', 'O Salmo abre com uma fórmula de felicidade, não com verbo explícito “ser”.', [_pt('feliz / bem-aventurado'), _eo('feliĉa'), _he('אַשְׁרֵי', 'ashrei'), _gr('μακάριος', 'makarios', n: 'ponte lexical')]),
  _p(2, 'O HOMEM / A PESSOA', 'Vocabulário humano em leitura sapiencial.', [_pt('o homem / a pessoa'), _eo('la homo'), _he('הָאִישׁ', 'ha’ish'), _gr('ὁ ἄνθρωπος', 'ho anthrōpos', n: 'ponte lexical')]),
  _p(3, 'NÃO ANDOU', 'Negação + perfeito abre o paralelismo.', [_pt('não andou'), _eo('ne iris'), _he('לֹא הָלַךְ', 'lo halakh'), _gr('οὐκ ἐπορεύθη', 'ouk eporeuthē', n: 'ponte pedagógica')]),
  _p(4, 'NO CONSELHO', 'עֵצָה em construto introduz fonte/orientação.', [_pt('no conselho de'), _eo('en la konsilo de'), _he('בַּעֲצַת', 'ba’atsat'), _gr('ἐν βουλῇ', 'en boulē', n: 'ponte lexical')]),
  _p(5, 'PERVERSOS', 'Categoria ética lexical sem interpretação automática de pessoas específicas.', [_pt('perversos'), _eo('malvirtuloj'), _he('רְשָׁעִים', 'resha‘im'), _gr('ἀσεβεῖς', 'asebeis', n: 'ponte lexical')]),
  _p(6, 'CAMINHO DE PECADORES', 'Caminho funciona como imagem e estrutura de relação nominal.', [_pt('caminho de pecadores'), _eo('vojo de pekuloj'), _he('דֶרֶךְ חַטָּאִים', 'derekh chatta’im'), _gr('ὁδὸς ἁμαρτωλῶν', 'hodos hamartōlōn', n: 'ponte lexical')]),
  _p(7, 'NÃO PAROU', 'Segundo membro do paralelismo negativo.', [_pt('não parou / permaneceu'), _eo('ne staris'), _he('לֹא עָמָד', 'lo amad'), _gr('οὐκ ἔστη', 'ouk estē', n: 'ponte lexical')]),
  _p(8, 'NÃO SE ASSENTOU', 'Terceiro membro fecha o paralelismo.', [_pt('não se assentou'), _eo('ne sidis'), _he('לֹא יָשָׁב', 'lo yashav'), _gr('οὐκ ἐκάθισεν', 'ouk ekathisen', n: 'ponte lexical')]),
  _p(9, 'A LEI', 'νόμος e תּוֹרָה são aproximados lexicalmente, não declarados equivalentes absolutos.', [_pt('a Lei / instrução'), _eo('la Leĝo'), _he('תּוֹרָה', 'torah', n: 'ponte lexical'), _gr('τὸν νόμον', 'ton nomon')]),
  _p(10, 'OS PROFETAS', 'Categoria textual/pessoal do enunciado de Mateus.', [_pt('os Profetas'), _eo('la Profetoj'), _he('הַנְּבִיאִים', 'hannevi’im', n: 'ponte lexical'), _gr('τοὺς προφήτας', 'tous prophētas')]),
  _p(11, 'NÃO ABOLIR', 'καταλύω tem campo próprio; o infinitivo permanece visível.', [_pt('não abolir / desfazer'), _eo('ne nuligi'), _he('לֹא … הֵפֵר', 'lo … hefer', n: 'ponte lexical'), _gr('οὐκ … καταλῦσαι', 'ouk … katalysai')]),
  _p(12, 'MAS CUMPRIR', 'O contraste ἀλλά organiza a conclusão da frase.', [_pt('mas cumprir / completar'), _eo('sed plenumi'), _he('אֶלָּא … מָלֵא', 'ella … male', n: 'ponte pedagógica'), _gr('ἀλλὰ πληρῶσαι', 'alla plērōsai')]),
];