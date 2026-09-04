import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/daily_session_factory.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/drill_practice_factory.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/daily_session_screen.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/drill_mode_screen.dart';

void main() {
  test('daily plan contains exactly twelve new items for a new learner', () {
    final plan = buildDailySessionPlan(const BiblicalProgressSnapshot());

    expect(plan.items, hasLength(12));
    expect(plan.reviewCount, 0);
    expect(plan.newCount, 12);
    expect(plan.reinforcementCount, 0);
    expect(plan.items.every((item) => item.lesson.number == 1), isTrue);
    expect(
      plan.items.map((item) => item.zeroBasedIndex).toList(),
      List<int>.generate(12, (index) => index),
    );
  });

  test('due reviews come before new content from the active unlocked lesson', () {
    final at = DateTime.utc(2026, 9, 4, 12);
    final lesson1 = implementedBiblicalLessons[0];
    var progress = const BiblicalProgressSnapshot().completeLesson(
      lesson1.id,
      timestamp: at,
    );
    progress = progress.recordDrillResult(
      lessonId: lesson1.id,
      drillId: lesson1.drills[1].id,
      zeroBasedIndex: 1,
      correct: false,
      timestamp: at,
    );
    progress = progress.recordDrillResult(
      lessonId: lesson1.id,
      drillId: lesson1.drills[0].id,
      zeroBasedIndex: 0,
      correct: false,
      timestamp: at.subtract(const Duration(minutes: 1)),
    );

    final plan = buildDailySessionPlan(progress, now: at);

    expect(plan.items, hasLength(12));
    expect(plan.reviewCount, 2);
    expect(plan.items[0].kind, DailySessionItemKind.review);
    expect(plan.items[0].drill.id, lesson1.drills[0].id);
    expect(plan.items[1].kind, DailySessionItemKind.review);
    expect(plan.items[1].drill.id, lesson1.drills[1].id);
    expect(
      plan.items.skip(2).every(
            (item) =>
                item.kind == DailySessionItemKind.newContent &&
                item.lesson.number == 2,
          ),
      isTrue,
    );
  });

  test('daily plan never pulls content from a locked future lesson', () {
    final plan = buildDailySessionPlan(const BiblicalProgressSnapshot());
    expect(plan.items.every((item) => item.lesson.number == 1), isTrue);
  });

  test('completed course falls back to lowest-mastery reinforcement', () {
    var progress = const BiblicalProgressSnapshot();
    for (final lesson in implementedBiblicalLessons) {
      progress = progress.completeLesson(lesson.id);
    }

    final plan = buildDailySessionPlan(progress);

    expect(plan.items, hasLength(12));
    expect(plan.reviewCount, 0);
    expect(plan.newCount, 0);
    expect(plan.reinforcementCount, 12);
    expect(
      plan.items.every((item) => item.kind == DailySessionItemKind.reinforcement),
      isTrue,
    );
  });

  testWidgets('daily session awards xp records history and shows summary',
      (tester) async {
    final store = MemoryBiblicalProgressStore();
    final plan = buildDailySessionPlan(store.snapshot, targetSize: 1);
    final item = plan.items.single;
    final question = buildDrillPracticeQuestion(
      lesson: item.lesson,
      drill: item.drill,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DailySessionScreen(
          plan: plan,
          progressStore: store,
          initialProgress: store.snapshot,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text(question.correctAnswer),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text(question.correctAnswer));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('VER RESUMO'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('VER RESUMO'));
    await tester.pumpAndSettle();

    expect(find.text('SESSÃO CONCLUÍDA'), findsOneWidget);
    expect(find.text('+10'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);
    expect(store.snapshot.xp, 10);
    expect(store.snapshot.practiceSessions, hasLength(1));
    expect(store.snapshot.practiceSessions.single.itemCount, 1);
    expect(store.snapshot.practiceSessions.single.accuracy, 100);
    expect(store.snapshot.practiceSessions.single.xpGained, 10);
  });

  testWidgets('drill home exposes daily twelve and player progression',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DrillModeScreen(progressStore: MemoryBiblicalProgressStore()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('DAILY SESSION 12'), findsOneWidget);
    expect(find.text('INICIAR 12/12'), findsOneWidget);
    expect(find.text('12 revisão · 0 novo · 0 reforço'), findsNothing);
    expect(find.text('0 revisão · 12 novo · 0 reforço'), findsOneWidget);
    expect(find.byTooltip('Player Progression'), findsOneWidget);
  });
}
