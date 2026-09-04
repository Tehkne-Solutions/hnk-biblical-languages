import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_002_identidade.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_003_ser_e_existir.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_004_casa_e_familia.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_005_tempo_e_dias.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_006_corpo_e_acoes.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_007_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_007_hebrew.dart';
import 'package:hnk_biblical_languages/biblical_languages/models/biblical_lesson.dart';

void main() {
  final lessons = implementedBiblicalLessons;

  group('Biblical Languages canonical contracts', () {
    test('registry exposes seven sequential lessons', () {
      expect(lessons, hasLength(7));
      expect(lessons.map((l) => l.number).toList(), [1, 2, 3, 4, 5, 6, 7]);
      expect(biblicalLessonByNumber(7)?.id, 'biblical_lesson_007');
      expect(biblicalLessonByNumber(8), isNull);
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

    test('all source passages expose provenance and Hebrew renders RTL', () {
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
      final t = p.tokens.firstWhere((x) => x.surface == 'אֶהְיֶה');
      expect(t.morphology, contains('imperfeito'));
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
      expect(gr.translationNotePt, contains('não é estruturalmente idêntico'));
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
      expect(gr.translationNotePt, contains('não força correspondência'));
    });

    test('Lesson 007 distinguishes jussive command from realization', () {
      final call = lesson007Hebrew.tokens.firstWhere((x) => x.surface == 'תַּדְשֵׁא');
      final result = lesson007Hebrew.tokens.firstWhere((x) => x.surface == 'וַתּוֹצֵא');
      expect(call.morphology, contains('jussivo'));
      expect(result.morphology, contains('consecutivo'));
      expect(lesson007Hebrew.translationNotePt, contains('realização narrativa'));
    });

    test('Lesson 007 preserves John aspect and lexical ambiguity', () {
      expect(lesson007Greek.reference, 'João 1:3–5');
      expect(lesson007Greek.tokens.firstWhere((x) => x.surface == 'γέγονεν').morphology, contains('perfeito ativo'));
      expect(lesson007Greek.tokens.firstWhere((x) => x.surface == 'φαίνει').morphology, contains('presente ativo'));
      expect(lesson007Greek.tokens.firstWhere((x) => x.surface == 'κατέλαβεν').morphology, contains('aoristo ativo'));
      expect(lesson007Greek.translationNotePt, contains('apreender'));
      expect(lesson007Greek.translationNotePt, contains('conclusão exegética'));
    });
  });
}
