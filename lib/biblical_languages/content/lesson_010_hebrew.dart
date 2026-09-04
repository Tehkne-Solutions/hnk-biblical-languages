import '../models/biblical_lesson.dart';

const lesson010Hebrew = ScripturePassage(
  id: 'isaiah_40_3_hebrew',
  reference: 'Isaías 40:3',
  language: BiblicalLanguage.biblicalHebrew,
  direction: ScriptDirection.rtl,
  text: 'קוֹל קוֹרֵא בַּמִּדְבָּר פַּנּוּ דֶּרֶךְ יְהוָה יַשְּׁרוּ בָּעֲרָבָה מְסִלָּה לֵאלֹהֵינוּ׃',
  transliteration: 'Qol qore bamidbar: pannu derekh YHWH; yashsheru ba‘aravah mesillah le-Elohenu.',
  literalPt: 'Voz de alguém chamando: “No deserto, preparai o caminho de YHWH; endireitai na estepe uma estrada para nosso Deus”.',
  naturalPt: 'Uma voz clama: “Preparem no deserto o caminho do SENHOR; façam na região árida uma estrada reta para o nosso Deus”.',
  sourceEdition: 'Open Scriptures Hebrew Bible / WLC base text',
  sourceLicense: 'WLC text: Public Domain · OSHB morphology: CC BY 4.0',
  sourceAttribution: 'Open Scriptures Hebrew Bible Project',
  translationNotePt: 'קוֹרֵא é particípio Qal masculino singular. פַּנּוּ e יַשְּׁרוּ são imperativos Piel masculinos plurais. A pontuação/cantillação do Texto Massorético ajuda a ler “no deserto” com a ordem de preparar o caminho; o curso mantém sintaxe e tradição interpretativa em camadas distintas.',
  tokens: [
    ScriptureToken(surface: 'קוֹל', transliteration: 'qol', glossPt: 'voz / som', lemma: 'קוֹל', morphology: 'substantivo masculino singular'),
    ScriptureToken(surface: 'קוֹרֵא', transliteration: 'qore', glossPt: 'clamando / aquele que chama', lemma: 'קרא', morphology: 'Qal particípio masculino singular'),
    ScriptureToken(surface: 'בַּמִּדְבָּר', transliteration: 'bamidbar', glossPt: 'no deserto', lemma: 'ב + מִדְבָּר', morphology: 'preposição ב + artigo + substantivo masculino singular'),
    ScriptureToken(surface: 'פַּנּוּ', transliteration: 'pannu', glossPt: 'preparem / desobstruam', lemma: 'פנה', morphology: 'Piel imperativo masculino plural'),
    ScriptureToken(surface: 'דֶּרֶךְ יְהוָה', transliteration: 'derekh YHWH', glossPt: 'caminho de YHWH', lemma: 'דֶּרֶךְ + יהוה', morphology: 'substantivo comum singular em construto + nome próprio'),
    ScriptureToken(surface: 'יַשְּׁרוּ', transliteration: 'yashsheru', glossPt: 'endireitem / tornem reto', lemma: 'ישר', morphology: 'Piel imperativo masculino plural'),
    ScriptureToken(surface: 'מְסִלָּה', transliteration: 'mesillah', glossPt: 'estrada elevada / caminho', lemma: 'מְסִלָּה', morphology: 'substantivo feminino singular'),
    ScriptureToken(surface: 'לֵאלֹהֵינוּ', transliteration: 'le-Elohenu', glossPt: 'para nosso Deus', lemma: 'ל + אֱלֹהִים', morphology: 'preposição ל + substantivo em forma ligada + sufixo possessivo 1cp'),
  ],
);