import '../models/biblical_lesson.dart';
import 'drill_factory.dart';

const _hebrewEdition = 'Open Scriptures Hebrew Bible / WLC base text';
const _hebrewLicense = 'WLC text: Public Domain · OSHB morphology: CC BY 4.0';
const _hebrewAttribution = 'Open Scriptures Hebrew Bible Project';
const _greekEdition = 'SBL Greek New Testament (SBLGNT) v1.2';
const _greekLicense =
    'SBLGNT electronic text: published SBLGNT EULA · MorphGNT parsing: CC BY-SA';
const _greekAttribution =
    'SBL Greek New Testament, ed. Michael W. Holmes · MorphGNT SBLGNT Edition, ed. James Tauber.';

const List<ScripturePassage> lesson007Scriptures = [
  ScripturePassage(
    id: 'genesis_1_11_12_hebrew',
    reference: 'Gênesis 1:11–12',
    language: BiblicalLanguage.biblicalHebrew,
    direction: ScriptDirection.rtl,
    text:
        'וַיֹּאמֶר אֱלֹהִים תַּדְשֵׁא הָאָרֶץ דֶּשֶׁא עֵשֶׂב מַזְרִיעַ זֶרַע עֵץ פְּרִי עֹשֶׂה פְּרִי לְמִינוֹ אֲשֶׁר זַרְעוֹ־בוֹ עַל־הָאָרֶץ וַיְהִי־כֵן׃ וַתּוֹצֵא הָאָרֶץ דֶּשֶׁא עֵשֶׂב מַזְרִיעַ זֶרַע לְמִינֵהוּ וְעֵץ עֹשֶׂה־פְּרִי אֲשֶׁר זַרְעוֹ־בוֹ לְמִינֵהוּ וַיַּרְא אֱלֹהִים כִּי־טוֹב׃',
    transliteration:
        'Vayomer Elohim: tadshê ha’aretz deshe, esev mazria zera, etz peri oseh peri lemino asher zar‘o-vo al-ha’aretz; vayehi-khen. Vattotse ha’aretz deshe, esev mazria zera leminehu, ve’etz oseh-peri asher zar‘o-vo leminehu; vayar Elohim ki-tov.',
    literalPt:
        'E disse Deus: “Que a terra faça brotar vegetação, planta fazendo produzir semente, árvore de fruto fazendo fruto segundo a sua espécie, cuja semente está nela, sobre a terra”; e assim foi. E a terra fez sair vegetação, planta fazendo produzir semente segundo a sua espécie, e árvore fazendo fruto cuja semente está nela segundo a sua espécie; e Deus viu que era bom.',
    naturalPt:
        'Deus disse: “Que a terra produza vegetação: plantas que deem sementes e árvores frutíferas que deem fruto com sementes, cada uma segundo a sua espécie”. E assim aconteceu. A terra produziu vegetação, plantas com sementes e árvores com frutos e sementes, cada uma segundo a sua espécie. E Deus viu que era bom.',
    sourceEdition: _hebrewEdition,
    sourceLicense: _hebrewLicense,
    sourceAttribution: _hebrewAttribution,
    translationNotePt:
        'תַּדְשֵׁא é Hifil imperfeito jussivo 3fs: a terra é convocada a fazer brotar. וַתּוֹצֵא é Hifil consecutivo imperfeito 3fs e narra a realização. O contraste pedagógico é forma volitiva → realização narrativa, sem reduzir o sistema verbal hebraico a uma linha temporal simples.',
    tokens: [
      ScriptureToken(
        surface: 'תַּדְשֵׁא',
        transliteration: 'tadshê',
        glossPt: 'que faça brotar / que produza vegetação',
        lemma: 'דשא',
        morphology: 'Hifil imperfeito jussivo, 3ª pessoa feminina singular',
      ),
      ScriptureToken(
        surface: 'הָאָרֶץ',
        transliteration: 'ha’aretz',
        glossPt: 'a terra',
        lemma: 'אֶרֶץ',
        morphology: 'artigo definido + substantivo feminino singular',
      ),
      ScriptureToken(
        surface: 'דֶּשֶׁא',
        transliteration: 'deshe',
        glossPt: 'vegetação / broto verde',
        lemma: 'דֶּשֶׁא',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'עֵשֶׂב',
        transliteration: 'esev',
        glossPt: 'planta / erva',
        lemma: 'עֵשֶׂב',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'מַזְרִיעַ',
        transliteration: 'mazria',
        glossPt: 'fazendo produzir / portando semente',
        lemma: 'זרע',
        morphology: 'Hifil particípio masculino singular',
      ),
      ScriptureToken(
        surface: 'זֶרַע',
        transliteration: 'zera',
        glossPt: 'semente',
        lemma: 'זֶרַע',
        morphology: 'substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'עֵץ פְּרִי',
        transliteration: 'etz peri',
        glossPt: 'árvore de fruto / árvore frutífera',
        lemma: 'עֵץ + פְּרִי',
        morphology: 'substantivo masculino singular em construto + substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'עֹשֶׂה פְּרִי',
        transliteration: 'oseh peri',
        glossPt: 'fazendo / produzindo fruto',
        lemma: 'עשה + פְּרִי',
        morphology: 'Qal particípio masculino singular + substantivo masculino singular',
      ),
      ScriptureToken(
        surface: 'לְמִינוֹ',
        transliteration: 'lemino',
        glossPt: 'segundo a sua espécie',
        lemma: 'לְ + מִין',
        morphology: 'preposição ל + substantivo masculino singular + sufixo possessivo 3ms',
      ),
      ScriptureToken(
        surface: 'וַיְהִי־כֵן',
        transliteration: 'vayehi-khen',
        glossPt: 'e assim foi / e assim aconteceu',
        lemma: 'היה + כֵּן',
        morphology: 'Qal consecutivo imperfeito 3ms + advérbio',
      ),
      ScriptureToken(
        surface: 'וַתּוֹצֵא',
        transliteration: 'vattotse',
        glossPt: 'e fez sair / e produziu',
        lemma: 'יצא',
        morphology: 'Hifil consecutivo imperfeito, 3ª pessoa feminina singular',
      ),
      ScriptureToken(
        surface: 'כִּי־טוֹב',
        transliteration: 'ki-tov',
        glossPt: 'que era bom / pois bom',
        lemma: 'כִּי + טוֹב',
        morphology: 'conjunção כִּי + adjetivo masculino singular',
      ),
    ],
  ),
  ScripturePassage(
    id: 'john_1_3_5_greek',
    reference: 'João 1:3–5',
    language: BiblicalLanguage.koineGreek,
    text:
        'πάντα δι’ αὐτοῦ ἐγένετο, καὶ χωρὶς αὐτοῦ ἐγένετο οὐδὲ ἕν. ὃ γέγονεν ἐν αὐτῷ ζωὴ ἦν, καὶ