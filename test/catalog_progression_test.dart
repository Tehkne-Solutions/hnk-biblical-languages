import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_map.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/biblical_languages_catalog_screen.dart';

BiblicalProgressSnapshot _completedThrough(int n) {
  var p = const BiblicalProgressSnapshot();
  for (var i = 1; i <= n; i++) {
    p = p.completeLesson(
      biblicalLessonId(i),
      timestamp: DateTime.utc(2026, 9, 4),
    );
  }
  return p;
}

Future<void> _pump(WidgetTester tester, BiblicalProgressSnapshot p) async {
  await tester.pumpWidget(
    MaterialApp(
      home: BiblicalLanguagesCatalogScreen(
        progressStore: MemoryBiblicalProgressStore(p),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _scrollTo(WidgetTester tester, String title) async {
  await tester.scrollUntilVisible(
    find.text(title),
    360,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  for (var number = 2; number <= implementedBiblicalLessons.length; number++) {
    final level = biblicalLanguagesCourseMap[number - 1];
    final lesson = biblicalLessonByNumber(number)!;

    testWidgets('Lesson $number unlocks after previous lessons', (tester) async {
      await _pump(tester, _completedThrough(number - 1));
      await _scrollTo(tester, level.title);
      await tester.tap(find.text(level.title));
      await tester.pumpAndSettle();

      if (lesson.readingPlan.isNotEmpty) {
        expect(
          find.text('Lesson ${number.toString().padLeft(3, '0')} · Plano'),
          findsOneWidget,
        );
        for (final stage in lesson.readingPlan) {
          expect(find.text(stage.title), findsOneWidget);
        }
        final startLabel = number == 12 ? 'INICIAR ANÁLISE' : 'INICIAR LEITURA';
        await tester.tap(find.text(startLabel));
        await tester.pumpAndSettle();
      }

      expect(find.text(lesson.title), findsOneWidget);
      expect(
        find.textContaining(lesson.subtitle.split(' · ').first),
        findsWidgets,
      );
    });

    testWidgets('Lesson $number stays locked without previous lesson', (tester) async {
      await _pump(tester, _completedThrough(number - 2));
      await _scrollTo(tester, level.title);
      await tester.tap(find.text(level.title));
      await tester.pumpAndSettle();
      expect(find.text(lesson.title), findsNothing);
      expect(
        find.text('Lesson ${number.toString().padLeft(3, '0')} · Plano'),
        findsNothing,
      );
    });
  }
}
