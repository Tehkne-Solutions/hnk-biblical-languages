import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_002_identidade.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_003_ser_e_existir.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_004_casa_e_familia.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_005_tempo_e_dias.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_006_corpo_e_acoes.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_007_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_007_hebrew.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_008_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_008_hebrew.dart';
import 'package:hnk_biblical_languages/biblical_languages/models/biblical_lesson.dart';

void main() {
  final lessons = implementedBiblicalLessons;

  group('Biblical Languages canonical contracts', () {
    test('registry is sequential and lookup follows its size', () {
      expect(lessons.map((l) => l.number).toList(), List.generate(lessons.length, (i) => i + 1));
      expect(biblicalLessonByNumber(lessons.length)?.id, biblicalLessonId(lessons.length));
      expect(biblicalLessonByNumber(lessons.length + 1), isNull);
    });

    test('every lesson keeps 12 structures x 6 = 72 drills', () {
      for (final lesson in lessons) {
        expect(lesson.patterns, hasLength(12), reason: lesson.id);
        expect(lesson.drills, hasLength(72), reason: lesson.id);
        for (var s = 1; s <= 12; s++) {
          final items = lesson.drills.where((d) => d.structure == s).toList();
          expect(items, hasLength(6), reason: '${lesson.id} structure $s');
          expect(items.map((d) => d.variant).toSet(), {1, 2, 3, 4, 5, 6});
        }
      }
    });

    test('every pattern exposes all four language layers', () {
      const expected = {
        BiblicalLanguage.portuguese,
        BiblicalLanguage.esperanto,
        BiblicalLanguage.biblicalHebrew,
        BiblicalLanguage.koineGreek,
      };
      for (final lesson in lessons) {
        for (final pattern in lesson.patterns) {
          expect(pattern.lines, hasLength(4));
          expect(pattern.lines.map((l) => l.language).toSet(), expected);
        }
      }
    });

    test('all passages expose provenance and Hebrew renders RTL', () {
      for (final lesson in lessons) {
        for (final passage in lesson.scriptures) {
          expect(passage.sourceEdition.trim(), isNotEmpty);
          expect(passage.sourceLicense.trim(), isNotEmpty);
          expect(passage.sourceAttribution.trim(), isNotEmpty);
          if (passage.language == BiblicalLanguage.biblicalHebrew) {
            expect(passage.direction, ScriptDirection.rtl);
          }
          if (passage.language == BiblicalLanguage.koineGreek) {
            expect(passage.sourceEdition, contains('SBLGNT'));
            expect(passage.sourceLicense, isNot(equals('CC BY 4.0')));
          }
        }
      }
    });

    test('Lesson 002 keeps Ehyeh morphology distinct from translation', () {
      final p = lesson002Scriptures.first;
      expect(p.tokens.firstWhere((x) => x.surface == 'אֶהְיֶה').morphology, contains('imperfeito'));
      expect(p.naturalPt, contains('EU SOU'));
    });

    test('Lesson 003 distinguishes jussive from narrative existence', () {
      final p = lesson003Scriptures.first;
      expect(p.tokens.firstWhere((x) => x.surface == 'יְהִי').morphology, contains('jussivo'));
      expect(p.tokens.firstWhere((x) => x.surface == 'וַיְהִי־').morphology, contains('consecutivo'));
    });

    test('Lesson 004 preserves construct and Greek genitive distinction', () {
      final he = lesson004Scriptures.first;
      final gr = lesson004Scriptures.last;
      expect(he.tokens.firstWhere((x) => x.surface == 'וּמִבֵּית').morphology, contains('construto'));
      expect(gr.tokens.firstWhere((x) => x.surface == 'οἴκου').morphology, contains('genitivo'));
    });

    test('Lesson 005 preserves day one and Greek perfect forms', () {
      final he = lesson005Scriptures.first;
      final gr = lesson005Scriptures.last;
      expect(he.literalPt, contains('dia um'));
      expect(he.naturalPt, contains('primeiro dia'));
      expect(gr.tokens.firstWhere((x) => x.surface == 'Πεπλήρωται').morphology, contains('perfeito médio/passivo'));
      expect(gr.tokens.firstWhere((x) => x.surface == 'ἤγγικεν').morphology, contains('perfeito ativo'));
    });

    test('Lesson 006 separates morphology from command function', () {
      final he = lesson006Scriptures.first;
      final gr = lesson006Scriptures.last;
      expect(he.tokens.firstWhere((x) => x.surface == 'וְאָהַבְתָּ').morphology, contains('Qal perfeito'));
      expect(gr.tokens.firstWhere((x) => x.surface == 'ἀγαπήσεις').morphology, contains('futuro ativo do indicativo'));
    });

    test('Lesson 007 distinguishes jussive command from realization', () {
      expect(lesson007Hebrew.tokens.firstWhere((x) => x.surface == 'תַּדְשֵׁא').morphology, contains('jussivo'));
      expect(lesson007Hebrew.tokens.firstWhere((x) => x.surface == 'וַתּוֹצֵא').morphology, contains('consecutivo'));
      expect(lesson007Greek.tokens.firstWhere((x) => x.surface == 'γέγονεν').morphology, contains('perfeito ativo'));
      expect(lesson007Greek.tokens.firstWhere((x) => x.surface == 'φαίνει').morphology, contains('presente ativo'));
      expect(lesson007Greek.tokens.firstWhere((x) => x.surface == 'κατέλαβεν').morphology, contains('aoristo ativo'));
      expect(lesson007Greek.translationNotePt, contains('conclusão exegética'));
    });

    test('Lesson 008 preserves political request morphology', () {
      final appoint = lesson008Hebrew.tokens.firstWhere((x) => x.surface == 'שִׂימָה־לָּנוּ');
      final judge = lesson008Hebrew.tokens.firstWhere((x) => x.surface == 'לְשָׁפְטֵנוּ');
      final nations = lesson008Hebrew.tokens.firstWhere((x) => x.surface == 'הַגּוֹיִם');
      expect(appoint.morphology, contains('imperativo 2ms'));
      expect(judge.morphology, contains('infinitivo construto'));
      expect(nations.morphology, contains('plural'));
      expect(lesson008Hebrew.translationNotePt, contains('morfologia vem antes'));
    });

    test('Lesson 008 maps Greek origin destination and title', () {
      final born = lesson008Greek.tokens.firstWhere((x) => x.surface == 'γεννηθέντος');
      final king = lesson008Greek.tokens.firstWhere((x) => x.surface == 'τοῦ βασιλέως');
      final origin = lesson008Greek.tokens.firstWhere((x) => x.surface == 'ἀπὸ ἀνατολῶν');
      final arrival = lesson008Greek.tokens.firstWhere((x) => x.surface == 'παρεγένοντο');
      final destination = lesson008Greek.tokens.firstWhere((x) => x.surface == 'εἰς Ἱεροσόλυμα');
      expect(born.morphology, contains('particípio aoristo passivo'));
      expect(king.morphology, contains('genitivo'));
      expect(origin.glossPt, contains('oriente'));
      expect(arrival.morphology, contains('aoristo médio'));
      expect(destination.glossPt, contains('Jerusalém'));
    });
  });
}
