import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_001_bereshit_en_arche.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_002_identidade.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_009_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_009_hebrew.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_012_exegese_integrada.dart';

void main() {
  group('Lesson 012 · Exegese Linguística Integrada', () {
    test('completes the 12-level map with 864 drills', () {
      expect(implementedBiblicalLessons, hasLength(12));
      expect(
        implementedBiblicalLessons.map((lesson) => lesson.number).toList(),
        List.generate(12, (index) => index + 1),
      );
      expect(
        implementedBiblicalLessons.fold<int>(
          0,
          (total, lesson) => total + lesson.drills.length,
        ),
        864,
      );
      expect(biblicalLessonByNumber(12), same(lesson012ExegeseIntegrada));
      expect(biblicalLessonByNumber(13), isNull);
    });

    test('reuses audited canonical passages instead of duplicating text', () {
      expect(lesson012ExegeseIntegrada.scriptures, hasLength(5));
      expect(
        lesson012ExegeseIntegrada.scriptures.map((p) => p.id).toList(),
        [
          'genesis_1_1_hebrew',
          'exodus_3_14_hebrew',
          'psalm_1_1_hebrew',
          'john_1_1_greek',
          'matthew_5_17_greek',
        ],
      );
      expect(
        identical(
          lesson012ExegeseIntegrada.scriptures[0],
          lesson001Scriptures.first,
        ),
        isTrue,
      );
      expect(
        identical(
          lesson012ExegeseIntegrada.scriptures[1],
          lesson002Scriptures.first,
        ),
        isTrue,
      );
      expect(
        identical(lesson012ExegeseIntegrada.scriptures[2], lesson009Hebrew),
        isTrue,
      );
      expect(
        identical(
          lesson012ExegeseIntegrada.scriptures[3],
          lesson001Scriptures.last,
        ),
        isTrue,
      );
      expect(
        identical(lesson012ExegeseIntegrada.scriptures[4], lesson009Greek),
        isTrue,
      );
    });

    test('exegesis protocol has seven ordered gates', () {
      final plan = lesson012ExegeseIntegrada.readingPlan;
      expect(plan, hasLength(7));
      expect(
        plan.map((stage) => stage.title).toList(),
        [
          'SOURCE',
          'MORPHOLOGY',
          'SYNTAX',
          'SEMANTICS',
          'TRANSLATION',
          'INFERENCE',
          'LIMIT',
        ],
      );
      expect(plan.first.codexAllowed, isFalse);
      expect(plan.first.showPortuguese, isFalse);
      expect(plan[1].codexAllowed, isTrue);
      expect(plan[4].showPortuguese, isTrue);
      expect(plan.last.instructionPt, contains('não consegue provar sozinha'));
    });

    test('twelve structures end in an explicit interpretive limit', () {
      expect(lesson012ExegeseIntegrada.patterns, hasLength(12));
      expect(lesson012ExegeseIntegrada.drills, hasLength(72));
      expect(
        lesson012ExegeseIntegrada.patterns.first.title,
        contains('TEXTO-FONTE'),
      );
      expect(
        lesson012ExegeseIntegrada.patterns.last.title,
        contains('LIMITE INTERPRETATIVO'),
      );
      expect(
        lesson012ExegeseIntegrada.patterns.last.explanationPt,
        contains('prova automática'),
      );
    });

    test('final quest preserves morphology before theology', () {
      final exodus = lesson002Scriptures.first;
      final ehyeh = exodus.tokens.firstWhere((t) => t.surface == 'אֶהְיֶה');
      expect(ehyeh.morphology, contains('Qal imperfeito'));
      expect(exodus.naturalPt, contains('EU SOU'));
      expect(
        lesson012ExegeseIntegrada.challenge.answer,
        contains('Qal imperfeito 1cs'),
      );
      expect(
        lesson012ExegeseIntegrada.challenge.answer,
        contains('ὁ λόγος funciona como sujeito'),
      );
      expect(
        lesson012ExegeseIntegrada.challenge.answer,
        contains('além do parsing isolado'),
      );
    });
  });
}
