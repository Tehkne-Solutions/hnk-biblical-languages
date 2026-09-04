import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/drill_practice_factory.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/drill_practice_screen.dart';

void main() {
  test('practice factory derives canonical multiple-choice question', () {
    final lesson = implementedBiblicalLessons.first;
    final drill = lesson.drills.first;
    final question = buildDrillPracticeQuestion(lesson: lesson, drill: drill);

    expect(question.drillId, drill.id);
    expect(question.options, contains(question.correctAnswer));
    expect(question.options.toSet(), hasLength(question.options.length));
    expect(question.options.length, greaterThanOrEqualTo(2));
    expect(question.cueText, isNotEmpty);
  });

  test('due review queue contains wrong answers and is ordered by due date', () {
    final lesson = implementedBiblicalLessons.first;
    final at = DateTime.utc(2026, 9, 4, 12);
    var progress = const BiblicalProgressSnapshot().recordDrillResult(
      lessonId: lesson.id,
      drillId: lesson.drills[1].id,
      zeroBasedIndex: 1,
      correct: false,
      timestamp: at.add(const Duration(minutes: 5)),
    );
    progress = progress.recordDrillResult(
      lessonId: lesson.id,
      drillId: lesson.drills[0].id,
      zeroBasedIndex: 0,
      correct: false,
      timestamp: at,
    );

    final queue = buildDueReviewQueue(
      progress,
      now: at.add(const Duration(minutes: 10)),
    );

    expect(queue, hasLength(2));
    expect(queue.first.drill.id, lesson.drills[0].id);
    expect(queue.last.drill.id, lesson.drills[1].id);
  });

  testWidgets('wrong answer stays put; retry correct awards xp and advances',
      (tester) async {
    final lesson = implementedBiblicalLessons.first;
    final question = buildDrillPracticeQuestion(
      lesson: lesson,
      drill: lesson.drills.first,
    );
    final wrong = question.options.firstWhere(
      (option) => option != question.correctAnswer,
    );
    final store = MemoryBiblicalProgressStore();

    await tester.pumpWidget(
      MaterialApp(
        home: DrillPracticeScreen(
          lesson: lesson,
          initialIndex: 0,
          progressStore: store,
          initialProgress: store.snapshot,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(question.cueText), findsOneWidget);
    await tester.tap(find.text(wrong));
    await tester.pumpAndSettle();

    expect(find.text('REVISÃO AGENDADA'), findsOneWidget);
    expect(store.snapshot.xp, 0);
    expect(store.snapshot.drillPositionFor(lesson.id), 0);
    expect(store.snapshot.isReviewDue(lesson.drills.first.id), isTrue);

    await tester.tap(find.text('TENTAR DE NOVO'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(question.correctAnswer));
    await tester.pumpAndSettle();

    expect(find.text('CORRETO · +10 XP'), findsOneWidget);
    expect(store.snapshot.xp, 10);
    expect(store.snapshot.drillPositionFor(lesson.id), 1);
    expect(store.snapshot.masteryFor(lesson.drills.first.id), 1);
  });
}
