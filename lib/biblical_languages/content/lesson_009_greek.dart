import '../models/biblical_lesson.dart';

const lesson009Greek = ScripturePassage(
  id: 'matthew_5_17_greek',
  reference: 'Mateus 5:17',
  language: BiblicalLanguage.koineGreek,
  text: 'Μὴ νομίσητε ὅτι ἦλθον καταλῦσαι τὸν νόμον ἢ τοὺς προφήτας· οὐκ ἦλθον καταλῦσαι ἀλλὰ πληρῶσαι·',
  transliteration: 'Mē nomisēte hoti ēlthon katalysai ton nomon ē tous prophētas; ouk ēlthon katalysai alla plērōsai.',
  literalPt: 'Não penseis que vim abolir a Lei ou os Profetas; não vim abolir, mas cumprir.',
  naturalPt: 'Não pensem que eu vim abolir a Lei ou os Profetas; não vim abolir, mas cumprir.',
  sourceEdition: 'SBL Greek New Testament (SBLGNT) v1.2',
  sourceLicense: 'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA',
  sourceAttribution: 'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.',
  translationNotePt: 'Μὴ + subjuntivo aoristo forma uma proibição. καταλῦσαι e πληρῶσαι são infinitivos aoristos ativos em contraste. O curso preserva os campos lexicais “abolir/desfazer” e “cumprir/completar” antes de qualquer conclusão doutrinária sobre a Lei.',
  tokens: [
    ScriptureToken(surface: 'Μὴ νομίσητε', transliteration: 'mē nomisēte', glossPt: 'não pensem', lemma: 'μή + νομίζω', morphology: 'partícula negativa μή + aoristo ativo do subjuntivo, 2ª pessoa plural'),
    ScriptureToken(surface: 'ἦλθον', transliteration: 'ēlthon', glossPt: 'vim', lemma: 'ἔρχομαι', morphology: 'aoristo ativo do indicativo, 1ª pessoa singular'),
    ScriptureToken(surface: 'καταλῦσαι', transliteration: 'katalysai', glossPt: 'abolir / desfazer', lemma: 'καταλύω', morphology: 'aoristo ativo infinitivo'),
    ScriptureToken(surface: 'τὸν νόμον', transliteration: 'ton nomon', glossPt: 'a Lei', lemma: 'νόμος', morphology: 'artigo + substantivo masculino, acusativo singular'),
    ScriptureToken(surface: 'τοὺς προφήτας', transliteration: 'tous prophētas', glossPt: 'os Profetas', lemma: 'προφήτης', morphology: 'artigo + substantivo masculino, acusativo plural'),
    ScriptureToken(surface: 'ἀλλὰ πληρῶσαι', transliteration: 'alla plērōsai', glossPt: 'mas cumprir / completar', lemma: 'ἀλλά + πληρόω', morphology: 'conjunção adversativa + aoristo ativo infinitivo'),
  ],
);