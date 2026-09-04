import '../models/biblical_lesson.dart';

const lesson011John114 = ScripturePassage(
  id: 'john_1_14_greek',
  reference: 'João 1:14',
  language: BiblicalLanguage.koineGreek,
  text: 'Καὶ ὁ λόγος σὰρξ ἐγένετο καὶ ἐσκήνωσεν ἐν ἡμῖν, καὶ ἐθεασάμεθα τὴν δόξαν αὐτοῦ, δόξαν ὡς μονογενοῦς παρὰ πατρός, πλήρης χάριτος καὶ ἀληθείας·',
  transliteration: 'Kai ho logos sarx egeneto kai eskēnōsen en hēmin, kai etheasametha tēn doxan autou, doxan hōs monogenous para patros, plērēs charitos kai alētheias.',
  literalPt: 'E o Logos carne veio a ser e armou sua tenda entre nós, e contemplamos a glória dele, glória como de único junto do Pai, cheio de graça e verdade.',
  naturalPt: 'E o Verbo se fez carne e habitou entre nós; contemplamos a sua glória, glória como do Filho único vindo do Pai, cheio de graça e verdade.',
  sourceEdition: 'SBL Greek New Testament (SBLGNT) v1.2',
  sourceLicense: 'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA',
  sourceAttribution: 'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.',
  translationNotePt: 'ἐγένετο e ἐσκήνωσεν são aoristos indicativos; ἐθεασάμεθα é aoristo médio 1pl. σὰρξ funciona como predicativo em “o Logos tornou-se carne”. A tradução “habitou” é natural; o verbo σκηνόω conserva a imagem lexical de tenda/tabernáculo sem transformar essa imagem, sozinha, em conclusão teológica completa.',
  tokens: [
    ScriptureToken(surface: 'ὁ λόγος', transliteration: 'ho logos', glossPt: 'o Logos / a Palavra', lemma: 'λόγος', morphology: 'artigo + substantivo masculino, nominativo singular'),
    ScriptureToken(surface: 'σὰρξ', transliteration: 'sarx', glossPt: 'carne', lemma: 'σάρξ', morphology: 'substantivo feminino, nominativo singular'),
    ScriptureToken(surface: 'ἐγένετο', transliteration: 'egeneto', glossPt: 'veio a ser / tornou-se', lemma: 'γίνομαι', morphology: 'aoristo médio do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'ἐσκήνωσεν', transliteration: 'eskēnōsen', glossPt: 'habitou / armou tenda', lemma: 'σκηνόω', morphology: 'aoristo ativo do indicativo, 3ª pessoa singular'),
    ScriptureToken(surface: 'ἐθεασάμεθα', transliteration: 'etheasametha', glossPt: 'contemplamos / vimos', lemma: 'θεάομαι', morphology: 'aoristo médio do indicativo, 1ª pessoa plural'),
    ScriptureToken(surface: 'τὴν δόξαν αὐτοῦ', transliteration: 'tēn doxan autou', glossPt: 'a glória dele', lemma: 'δόξα + αὐτός', morphology: 'substantivo feminino acusativo singular + pronome genitivo masculino singular'),
    ScriptureToken(surface: 'χάριτος καὶ ἀληθείας', transliteration: 'charitos kai alētheias', glossPt: 'de graça e verdade', lemma: 'χάρις + καί + ἀλήθεια', morphology: 'substantivos femininos genitivo singular coordenados'),
  ],
);