import '../models/biblical_lesson.dart';

const lesson008Greek = ScripturePassage(
  id: 'matthew_2_1_greek',
  reference: 'Mateus 2:1',
  language: BiblicalLanguage.koineGreek,
  text: 'Τοῦ δὲ Ἰησοῦ γεννηθέντος ἐν Βηθλέεμ τῆς Ἰουδαίας ἐν '
      '\u{1F21}μέραις Ἡρῴδου τοῦ βασιλέως, ἰδοὺ μάγοι ἀπὸ ἀνατολῶν '
      'παρεγένοντο εἰς Ἱεροσόλυμα.',
  transliteration: 'Tou de Iēsou gennēthentos en Bēthleem tēs Ioudaias en hēmerais Hērōdou tou basileōs, idou magoi apo anatolōn paregenonto eis Hierosolyma.',
  literalPt: 'Tendo Jesus sido nascido em Belém da Judeia, nos dias de Herodes, o rei, eis que magos do oriente chegaram a Jerusalém.',
  naturalPt: 'Depois que Jesus nasceu em Belém da Judeia, nos dias do rei Herodes, magos vindos do oriente chegaram a Jerusalém.',
  sourceEdition: 'SBL Greek New Testament (SBLGNT) v1.2',
  sourceLicense: 'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA',
  sourceAttribution: 'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.',
  translationNotePt: 'γεννηθέντος é particípio aoristo passivo genitivo masculino singular e participa de uma construção genitiva circunstancial. ἀπὸ marca origem e εἰς direção. παρεγένοντο é aoristo médio indicativo 3pl. O curso descreve relações espaciais e títulos sem transformar a gramática em reconstrução histórica automática.',
  tokens: [
    ScriptureToken(surface: 'γεννηθέντος', transliteration: 'gennēthentos', glossPt: 'tendo sido nascido / tendo nascido', lemma: 'γεννάω', morphology: 'particípio aoristo passivo, genitivo masculino singular'),
    ScriptureToken(surface: 'ἐν Βηθλέεμ', transliteration: 'en Bēthleem', glossPt: 'em Belém', lemma: 'ἐν + Βηθλέεμ', morphology: 'preposição ἐν + nome próprio indeclinável'),
    ScriptureToken(surface: 'τῆς Ἰουδαίας', transliteration: 'tēs Ioudaias', glossPt: 'da Judeia', lemma: 'Ἰουδαία', morphology: 'artigo + nome próprio feminino, genitivo singular'),
    ScriptureToken(surface: 'τοῦ βασιλέως', transliteration: 'tou basileōs', glossPt: 'do rei', lemma: 'βασιλεύς', morphology: 'artigo + substantivo masculino, genitivo singular'),
    ScriptureToken(surface: 'ἀπὸ ἀνατολῶν', transliteration: 'apo anatolōn', glossPt: 'do oriente / desde os lugares do nascente', lemma: 'ἀπό + ἀνατολή', morphology: 'preposição ἀπό + substantivo feminino genitivo plural'),
    ScriptureToken(surface: 'παρεγένοντο', transliteration: 'paregenonto', glossPt: 'chegaram / apresentaram-se', lemma: 'παραγίνομαι', morphology: 'aoristo médio do indicativo, 3ª pessoa plural'),
    ScriptureToken(surface: 'εἰς Ἱεροσόλυμα', transliteration: 'eis Hierosolyma', glossPt: 'para Jerusalém', lemma: 'εἰς + Ἱεροσόλυμα', morphology: 'preposição εἰς + nome próprio acusativo plural'),
  ],
);