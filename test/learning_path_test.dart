import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/learning_analytics.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/learning_path.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/smart_coach.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/smart_coach_screen.dart';

void main() {
  test('path starts with safe baseline when no learning data exists', () {
    final progress = BiblicalProgressSnapshot(
      completedLessonIds: {
        biblicalLessonId(1),
        biblicalLessonId(2),
        biblicalLessonId(3),
      },
    );

    final path = buildLearningPathPlan(progress);

    expect(path.steps, hasLength(1));
    expect(path.currentStep!.current, isTrue);
    expect(path.currentStep!.target, AnalyticsTarget.biblicalHebrew);
    expect(path.currentStep!.mode, 1);
    expect(path.currentStep!.lessonNumbers, [4]);
    expect(path.currentStep!.trend, LearningPathTrend.baseline);
  });

  test('path keeps current coach focus first and never projects locked lessons', () {
    final completed = <String>{
      biblicalLessonId(1),
      biblicalLessonId(2),
      biblicalLessonId(3),
    };
    final mastery = <String, int>{};

    for (final lesson in implementedBiblicalLessons.take(4)) {
      for (var mode = 1; mode <= 6; mode++) {
        final drill = lesson.drills.firstWhere((item) => item.variant == mode);
        mastery[drill.id] = mode == 4 ? 1 : 3 + (mode % 2);
      }
    }

    final progress = BiblicalProgressSnapshot(
      completedLessonIds: completed,
      masteryByDrillId: mastery,
    );
    final recommendation = buildSmartCoachRecommendation(progress);
    final path = buildLearningPathPlan(progress);

    expect(path.steps.length, lessThanOrEqualTo(5));
    expect(path.currentStep!.target, recommendation.target);
    expect(path.currentStep!.mode, recommendation.mode);
    expect(path.currentStep!.mode, 4);
    expect(
      path.steps
          .expand((step) => step.lessonNumbers)
          .every((number) => number <= 4),
      isTrue,
    );
  });

  test('recent coach outcomes influence trend for a route checkpoint', () {
    final lesson = implementedBiblicalLessons.first;
    final hebrewMode4 = lesson.drills.firstWhere((drill) => drill.variant == 4);
    final greekMode2 = lesson.drills.firstWhere((drill) => drill.variant == 2);
    final at = DateTime.utc(2026, 9, 5, 8);
    final history = [
      PracticeSessionRecord(
        completedAt: at.subtract(const Duration(days: 2)),
        itemCount: 12,
        attempts: 12,
        correctAttempts: 10,
        xpGained: 100,
        masteryImproved: 2,
        reviewCount: 0,
        newCount: 0,
        reinforcementCount: 12,
        coachSession: true,
        coachTargetKey: 'biblical_hebrew',
        coachMode: 4,
        coachLessonNumbers: const [1],
        coachFocusedItemCount: 8,
        coachMasteryBefore: 1.0,
        coachMasteryAfter: 1.02,
      ),
      PracticeSessionRecord(
        completedAt: at.subtract(const Duration(days: 1)),
        itemCount: 12,
        attempts: 13,
        correctAttempts: 12,
        xpGained: 120,
        masteryImproved: 2,
        reviewCount: 0,
        newCount: 0,
        reinforcementCount: 12,
        coachSession: true,
        coachTargetKey: 'biblical_hebrew',
        coachMode: 4,
        coachLessonNumbers: const [1],
        coachFocusedItemCount: 9,
        coachMasteryBefore: 1.02,
        coachMasteryAfter: 1.05,
      ),
    ];
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        hebrewMode4.id: 1,
        greekMode2.id: 3,
      },
      practiceSessions: history,
    );

    final path = buildLearningPathPlan(progress, now: at);
    final hebrewStep = path.steps.firstWhere((step) => step.mode == 4);

    expect(hebrewStep.coachSessions, 2);
    expect(hebrewStep.averageCoachDelta, closeTo(0.025, 0.001));
    expect(hebrewStep.trend, LearningPathTrend.stalled);
    expect(path.coachOutcomesAnalyzed, 2);
  });

  test('mode already at mastery five without due reviews leaves the route', () {
    final lesson = implementedBiblicalLessons.first;
    final mastered = lesson.drills.where((drill) => drill.variant == 1).toList();
    final pending = lesson.drills.firstWhere((drill) => drill.variant == 2);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        for (final drill in mastered) drill.id: 5,
        pending.id: 2,
      },
    );

    final path = buildLearningPathPlan(progress);

    expect(path.steps.any((step) => step.mode == 1), isFalse);
    expect(path.steps.any((step) => step.mode == 2), isTrue);
  });

  testWidgets('Smart Coach opens Learning Path with the same progress',
      (tester) async {
    final lesson = implementedBiblicalLessons.first;
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        lesson.drills.first.id: 1,
      },
    );
    final store = MemoryBiblicalProgressStore(progress);

    await tester.pumpWidget(
      MaterialApp(
        home: SmartCoachScreen(
          initialProgress: progress,
          progressStore: store,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Learning Path'));
    await tester.pumpAndSettle();

    expect(find.text('LEARNING PATH'), findsOneWidget);
    expect(find.text('ROTA PARA MASTERY 5'), findsOneWidget);
    expect(find.text('CHECKPOINT ATUAL'), findsOneWidget);
    expect(find.text('TREINAR CHECKPOINT ATUAL'), findsOneWidget);
  });
}
