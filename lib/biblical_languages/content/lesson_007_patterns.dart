import '../models/biblical_lesson.dart';

LanguageLine _pt(String s) => LanguageLine(language: BiblicalLanguage.portuguese, label: 'Português', text: s);
LanguageLine _eo(String s) => LanguageLine(language: BiblicalLanguage.esperanto, label: 'Esperanto', text: s);
LanguageLine _he(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.biblicalHebrew, label: 'Hebraico Bíblico', text: s, transliteration: t, direction: ScriptDirection.rtl, note: n);
LanguageLine _gr(String s, String t, {String? n}) => LanguageLine(language: BiblicalLanguage.koineGreek, label: 'Grego Koiné', text: s, transliteration: t, note: n);

ComparativePattern _p(int n, String title, String note, List<LanguageLine> lines) => ComparativePattern(id: 'l007_p${n.toString().padLeft(2, '0')}', title: '${n.toString().padLeft(2, '0')} · $title', explanationPt: note, lines: lines);

final lesson007Patterns = <ComparativePattern>[
  _p(1, 'QUE A TERRA BROTE', 'Jussivo hebraico: convocação para a criação produzir.', [_pt('que a terra faça brotar'), _eo('la tero kreskigu'), _he('תַּדְשֵׁא הָאָרֶץ', 'tadshê ha’aretz'), _gr('βλαστησάτω ἡ γῆ', 'blastēsatō hē gē', n: 'ponte LXX')]),
  _p(2, 'A TERRA PRODUZIU', 'A narrativa registra a realização do enunciado anterior.', [_pt('a terra produziu'), _eo('la tero produktis'), _he('וַתּוֹצֵא הָאָרֶץ', 'vattotse ha’aretz'), _gr('ἐξήνεγκεν ἡ γῆ', 'exēnenken hē gē', n: 'ponte pedagógica')]),
  _p(3, 'VEGETAÇÃO', 'Léxico concreto da criação.', [_pt('vegetação'), _eo('vegetaĵaro'), _he('דֶּשֶׁא', 'deshe'), _gr('χλόη', 'chloē', n: 'ponte lexical')]),
  _p(4, 'SEMENTE', 'A imagem de reprodução fixa substantivos concretos.', [_pt('semente'), _eo('semo'), _he('זֶרַע', 'zera'), _gr('σπέρμα', 'sperma', n: 'ponte lexical')]),
  _p(5, 'ÁRVORE E FRUTO', 'Construto hebraico e léxico natural lado a lado.', [_pt('árvore de fruto'), _eo('fruktarbo'), _he('עֵץ פְּרִי', 'etz peri'), _gr('δένδρον · καρπός', 'dendron · karpos', n: 'ponte lexical')]),
  _p(6, 'SEGUNDO SUA ESPÉCIE', 'A classificação pertence ao texto hebraico sem equivalência forçada em João.', [_pt('segundo a sua espécie'), _eo('laŭ sia speco'), _he('לְמִינוֹ', 'lemino'), _gr('κατὰ γένος', 'kata genos', n: 'ponte pedagógica')]),
  _p(7, 'E ASSIM FOI', 'Resultado narrativo recorrente em Gênesis.', [_pt('e assim foi'), _eo('kaj tiel estis'), _he('וַיְהִי־כֵן', 'vayehi-khen'), _gr('καὶ ἐγένετο οὕτως', 'kai egeneto houtōs', n: 'ponte pedagógica')]),
  _p(8, 'ERA BOM', 'Descrição e avaliação não são a mesma categoria que ação.', [_pt('era bom'), _eo('estis bona'), _he('כִּי־טוֹב', 'ki-tov'), _gr('καλός', 'kalos', n: 'ponte lexical')]),
  _p(9, 'VEIO A EXISTIR', 'João retoma γίνομαι para falar daquilo que passou a existir.', [_pt('veio a existir'), _eo('ekestis'), _he('הָיָה', 'hayah', n: 'ponte lexical'), _gr('ἐγένετο', 'egeneto')]),
  _p(10, 'VIDA', 'Vida entra como categoria central de João 1:4.', [_pt('vida'), _eo('vivo'), _he('חַיִּים', 'chayyim', n: 'ponte lexical'), _gr('ζωή', 'zōē')]),
  _p(11, 'LUZ', 'O eixo criação → vida → luz conecta o léxico das Lessons anteriores.', [_pt('luz'), _eo('lumo'), _he('אוֹר', 'or'), _gr('φῶς', 'phōs')]),
  _p(12, 'A LUZ BRILHA NAS TREVAS', 'Presente φαίνει contrasta com o aoristo κατέλαβεν sem encerrar sua ambiguidade lexical.', [_pt('a luz brilha nas trevas'), _eo('la lumo brilas en la mallumo'), _he('אוֹר בַּחֹשֶׁךְ', 'or bachoshekh', n: 'ponte pedagógica'), _gr('τὸ φῶς ἐν τῇ σκοτίᾳ φαίνει', 'to phōs en tē skotia phainei')]),
];