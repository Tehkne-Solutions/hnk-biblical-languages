import '../models/biblical_lesson.dart';

const lesson010Greek = ScripturePassage(
  id: 'mark_1_2_3_greek',
  reference: 'Marcos 1:2–3',
  language: BiblicalLanguage.koineGreek,
  text: 'Καθὼς γέγραπται ἐν τῷ Ἠσαΐᾳ τῷ προφήτῃ· Ἰδοὺ ἀποστέλλω τὸν ἄγγελόν μου πρὸ προσώπου σου, ὃς κατασκευάσει τὴν ὁδόν σου· φωνὴ βοῶντος ἐν τῇ ἐρήμῳ· Ἑτοιμάσατε τὴν ὁδὸν κυρίου, εὐθείας ποιεῖτε τὰς τρίβους αὐτοῦ,',
  transliteration: 'Kathōs gegraptai en tō Ēsaia tō prophētē ... phōnē boōntos en tē erēmō; hetoimasate tēn hodon kyriou, eutheias poieite tas tribous autou.',
  literalPt: 'Como está escrito em Isaías, o profeta: “Eis que envio meu mensageiro diante de tua face, o qual preparará teu caminho; voz de alguém clamando no deserto: preparai o caminho do Senhor, fazei retas as suas veredas”.',
  naturalPt: 'Como está escrito em Isaías, o profeta: “Enviarei meu mensageiro à tua frente; ele preparará teu caminho. Uma voz clama no deserto: preparem o caminho do Senhor, façam retas as suas veredas”.',
  sourceEdition: 'SBL Greek New Testament (SBLGNT) v1.2',
  sourceLicense: 'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA',
  sourceAttribution: 'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.',
  translationNotePt: 'Marcos 1:2–3 forma um bloco de citação composto: o v.3 corresponde diretamente a Isaías 40:3, enquanto material do v.2 ecoa também Êxodo 23:20/Malaquias 3:1. γέγραπται é perfeito passivo; Ἑτοιμάσατε é imperativo aoristo; ποιεῖτε é imperativo presente. O curso descreve o fenômeno de citação antes de discutir suas implicações exegéticas.',
  tokens: [
    ScriptureToken(surface: 'Καθὼς γέγραπται', transliteration: 'kathōs gegraptai', glossPt: 'como está escrito', lemma: 'καθώς + γράφω', morphology: 'conjunção/advérbio + perfeito passivo do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'ἐν τῷ Ἠσαΐᾳ τῷ προφήτῃ', transliteration: 'en tō Ēsaia tō prophētē', glossPt: 'em Isaías, o profeta', lemma: 'ἐν + Ἠσαΐας + προφήτης', morphology: 'preposição ἐν + nomes em dativo masculino singular'),
    ScriptureToken(surface: 'ἀποστέλλω', transliteration: 'apostellō', glossPt: 'envio', lemma: 'ἀποστέλλω', morphology: 'presente ativo do indicativo, 1ª pessoa singular'),
    ScriptureToken(surface: 'κατασκευάσει', transliteration: 'kataskeuasei', glossPt: 'preparará', lemma: 'κατασκευάζω', morphology: 'futuro ativo do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'φωνὴ βοῶντος', transliteration: 'phōnē boōntos', glossPt: 'voz de alguém clamando', lemma: 'φωνή + βοάω', morphology: 'substantivo nominativo feminino singular + particípio presente ativo genitivo masculino singular'),
    ScriptureToken(surface: 'ἐν τῇ ἐρήμῳ', transliteration: 'en tē erēmō', glossPt: 'no deserto', lemma: 'ἐν + ἔρημος', morphology: 'preposição ἐν + adjetivo/substantivado dativo feminino singular'),
    ScriptureToken(surface: 'Ἑτοιμάσατε', transliteration: 'hetoimasate', glossPt: 'preparem', lemma: 'ἑτοιμάζω', morphology: 'aoristo ativo do imperativo, 2ª pessoa plural'),
    ScriptureToken(surface: 'ποιεῖτε', transliteration: 'poieite', glossPt: 'façam', lemma: 'ποιέω', morphology: 'presente ativo do imperativo, 2ª pessoa plural'),
  ],
);