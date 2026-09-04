import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_001_bereshit_en_arche.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_002_identidade.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_003_ser_e_existir.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_004_casa_e_familia.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_005_tempo_e_dias.dart';
import 'package:hnk_biblical_languages/biblical_languages/models/biblical_lesson.dart';

void main() {
  final lessons = [
    lesson001BereshitEnArche,
    lesson002Identidade,
    lesson003SerEExistir,
    lesson004CasaEFamilia,
    lesson005TempoEDias,
  ];

  group('Biblical Languages canonical contracts', () {
    test('every implemented lesson keeps 12 structures x 6 = 72 drills', () {
      for (final lesson in lessons) {
        expect(lesson.patterns, hasLength(12), reason: lesson.id);
        expect(lesson.drills, hasLength(72), reason: lesson.id);

        for (var structure = 1; structure <= 12; structure++) {
          final items = lesson.drills
              .where((item) => item.structure == structure)
              .toList();
          expect(items, hasLength(6), reason: '${lesson.id} structure $structure');
          expect(items.map((item) => item.variant).toSet(), {1, 2, 3, 4, 5, 6});
        }
      }
    });

    test('every pattern exposes Portuguese Esperanto Hebrew and Greek', () {
      const expected = {
        BiblicalLanguage.portuguese,
        BiblicalLanguage.esperanto,
        BiblicalLanguage.biblicalHebrew,
        BiblicalLanguage.koineGreek,
      };

      for (final lesson in lessons) {
        for (final pattern in lesson.patterns) {
          expect(pattern.lines, hasLength(4));
          expect(pattern.lines.map((line) => line.language).toSet(), expected);
        }
      }
    });

    test('every quoted scripture declares provenance', () {
      for (final lesson in lessons) {
        for (final passage in lesson.scriptures) {
          expect(passage.sourceEdition.trim(), isNotEmpty);
          expect(passage.sourceLicense.trim(), isNotEmpty);
          expect(passage.sourceAttribution.trim(), isNotEmpty);
        }
      }
    });

    test('Greek source metadata does not mislabel SBLGNT as CC BY 4.0', () {
      for (final lesson in lessons) {
        final greek = lesson.scriptures
            .where((p) => p.language == BiblicalLanguage.koineGreek);
        expect(greek, isNotEmpty, reason: lesson.id);
        for (final passage in greek) {
          expect(passage.sourceEdition, contains('SBLGNT'));
          expect(passage.sourceLicense, isNot(equals('CC BY 4.0')));
          expect(passage.sourceLicense, contains('SBLGNT'));
        }
      }
    });

    test('Hebrew source passages render RTL', () {
      for (final lesson in lessons) {
        final hebrew = lesson.scriptures
            .where((p) => p.language == BiblicalLanguage.biblicalHebrew);
        expect(hebrew, isNotEmpty);
        for (final passage in hebrew) {
          expect(passage.direction, ScriptDirection.rtl);
        }
      }
    });

    test('Lesson 002 keeps Ehyeh morphology distinct from natural translation', () {
      final exodus = lesson002Scriptures.first;
      final ehyeh = exodus.tokens.firstWhere((t) => t.surface == 'אֶהְיֶה');
      expect(ehyeh.morphology, contains('imperfeito'));
      expect(exodus.naturalPt, contains('EU SOU'));
      expect(exodus.translationNotePt, isNotNull);
    });

    test('Lesson 003 distinguishes jussive from narrative existence', () {
      final genesis = lesson003Scriptures.first;
      final yehi = genesis.tokens.firstWhere((t) => t.surface == 'יְהִי');
      final vayehi = genesis.tokens.firstWhere((t) => t.surface == 'וַיְהִי־');
      expect(yehi.morphology, contains('jussivo'));
      expect(vayehi.morphology, contains('consecutivo'));
    });

    test('Lesson 004 distinguishes Hebrew construct from Greek genitive', () {
      final genesis = lesson004Scriptures.first;
      final luke = lesson004Scriptures.last;

      final houseConstruct =
          genesis.tokens.firstWhere((t) => t.surface == 'וּמִבֵּית');
      final father = genesis.tokens.firstWhere((t) => t.surface == 'אָבִיךָ');
      final greekHouse = luke.tokens.firstWhere((t) => t.surface == 'οἴκου');
      final greekVirgin =
          luke.tokens.firstWhere((t) => t.surface == 'τῆς παρθένου');

      expect(houseConstruct.morphology, contains('construto'));
      expect(father.morphology, contains('sufixo possessivo'));
      expect(greekHouse.morphology, contains('genitivo'));
      expect(greekVirgin.morphology, contains('genitivo'));
      expect(luke.translationNotePt, contains('não é estruturalmente idêntico'));
    });

    test('Lesson 004 anchors Genesis 12:1 and Luke 1:27', () {
      expect(lesson004Scriptures, hasLength(2));
      expect(lesson004Scriptures.first.reference, 'Gênesis 12:1');
      expect(lesson004Scriptures.last.reference, 'Lucas 1:27');
      expect(lesson004Scriptures.first.text, contains('מִבֵּית אָבִיךָ'));
      expect(lesson004Scriptures.last.text, contains('ἐξ οἴκου Δαυίδ'));
      expect(lesson004Scriptures.last.text, contains('τὸ ὄνομα τῆς παρθένου Μαριάμ'));
    });

    test('Lesson 005 preserves day one before natural ordinal translation', () {
      final genesis = lesson005Scriptures.first;
      final dayOne = genesis.tokens.firstWhere((t) => t.surface == 'יוֹם אֶחָד');
      expect(dayOne.morphology, contains('numeral masculino singular'));
      expect(genesis.literalPt, contains('dia um'));
      expect(genesis.naturalPt, contains('primeiro dia'));
      expect(genesis.translationNotePt, contains('cardinal'));
    });

    test('Lesson 005 distinguishes the two Greek perfect forms', () {
      final mark = lesson005Scriptures.last;
      final fulfilled = mark.tokens.firstWhere((t) => t.surface == 'Πεπλήρωται');
      final drawnNear = mark.tokens.firstWhere((t) => t.surface == 'ἤγγικεν');
      final kairos = mark.tokens.firstWhere((t) => t.surface == 'ὁ καιρὸς');

      expect(fulfilled.morphology, contains('perfeito médio/passivo'));
      expect(drawnNear.morphology, contains('perfeito ativo'));
      expect(kairos.glossPt, contains('ocasião'));
      expect(mark.translationNotePt, contains('estado resultante'));
    });

    test('Lesson 005 anchors Genesis 1:5 and Mark 1:15', () {
      expect(lesson005Scriptures, hasLength(2));
      expect(lesson005Scriptures.first.reference, 'Gênesis 1:5');
      expect(lesson005Scriptures.last.reference, 'Marcos 1:15');
      expect(lesson005Scriptures.first.text, contains('וַיְהִי־עֶרֶב'));
      expect(lesson005Scriptures.first.text, contains('יוֹם אֶחָד'));
      expect(lesson005Scriptures.last.text, contains('Πεπλήρωται ὁ καιρὸς'));
      expect(lesson005Scriptures.last.text, contains('ἤγγικεν ἡ βασιλεία'));
    });
  });
}
