import '../models/biblical_lesson.dart';

const lesson008Hebrew = ScripturePassage(
  id: 'first_samuel_8_5_hebrew',
  reference: '1 Samuel 8:5',
  language: BiblicalLanguage.biblicalHebrew,
  direction: ScriptDirection.rtl,
  text: 'וַיֹּאמְרוּ אֵלָיו הִנֵּה אַתָּה זָקַנְתָּ וּבָנֶיךָ לֹא הָלְכוּ בִּדְרָכֶיךָ עַתָּה שִׂימָה־לָּנוּ מֶלֶךְ לְשָׁפְטֵנוּ כְּכָל־הַגּוֹיִם׃',
  transliteration: 'Vayomeru elav ... attah simah-lanu melekh leshofetenu kekhol-haggoyim.',
  literalPt: 'E disseram a ele: “Eis que tu envelheceste e teus filhos não andaram em teus caminhos. Agora, estabelece para nós um rei para nos julgar, como todas as nações”.',
  naturalPt: 'Eles lhe disseram: “Tu já envelheceste, e teus filhos não seguem teus caminhos. Agora, estabelece para nós um rei que nos governe, como acontece com todas as outras nações”.',
  sourceEdition: 'Open Scriptures Hebrew Bible / WLC base text',
  sourceLicense: 'WLC text: Public Domain · OSHB morphology: CC BY 4.0',
  sourceAttribution: 'Open Scriptures Hebrew Bible Project',
  translationNotePt: 'שִׂימָה é imperativo Qal 2ms de שׂים. לְשָׁפְטֵנוּ é preposição ל + infinitivo construto Qal de שׁפט + sufixo 1cp. O gloss “julgar” pode incluir função governamental no contexto, mas a morfologia vem antes da interpretação política.',
  tokens: [
    ScriptureToken(surface: 'שִׂימָה־לָּנוּ', transliteration: 'simah-lanu', glossPt: 'estabelece para nós', lemma: 'שׂים + ל', morphology: 'Qal imperativo 2ms + preposição ל + sufixo 1cp'),
    ScriptureToken(surface: 'מֶלֶךְ', transliteration: 'melekh', glossPt: 'rei', lemma: 'מֶלֶךְ', morphology: 'substantivo masculino singular'),
    ScriptureToken(surface: 'לְשָׁפְטֵנוּ', transliteration: 'leshofetenu', glossPt: 'para nos julgar / governar', lemma: 'שׁפט', morphology: 'preposição ל + Qal infinitivo construto + sufixo objeto 1cp'),
    ScriptureToken(surface: 'כְּכָל־', transliteration: 'kekhol', glossPt: 'como todo / como todos', lemma: 'כ + כֹּל', morphology: 'preposição כ + substantivo em construto'),
    ScriptureToken(surface: 'הַגּוֹיִם', transliteration: 'haggoyim', glossPt: 'as nações', lemma: 'גּוֹי', morphology: 'artigo + substantivo masculino plural'),
  ],
);