import '../models/biblical_lesson.dart';

const lesson007Hebrew = ScripturePassage(
  id: 'genesis_1_11_12_hebrew',
  reference: 'Gênesis 1:11–12',
  language: BiblicalLanguage.biblicalHebrew,
  direction: ScriptDirection.rtl,
  text: 'וַיֹּאמֶר אֱלֹהִים תַּדְשֵׁא הָאָרֶץ דֶּשֶׁא עֵשֶׂב מַזְרִיעַ זֶרַע עֵץ פְּרִי עֹשֶׂה פְּרִי לְמִינוֹ אֲשֶׁר זַרְעוֹ־בוֹ עַל־הָאָרֶץ וַיְהִי־כֵן׃ וַתּוֹצֵא הָאָרֶץ דֶּשֶׁא עֵשֶׂב מַזְרִיעַ זֶרַע לְמִינֵהוּ וְעֵץ עֹשֶׂה־פְּרִי אֲשֶׁר זַרְעוֹ־בוֹ לְמִינֵהוּ וַיַּרְא אֱלֹהִים כִּי־טוֹב׃',
  transliteration: 'Vayomer Elohim: tadshê ha’aretz ... vayehi-khen. Vattotse ha’aretz ... vayar Elohim ki-tov.',
  literalPt: 'E Deus disse: “Que a terra faça brotar vegetação, planta produzindo semente e árvore de fruto fazendo fruto segundo a sua espécie”; e assim foi. E a terra fez sair vegetação, e Deus viu que era bom.',
  naturalPt: 'Deus disse: “Que a terra produza vegetação, plantas com sementes e árvores frutíferas, cada uma segundo a sua espécie”. E assim aconteceu; a terra produziu, e Deus viu que era bom.',
  sourceEdition: 'Open Scriptures Hebrew Bible / WLC base text',
  sourceLicense: 'WLC text: Public Domain · OSHB morphology: CC BY 4.0',
  sourceAttribution: 'Open Scriptures Hebrew Bible Project',
  translationNotePt: 'תַּדְשֵׁא é Hifil imperfeito jussivo 3fs; וַתּוֹצֵא é Hifil consecutivo imperfeito 3fs. O curso contrasta convocação volitiva e realização narrativa sem reduzir o sistema verbal hebraico a uma linha temporal simples.',
  tokens: [
    ScriptureToken(surface: 'תַּדְשֵׁא', transliteration: 'tadshê', glossPt: 'que faça brotar', lemma: 'דשא', morphology: 'Hifil imperfeito jussivo, 3ª pessoa feminina singular'),
    ScriptureToken(surface: 'הָאָרֶץ', transliteration: 'ha’aretz', glossPt: 'a terra', lemma: 'אֶרֶץ', morphology: 'artigo + substantivo feminino singular'),
    ScriptureToken(surface: 'מַזְרִיעַ', transliteration: 'mazria', glossPt: 'produzindo semente', lemma: 'זרע', morphology: 'Hifil particípio masculino singular'),
    ScriptureToken(surface: 'וַתּוֹצֵא', transliteration: 'vattotse', glossPt: 'e produziu', lemma: 'יצא', morphology: 'Hifil consecutivo imperfeito, 3ª pessoa feminina singular'),
  ],
);