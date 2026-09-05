import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/learning_analytics.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/smart_coach.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/smart_coach_screen.dart';

PracticeSessionRecord _coachSession({
  bool baseline = false,
  String targetKey = 'biblical_hebrew',
  int mode = 1,
  int focusedItems = 1,
  double before = 1,
  double after = 1,
}) {
  return PracticeSessionRecord(
    completedAt: DateTime.utc(2026, 9, 4, 18),
    itemCount: 12,
    attempts: 12,
    correctAttempts: 10,
    xpGained: 100,
    masteryImproved: 8,
    reviewCount: 2,
    newCount: 0,
    reinforcementCount: 10,
  ).withCoachOutcome(
    baseline: baseline,
    targetKey: targetKey,
    mode: mode,
    lessonNumbers: const [1],
    focusedItemCount: focusedItems,
    masteryBefore: before,
    masteryAfter: after,
  );
}

void main() {
  test('schema v4 persists Coach metadata and mastery delta', () {
    final base = const BiblicalProgressSnapshot().recordPracticeSession(
      itemCount: 12,
      attempts: 12,
      correctAttempts: 11,
      xpGained: 110,
      masteryImproved: 9,
      reviewCount: 2,
      newCount: 0,
      reinforcementCount: 10,
      timestamp: DateTime.utc(2026, 9, 4, 18),
    );
    final annotated = base.annotateLatestPracticeSessionWithCoach(
      baseline: false,
      targetKey: 'koine_greek',
      mode: 5,
      lessonNumbers: const [2, 4, 6],
      focusedItemCount: 8,
      masteryBefore: 1.5,
      masteryAfter: 2.25,
      timestamp: DateTime.utc(2026, 9, 4, 19),
    );

    final restored = BiblicalProgressSnapshot.fromJson(annotated.toJson());
    final session = restored.practiceSessions.single;

    expect(restored.schemaVersion, 4);
    expect(session.coachSession, isTrue);
    expect(session.coachTargetKey, 'koine_greek');
    expect(session.coachMode, 5);
    expect(session.coachLessonNumbers, [2, 4, 6]);
    expect(session.coachFocusedItemCount, 8);
    expect(session.coachMasteryBefore, 1.5);
    expect(session.coachMasteryAfter, 2.25);
    expect(session.coachMasteryDelta, closeTo(.75, .0001));
  });

  test('baseline session advances into a real personalized profile', () {
    final progress = BiblicalProgressSnapshot(
      practiceSessions: [
        _coachSession(baseline: true, focusedItems: 4, before: 0, after: 1),
      ],
    );

    final outcome = buildLatestSmartCoachOutcome(progress)!;

    expect(outcome.decision, SmartCoachDecision.advance);
    expect(outcome.decisionLabel, 'AVANÇAR');
    expect(outcome.rationale, contains('linha de base'));
  });

  test('zero focus exposure keeps prescription instead of claiming failure', () {
    final progress = BiblicalProgressSnapshot(
      practiceSessions: [
        _coachSession(focusedItems: 0, before: 1.5, after: 1.5),
      ],
    );

    final outcome = buildLatestSmartCoachOutcome(progress)!;

    expect(outcome.decision, SmartCoachDecision.maintainFocus);
    expect(outcome.rationale, contains('revisões vencidas'));
  });

  test('Coach changes mode when another mode in same language becomes weakest', () {
    final lesson = implementedBiblicalLessons.first;
    final mode1 = lesson.drills.firstWhere((drill) => drill.variant == 1);
    final mode4 = lesson.drills.firstWhere((drill) => drill.variant == 4);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        mode1.id: 3,
        mode4.id: 1,
      },
      practiceSessions: [
        _coachSession(mode: 1, focusedItems: 2, before: 1, after: 1),
      ],
    );

    final current = buildSmartCoachRecommendation(progress);
    final outcome = buildLatestSmartCoachOutcome(progress)!;

    expect(current.target, AnalyticsTarget.biblicalHebrew);
    expect(current.mode, 4);
    expect(outcome.decision, SmartCoachDecision.changeMode);
  });

  test('Coach changes language when the global weakest language changes', () {
    final lesson = implementedBiblicalLessons.first;
    final hebrew = lesson.drills.firstWhere((drill) => drill.variant == 1);
    final greek = lesson.drills.firstWhere((drill) => drill.variant == 2);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {
        hebrew.id: 4,
        greek.id: 1,
      },
      practiceSessions: [
        _coachSession(mode: 1, focusedItems: 2, before: 1, after: 2),
      ],
    );

    final current = buildSmartCoachRecommendation(progress);
    final outcome = buildLatestSmartCoachOutcome(progress)!;

    expect(current.target, AnalyticsTarget.koineGreek);
    expect(outcome.decision, SmartCoachDecision.changeLanguage);
  });

  test('Coach advances after meaningful mastery gain in the same focus', () {
    final lesson = implementedBiblicalLessons.first;
    final hebrew = lesson.drills.firstWhere((drill) => drill.variant == 1);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {hebrew.id: 3},
      practiceSessions: [
        _coachSession(mode: 1, focusedItems: 4, before: 2, after: 3),
      ],
    );

    final current = buildSmartCoachRecommendation(progress);
    final outcome = buildLatestSmartCoachOutcome(progress)!;

    expect(current.target, AnalyticsTarget.biblicalHebrew);
    expect(current.mode, 1);
    expect(outcome.decision, SmartCoachDecision.advance);
  });

  test('Coach maintains focus while mastery gain is not yet sufficient', () {
    final lesson = implementedBiblicalLessons.first;
    final hebrew = lesson.drills.firstWhere((drill) => drill.variant == 1);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {hebrew.id: 1},
      practiceSessions: [
        _coachSession(mode: 1, focusedItems: 4, before: 1, after: 1.2),
      ],
    );

    final outcome = buildLatestSmartCoachOutcome(progress)!;

    expect(outcome.decision, SmartCoachDecision.maintainFocus);
  });

  testWidgets('Smart Coach exposes last outcome and next decision', (tester) async {
    final lesson = implementedBiblicalLessons.first;
    final hebrew = lesson.drills.firstWhere((drill) => drill.variant == 1);
    final progress = BiblicalProgressSnapshot(
      masteryByDrillId: {hebrew.id: 3},
      practiceSessions: [
        _coachSession(mode: 1, focusedItems: 4, before: 2, after: 3),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SmartCoachScreen(
          initialProgress: progress,
          progressStore: MemoryBiblicalProgressStore(progress),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('RESULTADO DA ÚLTIMA SESSÃO DO COACH'), findsOneWidget);
    expect(find.text('AVANÇAR'), findsOneWidget);
    expect(find.textContaining('2.00 → 3.00'), findsOneWidget);
    expect(find.textContaining('itens de foco'), findsOneWidget);
  });
}
