import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/daily_session_factory.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/learning_analytics.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/learning_analytics_screen.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/player_progress_screen.dart';

BiblicalProgressSnapshot _profileSnapshot() {
  final lesson = implementedBiblicalLessons.first;
  final byVariant = {
    for (var variant = 1; variant <= 6; variant++)
      variant: lesson.drills.firstWhere((drill) => drill.variant == variant),
  };
  return BiblicalProgressSnapshot(
    masteryByDrillId: {
      byVariant[1]!.id: 1,
      byVariant[4]!.id: 1,
      byVariant[2]!.id: 4,
      byVariant[5]!.id: 4,
      byVariant[3]!.id: 3,
      byVariant[6]!.id: 3,
    },
    reviewDueAtByDrillId: {
      byVariant[1]!.id: DateTime.utc(2026, 9, 4, 10),
    },
  );
}

void main() {
  test('analytics derives weakest language and cognitive mode from mastery', () {
    final metrics = buildLearningAnalytics(
      _profileSnapshot(),
      now: DateTime.utc(2026, 9, 4, 12),
    );

    expect(metrics.totalAttempted, 6);
    expect(metrics.weakestLanguage?.label, 'Hebraico Bíblico');
    expect(metrics.weakestLanguage?.averageMastery, 1);
    expect(metrics.weakestLanguage?.dueReviews, 1);
    expect(metrics.weakestMode?.label, 'Modo 1');
  });

  test('reinforcement uses weak language only as mastery tie breaker', () {
    var progress = _profileSnapshot();
    for (final lesson in implementedBiblicalLessons) {
      progress = progress.completeLesson(lesson.id);
    }

    final plan = buildDailySessionPlan(
      progress,
      now: DateTime.utc(2026, 9, 4, 9),
      targetSize: 3,
    );

    expect(plan.reviewCount, 0);
    expect(plan.reinforcementCount, 3);
    expect(
      plan.items.every(
        (item) => targetForVariant(item.drill.variant) == AnalyticsTarget.biblicalHebrew,
      ),
      isTrue,
    );
  });

  testWidgets('analytics screen exposes recommendation and language profile',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LearningAnalyticsScreen(progress: _profileSnapshot())),
    );

    expect(find.text('LEARNING ANALYTICS'), findsOneWidget);
    expect(find.text('FOCO RECOMENDADO'), findsOneWidget);
    expect(find.textContaining('Hebraico Bíblico'), findsWidgets);
    expect(find.text('IDIOMAS-ALVO'), findsOneWidget);
  });

  testWidgets('player dashboard opens learning analytics', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProgressScreen(
          progressStore: MemoryBiblicalProgressStore(_profileSnapshot()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Learning Analytics'));
    await tester.pumpAndSettle();

    expect(find.text('LEARNING ANALYTICS'), findsOneWidget);
    expect(find.text('FOCO RECOMENDADO'), findsOneWidget);
  });
}
