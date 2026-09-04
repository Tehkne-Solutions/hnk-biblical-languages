import '../models/biblical_lesson.dart';

LanguageLine _pt(String s) => LanguageLine(language: BiblicalLanguage.portuguese, label: 'Português', text: s);
LanguageLine _eo(String s) => LanguageLine(language: BiblicalLanguage.esperanto, label: 'Esperanto', text: s);
LanguageLine _he(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.biblicalHebrew, label: 'Hebraico Bíblico', text: s, transliteration: t, direction: ScriptDirection.rtl, note: n);
LanguageLine _gr(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.koineGreek, label: 'Grego Koiné', text: s, transliteration: t, note: n);
ComparativePattern _p(int n, String t, String e, List<LanguageLine> l) => ComparativePattern(id: 'l008_p${n.toString().padLeft(2, '0')}', title: '${n.toString().padLeft(2, '0')} · $t', explanationPt: e, lines: l);

final lesson008Patterns = <ComparativePattern>[
  _p(1, 'REI', 'Título político central nos dois textos.', [_pt('rei'), _eo('reĝo'), _he('מֶלֶךְ', 'melekh'), _gr('βασιλεύς', 'basileus')]),
  _p(2, 'ESTABELECE PARA NÓS', 'O pedido de Israel usa imperativo explícito.', [_pt('estabelece para nós'), _eo('starigu por ni'), _he('שִׂימָה־לָּנוּ', 'simah-lanu'), _gr('κατάστησον ἡμῖν', 'katastēson hēmin', n: 'ponte pedagógica')]),
  _p(3, 'PARA NOS JULGAR', 'Infinitivo construto com sufixo expressa finalidade.', [_pt('para nos julgar / governar'), _eo('por juĝi nin'), _he('לְשָׁפְטֵנוּ', 'leshofetenu'), _gr('κρίνειν ἡμᾶς', 'krinein hēmas', n: 'ponte lexical')]),
  _p(4, 'NAÇÕES', 'Povo e nação não são categorias automaticamente idênticas.', [_pt('nações'), _eo('nacioj'), _he('הַגּוֹיִם', 'haggoyim'), _gr('τὰ ἔθνη', 'ta ethnē', n: 'ponte lexical')]),
  _p(5, 'COMO TODAS AS NAÇÕES', 'כ + כֹּל marca comparação e totalidade.', [_pt('como todas as nações'), _eo('kiel ĉiuj nacioj'), _he('כְּכָל־הַגּוֹיִם', 'kekhol-haggoyim'), _gr('ὡς πάντα τὰ ἔθνη', 'hōs panta ta ethnē', n: 'ponte pedagógica')]),
  _p(6, 'EM BELÉM', 'ἐν situa a cena.', [_pt('em Belém'), _eo('en Bet-Leĥem'), _he('בְּבֵית לֶחֶם', 'be-Veit Lechem', n: 'ponte lexical'), _gr('ἐν Βηθλέεμ', 'en Bēthleem')]),
  _p(7, 'DA JUDEIA', 'Genitivo grego relaciona cidade e região.', [_pt('da Judeia'), _eo('de Judujo'), _he('יְהוּדָה', 'Yehudah', n: 'ponte lexical'), _gr('τῆς Ἰουδαίας', 'tēs Ioudaias')]),
  _p(8, 'HERODES, O REI', 'Título em genitivo acompanha o nome próprio.', [_pt('Herodes, o rei'), _eo('Herodo, la reĝo'), _he('הוֹרְדוֹס הַמֶּלֶךְ', 'Hordos hammelekh', n: 'ponte pedagógica'), _gr('Ἡρῴδου τοῦ βασιλέως', 'Hērōdou tou basileōs')]),
  _p(9, 'DO ORIENTE', 'ἀπό marca origem.', [_pt('do oriente'), _eo('el la oriento'), _he('מִמִּזְרָח', 'mimmizrach', n: 'ponte lexical'), _gr('ἀπὸ ἀνατολῶν', 'apo anatolōn')]),
  _p(10, 'CHEGARAM', 'παραγίνομαι descreve chegada/aparecimento.', [_pt('chegaram'), _eo('alvenis'), _he('בָּאוּ', 'ba’u', n: 'ponte lexical'), _gr('παρεγένοντο', 'paregenonto')]),
  _p(11, 'PARA JERUSALÉM', 'εἰς marca direção e destino.', [_pt('para Jerusalém'), _eo('al Jerusalemo'), _he('לִירוּשָׁלַיִם', 'li-Yerushalayim', n: 'ponte lexical'), _gr('εἰς Ἱεροσόλυμα', 'eis Hierosolyma')]),
  _p(12, 'ORIGEM → DESTINO', 'Preposições constroem um mapa linguístico.', [_pt('do oriente → para Jerusalém'), _eo('el la oriento → al Jerusalemo'), _he('מִן … אֶל', 'min … el', n: 'ponte estrutural'), _gr('ἀπό … εἰς', 'apo … eis')]),
];