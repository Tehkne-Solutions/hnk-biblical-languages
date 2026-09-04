import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/player_progression.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/player_progress_screen.dart';

void main() {
  test('schema v3 records and restores practice session history', () {
    final at = DateTime.utc(2026, 9, 4, 18);
    final snapshot = const BiblicalProgressSnapshot().recordPracticeSession(
      itemCount: 12,
      attempts: 13,
      correctAttempts: 12,
      xpGained: 120,
      masteryImproved: 10,
      reviewCount: 3,
      newCount: 7,
      reinforcementCount: 2,
      timestamp: at,
    );

    final restored = BiblicalProgressSnapshot.fromJson(snapshot.toJson());

    expect(restored.schemaVersion, 3);
    expect(restored.practiceSessions, hasLength(1));
    expect(restored.practiceSessions.single.accuracy, 92);
    expect(restored.practiceSessions.single.xpGained, 120);
    expect(restored.dailyGoalCompletedOn(at), isTrue);
    expect(
      restored.dailyGoalCompletedOn(at.add(const Duration(days: 1))),
      isFalse,
    );
  });

  test('schema v2 migrates with empty session history', () {
    final restored = BiblicalProgressSnapshot.fromJson({
      'schemaVersion': 2,
      'drillPositions': {'biblical_lesson_001': 12},
      'completedLessonIds': <String>[],
      'preferences': <String, Object?>{},
      'masteryByDrillId': {'d1': 2},
      'reviewDueAtByDrillId': <String, Object?>{},
      'xp': 120,
      'streakDays': 2,
      'lastPracticeDay': '2026-09-04T00:00:00Z',
    });

    expect(restored.schemaVersion, 3);
    expect(restored.xp, 120);
    expect(restored.masteryFor('d1'), 2);
    expect(restored.practiceSessions, isEmpty);
  });

  test('rank progression follows learning XP thresholds', () {
    expect(playerRankForXp(0).title, 'Aprendiz');
    expect(playerRankForXp(119).title, 'Aprendiz');
    expect(playerRankForXp(120).title, 'Leitor');
    expect(playerRankForXp(720).title, 'Escriba');
    expect(playerRankForXp(3000).title, 'Exegeta em Formação');
  });

  test('metrics derive daily goal mastery accuracy and achievements', () {
    final at = DateTime.utc(2026, 9, 4, 18);
    final session = PracticeSessionRecord(
      completedAt: at,
      itemCount: 12,
      attempts: 12,
      correctAttempts: 12,
      xpGained: 120,
      masteryImproved: 12,
      reviewCount: 0,
      newCount: 12,
      reinforcementCount: 0,
    );
    final snapshot = BiblicalProgressSnapshot(
      xp: 720,
      streakDays: 7,
      completedLessonIds: const {
        'biblical_lesson_001',
        'biblical_lesson_002',
        'biblical_lesson_003',
        'biblical_lesson_004',
        'biblical_lesson_005',
        'biblical_lesson_006',
      },
      masteryByDrillId: {
        for (var index = 0; index < 12; index++) 'd$index': 3,
      },
      practiceSessions: [session],
    );

    final metrics = buildPlayerProgressMetrics(snapshot, now: at);

    expect(metrics.rank.title, 'Escriba');
    expect(metrics.dailyGoalCompleted, isTrue);
    expect(metrics.masteryThreeCount, 12);
    expect(metrics.averageAccuracyLast7, 100);
    expect(
      metrics.achievements
          .firstWhere((achievement) => achievement.id == 'perfect_session')
          .unlocked,
      isTrue,
    );
    expect(
      metrics.achievements
          .firstWhere((achievement) => achievement.id == 'lesson_6')
          .unlocked,
      isTrue,
    );
  });

  testWidgets('player dashboard exposes rank goal achievements and history',
      (tester) async {
    final at = DateTime.now().toUtc();
    final snapshot = BiblicalProgressSnapshot(
      xp: 720,
      streakDays: 3,
      practiceSessions: [
        PracticeSessionRecord(
          completedAt: at,
          itemCount: 12,
          attempts: 12,
          correctAttempts: 12,
          xpGained: 120,
          masteryImproved: 12,
          reviewCount: 2,
          newCount: 8,
          reinforcementCount: 2,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProgressScreen(
          progressStore: MemoryBiblicalProgressStore(snapshot),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NÍVEL 4 · Escriba'), findsOneWidget);
    expect(find.text('META DIÁRIA · DAILY SESSION'), findsOneWidget);
    expect(find.text('CONQUISTAS'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('HISTÓRICO DE SESSÕES'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('12 itens · +120 XP'), findsOneWidget);
  });
}
