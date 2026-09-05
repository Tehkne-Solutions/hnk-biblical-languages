import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/daily_session_factory.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/learning_analytics.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/smart_coach.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/learning_analytics_screen.dart';

void main() {
  test('coach uses active lesson as safe baseline before analytics exists', () {
    final progress = BiblicalProgressSnapshot(
      completedLessonIds: {
        biblicalLessonId(1),
        biblicalLessonId(2),
        biblicalLessonId(3),
      },
    );

    final recommendation = buildSmartCoachRecommendation(progress);

    expect(recommendation.personalized, isFalse);
    expect(recommendation.target, AnalyticsTarget.biblicalHebrew);
    expect(recommendation.mode, 1);
    expect(recommendation.lessonNumbers, [4]);
  });

  test('coach identifies weakest language mode and unlocked lesson', () {
    final mastery = <String, int>{};
    final completed = <String>{
      for (var number = 1; number <= 5; number++) biblicalLessonId(number),
    };

    for (final lesson in implementedBiblicalLessons.take(6)) {
      for (var mode = 1; mode <= 6; mode++) {
        final drill = lesson.drills.firstWhere((candidate) => candidate.variant == mode);
        var value = 4;
        if (mode == 4) {
          value = switch (lesson.number) {
            4 => 0,
            6 => 1,
            _ => 2,
          };
        }
        mastery[drill.id] = value;
      }
    }

    final recommendation = buildSmartCoachRecommendation(
      BiblicalProgressSnapshot(
        completedLessonIds: completed,
        masteryByDrillId: mastery,
      ),
    );

    expect(recommendation.personalized, isTrue);
    expect(recommendation.target, AnalyticsTarget.biblicalHebrew);
    expect(recommendation.mode, 4);
    expect(recommendation.lessonNumbers.first, 4);
    expect(recommendation.lessonNumbers, contains(6));
  });

  test('focused session keeps overdue review first then follows coach focus', () {
    final now = DateTime.utc(2026, 9, 4, 18);
    final lesson = implementedBiblicalLessons.first;
    final overdueGreek = lesson.drills.firstWhere((drill) => drill.variant == 2);
    final focusedHebrew = lesson.drills.firstWhere((drill) => drill.variant == 4);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        overdueGreek.id: 2,
        focusedHebrew.id: 1,
      },
      reviewDueAtByDrillId: {
        overdueGreek.id: now.subtract(const Duration(days: 1)),
        focusedHebrew.id: now.add(const Duration(days: 3)),
      },
    );
    const recommendation = SmartCoachRecommendation(
      personalized: true,
      target: AnalyticsTarget.biblicalHebrew,
      mode: 4,
      lessonNumbers: [1],
      attempted: 1,
      averageMastery: 1,
      dueReviews: 0,
    );

    final plan = buildSmartCoachSession(
      progress,
      recommendation,
      now: now,
      targetSize: 4,
    );

    expect(plan.items, hasLength(4));
    expect(plan.items.first.drill.id, overdueGreek.id);
    expect(plan.items.first.kind, DailySessionItemKind.review);
    expect(plan.items[1].drill.id, focusedHebrew.id);
    expect(plan.items[1].kind, DailySessionItemKind.reinforcement);
  });

  test('focused session never pulls artificial progress from locked lessons', () {
    final unlocked = implementedBiblicalLessons.first;
    final locked = implementedBiblicalLessons.last;
    final unlockedDrill = unlocked.drills.firstWhere((drill) => drill.variant == 4);
    final lockedDrill = locked.drills.firstWhere((drill) => drill.variant == 4);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        unlockedDrill.id: 2,
        lockedDrill.id: 0,
      },
    );
    const recommendation = SmartCoachRecommendation(
      personalized: true,
      target: AnalyticsTarget.biblicalHebrew,
      mode: 4,
      lessonNumbers: [12, 1],
      attempted: 2,
      averageMastery: 1,
      dueReviews: 0,
    );

    final plan = buildSmartCoachSession(
      progress,
      recommendation,
      targetSize: 6,
    );

    expect(plan.items, hasLength(6));
    expect(plan.items.every((item) => item.lesson.number == 1), isTrue);
    expect(plan.items.any((item) => item.drill.id == lockedDrill.id), isFalse);
  });

  testWidgets('analytics opens Smart Coach with the same progress store',
      (tester) async {
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        implementedBiblicalLessons.first.drills.first.id: 1,
      },
    );
    final store = MemoryBiblicalProgressStore(progress);

    await tester.pumpWidget(
      MaterialApp(
        home: LearningAnalyticsScreen(
          progress: progress,
          progressStore: store,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Smart Coach'));
    await tester.pumpAndSettle();

    expect(find.text('SMART COACH'), findsOneWidget);
    expect(find.text('PRESCRIÇÃO DE HOJE'), findsOneWidget);
    expect(find.textContaining('Modo'), findsWidgets);
  });
}
