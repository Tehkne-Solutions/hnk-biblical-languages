import '../models/biblical_lesson.dart';

const lesson007Greek = ScripturePassage(
  id: 'john_1_3_5_greek',
  reference: 'João 1:3–5',
  language: BiblicalLanguage.koineGreek,
  text: 'πάντα δι’ αὐτοῦ ἐγένετο, καὶ χωρὶς αὐτοῦ ἐγένετο οὐδὲ ἕν. '
      'ὃ γέγονεν ἐν αὐτῷ ζωὴ ἦν, καὶ '
      '\u{1F21} ζωὴ ἦν τὸ φῶς τῶν ἀνθρώπων· καὶ τὸ φῶς ἐν τῇ σκοτίᾳ φαίνει, καὶ '
      '\u{1F21} σκοτία αὐτὸ οὐ κατέλαβεν.',
  transliteration: 'Panta di’ autou egeneto ... ho gegonen en autō zōē ēn ... kai to phōs en tē skotia phainei ...',
  literalPt: 'Todas as coisas por meio dele vieram a existir; sem ele não veio a existir nem uma. O que veio a existir nele era vida, e a vida era a luz dos seres humanos; e a luz brilha na escuridão, e a escuridão não a apreendeu.',
  naturalPt: 'Tudo veio a existir por meio dele. Nele havia vida, e a vida era a luz da humanidade. A luz brilha nas trevas, e as trevas não a apreenderam.',
  sourceEdition: 'SBL Greek New Testament (SBLGNT) v1.2',
  sourceLicense: 'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA',
  sourceAttribution: 'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.',
  translationNotePt: 'A fronteira de pontuação envolvendo ὃ γέγονεν é editorial e fica para níveis avançados. φαίνει é presente ativo indicativo; κατέλαβεν é aoristo ativo indicativo. καταλαμβάνω admite sentidos como apreender, alcançar ou dominar, por isso o curso não transforma um gloss isolado em conclusão exegética.',
  tokens: [
    ScriptureToken(surface: 'ἐγένετο', transliteration: 'egeneto', glossPt: 'veio a existir', lemma: 'γίνομαι', morphology: 'aoristo médio do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'γέγονεν', transliteration: 'gegonen', glossPt: 'veio a existir / tornou-se', lemma: 'γίνομαι', morphology: 'perfeito ativo do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'ζωὴ', transliteration: 'zōē', glossPt: 'vida', lemma: 'ζωή', morphology: 'substantivo feminino, nominativo singular'),
    ScriptureToken(surface: 'φῶς', transliteration: 'phōs', glossPt: 'luz', lemma: 'φῶς', morphology: 'substantivo neutro, nominativo singular'),
    ScriptureToken(surface: 'σκοτίᾳ', transliteration: 'skotia', glossPt: 'escuridão / trevas', lemma: 'σκοτία', morphology: 'substantivo feminino, dativo singular'),
    ScriptureToken(surface: 'φαίνει', transliteration: 'phainei', glossPt: 'brilha', lemma: 'φαίνω', morphology: 'presente ativo do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'κατέλαβεν', transliteration: 'katelaben', glossPt: 'apreendeu / alcançou / dominou', lemma: 'καταλαμβάνω', morphology: 'aoristo ativo do indicativo, 3ª pessoa singular'),
  ],
);