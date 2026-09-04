import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';

void main() {
  test('saves drill position independently per lesson', () {
    var progress = const BiblicalProgressSnapshot();
    progress = progress.saveDrillPosition('biblical_lesson_001', 5);
    progress = progress.saveDrillPosition('biblical_lesson_002', 11);

    expect(progress.drillPositionFor('biblical_lesson_001'), 5);
    expect(progress.drillPositionFor('biblical_lesson_002'), 11);
  });

  test('completion and layer preferences survive JSON round trip', () {
    final snapshot = const BiblicalProgressSnapshot()
        .completeLesson('biblical_lesson_001')
        .withPreferences(
          const BiblicalLearningPreferences(
            showPortuguese: false,
            showEsperanto: true,
            showTransliteration: false,
          ),
        );

    final restored = BiblicalProgressSnapshot.fromJson(snapshot.toJson());

    expect(restored.isCompleted('biblical_lesson_001'), isTrue);
    expect(restored.preferences.showPortuguese, isFalse);
    expect(restored.preferences.showEsperanto, isTrue);
    expect(restored.preferences.showTransliteration, isFalse);
  });

  test('rejects drill positions outside 0..71', () {
    expect(
      () => const BiblicalProgressSnapshot()
          .saveDrillPosition('biblical_lesson_001', 72),
      throwsRangeError,
    );
  });

  test('migrates schema v1 progress without losing canonical fields', () {
    final restored = BiblicalProgressSnapshot.fromJson({
      'schemaVersion': 1,
      'drillPositions': {'biblical_lesson_001': 9},
      'completedLessonIds': ['biblical_lesson_001'],
      'preferences': {
        'showPortuguese': false,
        'showEsperanto': true,
        'showTransliteration': true,
      },
      'lastLessonId': 'biblical_lesson_001',
      'updatedAt': '2026-09-01T12:00:00Z',
    });

    expect(restored.schemaVersion, BiblicalProgressSnapshot.currentSchemaVersion);
    expect(restored.drillPositionFor('biblical_lesson_001'), 9);
    expect(restored.isCompleted('biblical_lesson_001'), isTrue);
    expect(restored.xp, 0);
    expect(restored.streakDays, 0);
    expect(restored.masteryByDrillId, isEmpty);
  });

  test('wrong answer keeps position and becomes immediately due', () {
    final at = DateTime.utc(2026, 9, 4, 12);
    final next = const BiblicalProgressSnapshot().recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'biblical_lesson_001_s1_v1',
      zeroBasedIndex: 4,
      correct: false,
      timestamp: at,
    );

    expect(next.drillPositionFor('biblical_lesson_001'), 0);
    expect(next.xp, 0);
    expect(next.masteryFor('biblical_lesson_001_s1_v1'), 0);
    expect(next.streakDays, 1);
    expect(next.isReviewDue('biblical_lesson_001_s1_v1', now: at), isTrue);
  });

  test('correct answer advances, awards xp and schedules spaced review', () {
    final at = DateTime.utc(2026, 9, 4, 12);
    final next = const BiblicalProgressSnapshot().recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'biblical_lesson_001_s1_v1',
      zeroBasedIndex: 4,
      correct: true,
      timestamp: at,
    );

    expect(next.drillPositionFor('biblical_lesson_001'), 5);
    expect(next.xp, 10);
    expect(next.masteryFor('biblical_lesson_001_s1_v1'), 1);
    expect(next.streakDays, 1);
    expect(next.reviewDueAtFor('biblical_lesson_001_s1_v1'), at.add(const Duration(days: 1)));
  });

  test('reviewing an old drill never regresses the lesson cursor', () {
    final at = DateTime.utc(2026, 9, 4, 12);
    var progress = const BiblicalProgressSnapshot().saveDrillPosition(
      'biblical_lesson_001',
      40,
      timestamp: at,
    );

    progress = progress.recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'biblical_lesson_001_s1_v1',
      zeroBasedIndex: 0,
      correct: false,
      timestamp: at,
    );
    expect(progress.drillPositionFor('biblical_lesson_001'), 40);

    progress = progress.recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'biblical_lesson_001_s1_v1',
      zeroBasedIndex: 0,
      correct: true,
      timestamp: at.add(const Duration(minutes: 1)),
    );
    expect(progress.drillPositionFor('biblical_lesson_001'), 40);
  });

  test('daily streak increments next day and resets after a gap', () {
    var progress = const BiblicalProgressSnapshot().recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'd1',
      zeroBasedIndex: 0,
      correct: true,
      timestamp: DateTime.utc(2026, 9, 1, 10),
    );
    progress = progress.recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'd2',
      zeroBasedIndex: 1,
      correct: true,
      timestamp: DateTime.utc(2026, 9, 2, 20),
    );
    expect(progress.streakDays, 2);

    progress = progress.recordDrillResult(
      lessonId: 'biblical_lesson_001',
      drillId: 'd3',
      zeroBasedIndex: 2,
      correct: true,
      timestamp: DateTime.utc(2026, 9, 4, 8),
    );
    expect(progress.streakDays, 1);
  });
}
