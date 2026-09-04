import '../models/biblical_lesson.dart';

LanguageLine _pt(String s) => LanguageLine(language: BiblicalLanguage.portuguese, label: 'Português', text: s);
LanguageLine _eo(String s) => LanguageLine(language: BiblicalLanguage.esperanto, label: 'Esperanto', text: s);
LanguageLine _he(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.biblicalHebrew, label: 'Hebraico Bíblico', text: s, transliteration: t, direction: ScriptDirection.rtl, note: n);
LanguageLine _gr(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.koineGreek, label: 'Grego Koiné', text: s, transliteration: t, note: n);
ComparativePattern _p(int n, String t, String e, List<LanguageLine> l) => ComparativePattern(id: 'l011_p${n.toString().padLeft(2, '0')}', title: '${n.toString().padLeft(2, '0')} · $t', explanationPt: e, lines: l);

final lesson011Patterns = <ComparativePattern>[
  _p(1, 'NO PRINCÍPIO', 'Reconheça a âncora antes de traduzir a frase inteira.', [_pt('no princípio'), _eo('en la komenco'), _he('בְּרֵאשִׁית', 'bereshit'), _gr('Ἐν ἀρχῇ', 'en archē')]),
  _p(2, 'CRIOU / VEIO A EXISTIR', 'Recupere o contraste entre criar e vir-a-ser.', [_pt('criou / veio a existir'), _eo('kreis / ekestis'), _he('בָּרָא', 'bara'), _gr('ἐγένετο', 'egeneto')]),
  _p(3, 'HAJA LUZ', 'Leia como unidade antes de decompor palavra por palavra.', [_pt('haja luz'), _eo('estu lumo'), _he('יְהִי אוֹר', 'yehi or'), _gr('φῶς', 'phōs', n: 'João retoma o campo da luz')]),
  _p(4, 'FORMOU O HUMANO', 'A leitura avança da criação cósmica para Gênesis 2.', [_pt('formou o humano'), _eo('formis la homon'), _he('וַיִּיצֶר … הָאָדָם', 'vayyitser … ha’adam'), _gr('ἄνθρωπος', 'anthrōpos', n: 'ponte lexical')]),
  _p(5, 'FÔLEGO DE VIDA', 'Use a estrutura nominal para recuperar o sentido sem PT.', [_pt('fôlego de vida'), _eo('spiro de vivo'), _he('נִשְׁמַת חַיִּים', 'nishmat chayyim'), _gr('ζωή', 'zōē', n: 'campo lexical de vida')]),
  _p(6, 'SER VIVENTE', 'נֶפֶשׁ não é reduzido automaticamente ao português “alma”.', [_pt('ser / criatura vivente'), _eo('vivanta estaĵo'), _he('נֶפֶשׁ חַיָּה', 'nefesh chayyah'), _gr('ζωή', 'zōē', n: 'ponte sem equivalência ontológica')]),
  _p(7, 'ONDE ESTÁS?', 'Uma pergunta curta serve como checkpoint de leitura sem apoio.', [_pt('onde estás?'), _eo('kie vi estas?'), _he('אַיֶּכָּה', 'ayyekkah'), _gr('ποῦ εἶ;', 'pou ei?', n: 'ponte interrogativa')]),
  _p(8, 'O LOGOS', 'Retome João 1:1 diretamente no Grego.', [_pt('o Logos / a Palavra'), _eo('la Vorto'), _he('דָּבָר', 'davar', n: 'ponte lexical'), _gr('ὁ λόγος', 'ho logos')]),
  _p(9, 'TORNOU-SE CARNE', 'A leitura contínua chega a João 1:14.', [_pt('tornou-se carne'), _eo('fariĝis karno'), _he('בָּשָׂר', 'basar', n: 'ponte lexical'), _gr('σὰρξ ἐγένετο', 'sarx egeneto')]),
  _p(10, 'HABITOU ENTRE NÓS', 'Reconheça o verbo antes de consultar o gloss.', [_pt('habitou entre nós'), _eo('loĝis inter ni'), _he('שָׁכַן', 'shakhan', n: 'ponte lexical'), _gr('ἐσκήνωσεν ἐν ἡμῖν', 'eskēnōsen en hēmin')]),
  _p(11, 'CONTEMPLAMOS A GLÓRIA', 'Pessoa verbal e objeto direto precisam ser recuperados juntos.', [_pt('contemplamos a glória dele'), _eo('ni vidis lian gloron'), _he('כָּבוֹד', 'kavod', n: 'ponte lexical'), _gr('ἐθεασάμεθα τὴν δόξαν αὐτοῦ', 'etheasametha tēn doxan autou')]),
  _p(12, 'GRAÇA E VERDADE', 'Feche a leitura identificando uma coordenação nominal sem tradução imediata.', [_pt('graça e verdade'), _eo('graco kaj vero'), _he('חֵן וֶאֱמֶת', 'chen ve’emet', n: 'ponte lexical'), _gr('χάριτος καὶ ἀληθείας', 'charitos kai alētheias')]),
];