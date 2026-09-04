import '../models/biblical_lesson.dart';

const lesson009Hebrew = ScripturePassage(
  id: 'psalm_1_1_hebrew',
  reference: 'Salmo 1:1',
  language: BiblicalLanguage.biblicalHebrew,
  direction: ScriptDirection.rtl,
  text: 'אַשְׁרֵי־הָאִישׁ אֲשֶׁר לֹא הָלַךְ בַּעֲצַת רְשָׁעִים וּבְדֶרֶךְ חַטָּאִים לֹא עָמָד וּבְמוֹשַׁב לֵצִים לֹא יָשָׁב׃',
  transliteration: 'Ashrei-ha’ish asher lo halakh ba’atsat resha‘im, uvederekh chatta’im lo amad, uvemoshav letsim lo yashav.',
  literalPt: 'Feliz o homem que não andou no conselho de perversos, e no caminho de pecadores não ficou de pé, e no assento de zombadores não se assentou.',
  naturalPt: 'Feliz é aquele que não segue o conselho dos perversos, não permanece no caminho dos pecadores e não se assenta entre zombadores.',
  sourceEdition: 'Open Scriptures Hebrew Bible / WLC base text',
  sourceLicense: 'WLC text: Public Domain · OSHB morphology: CC BY 4.0',
  sourceAttribution: 'Open Scriptures Hebrew Bible Project',
  translationNotePt: 'O verso organiza três cláusulas negativas paralelas: לֹא הָלַךְ, לֹא עָמָד, לֹא יָשָׁב. As formas verbais são analisadas antes de qualquer leitura homilética de uma suposta progressão moral entre andar, parar e sentar.',
  tokens: [
    ScriptureToken(surface: 'אַשְׁרֵי־', transliteration: 'ashrei', glossPt: 'feliz / bem-aventurado', lemma: 'אֶשֶׁר', morphology: 'fórmula/interjeição de felicidade'),
    ScriptureToken(surface: 'לֹא הָלַךְ', transliteration: 'lo halakh', glossPt: 'não andou', lemma: 'לא + הלך', morphology: 'partícula negativa + Qal perfeito 3ms'),
    ScriptureToken(surface: 'בַּעֲצַת', transliteration: 'ba’atsat', glossPt: 'no conselho de', lemma: 'ב + עֵצָה', morphology: 'preposição ב + substantivo feminino singular construto'),
    ScriptureToken(surface: 'לֹא עָמָד', transliteration: 'lo amad', glossPt: 'não ficou de pé / não permaneceu', lemma: 'לא + עמד', morphology: 'partícula negativa + Qal perfeito 3ms'),
    ScriptureToken(surface: 'בְדֶרֶךְ חַטָּאִים', transliteration: 'vederekh chatta’im', glossPt: 'no caminho de pecadores', lemma: 'דֶּרֶךְ + חַטָּא', morphology: 'substantivo em relação construta + plural'),
    ScriptureToken(surface: 'לֹא יָשָׁב', transliteration: 'lo yashav', glossPt: 'não se assentou', lemma: 'לא + ישב', morphology: 'partícula negativa + Qal perfeito 3ms'),
  ],
);