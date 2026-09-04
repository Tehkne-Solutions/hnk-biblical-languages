import '../models/biblical_lesson.dart';

const lesson011Genesis27 = ScripturePassage(
  id: 'genesis_2_7_hebrew',
  reference: 'Gênesis 2:7',
  language: BiblicalLanguage.biblicalHebrew,
  direction: ScriptDirection.rtl,
  text: 'וַיִּיצֶר יְהוָה אֱלֹהִים אֶת־הָאָדָם עָפָר מִן־הָאֲדָמָה וַיִּפַּח בְּאַפָּיו נִשְׁמַת חַיִּים וַיְהִי הָאָדָם לְנֶפֶשׁ חַיָּה׃',
  transliteration: 'Vayyitser YHWH Elohim et-ha’adam afar min-ha’adamah, vayyippach be’appav nishmat chayyim; vayehi ha’adam lenefesh chayyah.',
  literalPt: 'E formou YHWH Deus o homem, pó da terra, e soprou em suas narinas respiração de vidas; e o homem veio a ser uma criatura vivente.',
  naturalPt: 'Então o SENHOR Deus formou o homem do pó da terra, soprou em suas narinas o fôlego de vida, e o homem tornou-se um ser vivente.',
  sourceEdition: 'Open Scriptures Hebrew Bible / WLC base text',
  sourceLicense: 'WLC text: Public Domain · OSHB morphology: CC BY 4.0',
  sourceAttribution: 'Open Scriptures Hebrew Bible Project',
  translationNotePt: 'וַיִּיצֶר, וַיִּפַּח e וַיְהִי formam uma sequência narrativa. אָדָם e אֲדָמָה apresentam proximidade sonora/lexical, mas o curso não transforma essa relação em etimologia ou antropologia além do que o texto sustenta.',
  tokens: [
    ScriptureToken(surface: 'וַיִּיצֶר', transliteration: 'vayyitser', glossPt: 'e formou', lemma: 'יצר', morphology: 'Qal consecutivo imperfeito, 3ª pessoa masculina singular'),
    ScriptureToken(surface: 'הָאָדָם', transliteration: 'ha’adam', glossPt: 'o homem / humano', lemma: 'אָדָם', morphology: 'artigo + substantivo masculino singular'),
    ScriptureToken(surface: 'מִן־הָאֲדָמָה', transliteration: 'min-ha’adamah', glossPt: 'da terra / do solo', lemma: 'מן + אֲדָמָה', morphology: 'preposição מן + artigo + substantivo feminino singular'),
    ScriptureToken(surface: 'וַיִּפַּח', transliteration: 'vayyippach', glossPt: 'e soprou', lemma: 'נפח', morphology: 'Qal consecutivo imperfeito, 3ª pessoa masculina singular'),
    ScriptureToken(surface: 'נִשְׁמַת חַיִּים', transliteration: 'nishmat chayyim', glossPt: 'fôlego / respiração de vida', lemma: 'נְשָׁמָה + חַיִּים', morphology: 'substantivo feminino singular construto + substantivo plural'),
    ScriptureToken(surface: 'לְנֶפֶשׁ חַיָּה', transliteration: 'lenefesh chayyah', glossPt: 'em/para criatura vivente', lemma: 'ל + נֶפֶשׁ + חַי', morphology: 'preposição ל + substantivo feminino singular + adjetivo feminino singular'),
  ],
);

const lesson011Genesis39 = ScripturePassage(
  id: 'genesis_3_9_hebrew',
  reference: 'Gênesis 3:9',
  language: BiblicalLanguage.biblicalHebrew,
  direction: ScriptDirection.rtl,
  text: 'וַיִּקְרָא יְהוָה אֱלֹהִים אֶל־הָאָדָם וַיֹּאמֶר לוֹ אַיֶּכָּה׃',
  transliteration: 'Vayyiqra YHWH Elohim el-ha’adam, vayomer lo: ayyekkah?',
  literalPt: 'E chamou YHWH Deus ao homem e disse a ele: “Onde estás tu?”',
  naturalPt: 'O SENHOR Deus chamou o homem e lhe perguntou: “Onde você está?”',
  sourceEdition: 'Open Scriptures Hebrew Bible / WLC base text',
  sourceLicense: 'WLC text: Public Domain · OSHB morphology: CC BY 4.0',
  sourceAttribution: 'Open Scriptures Hebrew Bible Project',
  translationNotePt: 'וַיִּקְרָא e וַיֹּאמֶר são formas narrativas consecutivas. אַיֶּכָּה é interrogativo com referência de 2ms: a morfologia identifica a pergunta “onde estás?”, enquanto sua função literária/teológica é uma etapa interpretativa posterior.',
  tokens: [
    ScriptureToken(surface: 'וַיִּקְרָא', transliteration: 'vayyiqra', glossPt: 'e chamou', lemma: 'קרא', morphology: 'Qal consecutivo imperfeito, 3ª pessoa masculina singular'),
    ScriptureToken(surface: 'וַיֹּאמֶר', transliteration: 'vayomer', glossPt: 'e disse', lemma: 'אמר', morphology: 'Qal consecutivo imperfeito, 3ª pessoa masculina singular'),
    ScriptureToken(surface: 'לוֹ', transliteration: 'lo', glossPt: 'a ele', lemma: 'ל', morphology: 'preposição ל + sufixo pronominal 3ms'),
    ScriptureToken(surface: 'אַיֶּכָּה', transliteration: 'ayyekkah', glossPt: 'onde estás? / onde você está?', lemma: 'אַיֵּה', morphology: 'interrogativo locativo + referência/sufixo 2ms'),
  ],
);