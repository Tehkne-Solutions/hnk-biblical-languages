import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'course_registry.dart';
import 'daily_session_factory.dart';
import 'drill_practice_factory.dart';
import 'learning_analytics.dart';
import 'mastery_map.dart';

class SmartCoachRecommendation {
  const SmartCoachRecommendation({
    required this.personalized,
    required this.target,
    required this.mode,
    required this.lessonNumbers,
    required this.attempted,
    required this.averageMastery,
    required this.dueReviews,
  });

  final bool personalized;
  final AnalyticsTarget target;
  final int mode;
  final List<int> lessonNumbers;
  final int attempted;
  final double averageMastery;
  final int dueReviews;

  String get targetLabel {
    switch (target) {
      case AnalyticsTarget.biblicalHebrew:
        return 'Hebraico Bíblico';
      case AnalyticsTarget.koineGreek:
        return 'Grego Koiné';
      case AnalyticsTarget.esperanto:
        return 'Esperanto';
    }
  }

  String get focusLabel => personalized
      ? '$targetLabel · Modo $mode'
      : 'Formar linha de base · Modo $mode';
}

SmartCoachRecommendation buildSmartCoachRecommendation(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
}) {
  final analytics = buildLearningAnalytics(progress, now: now);
  final map = buildMasteryMap(progress, now: now);

  if (!analytics.hasData || analytics.weakestLanguage == null) {
    final activeLesson = _activeLesson(progress);
    return SmartCoachRecommendation(
      personalized: false,
      target: AnalyticsTarget.biblicalHebrew,
      mode: 1,
      lessonNumbers: List<int>.unmodifiable([activeLesson.number]),
      attempted: 0,
      averageMastery: 0,
      dueReviews: map.dueReviews,
    );
  }

  final weakestLanguage = analytics.weakestLanguage!;
  final target = analyticsTargetFromKey(weakestLanguage.key);
  final targetModes = analytics.modes
      .where(
        (metric) =>
            metric.attempted > 0 &&
            targetForVariant(_modeFromMetric(metric)) == target,
      )
      .toList(growable: false)
    ..sort(_dimensionWeakestFirst);

  final mode = targetModes.isEmpty ? _baselineMode(target) : _modeFromMetric(targetModes.first);
  final lessonCandidates = <({int number, MasteryMapCell cell})>[];

  for (final row in map.rows) {
    if (!_lessonUnlocked(progress, row.lesson.number)) continue;
    final cell = row.cells.firstWhere((candidate) => candidate.mode == mode);
    if (cell.attempted == 0) continue;
    lessonCandidates.add((number: row.lesson.number, cell: cell));
  }

  lessonCandidates.sort((a, b) {
    final mastery = a.cell.averageMastery.compareTo(b.cell.averageMastery);
    if (mastery != 0) return mastery;
    final due = b.cell.dueReviews.compareTo(a.cell.dueReviews);
    if (due != 0) return due;
    final attempted = b.cell.attempted.compareTo(a.cell.attempted);
    if (attempted != 0) return attempted;
    return a.number.compareTo(b.number);
  });

  final lessonNumbers = lessonCandidates.isEmpty
      ? <int>[_activeLesson(progress).number]
      : lessonCandidates.take(3).map((entry) => entry.number).toList();
  final modeMetric = targetModes.isEmpty ? null : targetModes.first;

  return SmartCoachRecommendation(
    personalized: true,
    target: target,
    mode: mode,
    lessonNumbers: List<int>.unmodifiable(lessonNumbers),
    attempted: modeMetric?.attempted ?? weakestLanguage.attempted,
    averageMastery:
        modeMetric?.averageMastery ?? weakestLanguage.averageMastery,
    dueReviews: modeMetric?.dueReviews ?? weakestLanguage.dueReviews,
  );
}

DailySessionPlan buildSmartCoachSession(
  BiblicalProgressSnapshot progress,
  SmartCoachRecommendation recommendation, {
  DateTime? now,
  int targetSize = 12,
}) {
  if (targetSize <= 0) {
    throw RangeError.range(targetSize, 1, 864, 'targetSize');
  }
  if (!recommendation.personalized) {
    return buildDailySessionPlan(progress, now: now, targetSize: targetSize);
  }

  final items = <DailySessionItem>[];
  final seen = <String>{};

  void add(
    BiblicalLesson lesson,
    DrillItem drill,
    int index,
    DailySessionItemKind kind,
  ) {
    if (items.length >= targetSize || !seen.add(drill.id)) return;
    items.add(
      DailySessionItem(
        lesson: lesson,
        drill: drill,
        zeroBasedIndex: index,
        kind: kind,
      ),
    );
  }

  for (final entry in buildDueReviewQueue(progress, now: now)) {
    add(
      entry.lesson,
      entry.drill,
      entry.zeroBasedIndex,
      DailySessionItemKind.review,
    );
    if (items.length == targetSize) break;
  }

  final candidates = <({BiblicalLesson lesson, DrillItem drill, int index})>[];
  for (final lesson in implementedBiblicalLessons) {
    if (!_lessonUnlocked(progress, lesson.number)) continue;
    for (var index = 0; index < lesson.drills.length; index++) {
      final drill = lesson.drills[index];
      if (!progress.masteryByDrillId.containsKey(drill.id) || seen.contains(drill.id)) {
        continue;
      }
      if (targetForVariant(drill.variant) == recommendation.target) {
        candidates.add((lesson: lesson, drill: drill, index: index));
      }
    }
  }

  int lessonRank(int lessonNumber) {
    final rank = recommendation.lessonNumbers.indexOf(lessonNumber);
    return rank < 0 ? recommendation.lessonNumbers.length : rank;
  }

  candidates.sort((a, b) {
    final exactModeA = a.drill.variant == recommendation.mode ? 0 : 1;
    final exactModeB = b.drill.variant == recommendation.mode ? 0 : 1;
    final exactMode = exactModeA.compareTo(exactModeB);
    if (exactMode != 0) return exactMode;

    final mastery = progress
        .masteryFor(a.drill.id)
        .compareTo(progress.masteryFor(b.drill.id));
    if (mastery != 0) return mastery;

    final lesson = lessonRank(a.lesson.number).compareTo(lessonRank(b.lesson.number));
    if (lesson != 0) return lesson;
    final lessonNumber = a.lesson.number.compareTo(b.lesson.number);
    if (lessonNumber != 0) return lessonNumber;
    return a.index.compareTo(b.index);
  });

  for (final candidate in candidates) {
    add(
      candidate.lesson,
      candidate.drill,
      candidate.index,
      DailySessionItemKind.reinforcement,
    );
    if (items.length == targetSize) break;
  }

  if (items.length < targetSize) {
    final fallback = buildDailySessionPlan(progress, now: now, targetSize: targetSize);
    for (final item in fallback.items) {
      add(item.lesson, item.drill, item.zeroBasedIndex, item.kind);
      if (items.length == targetSize) break;
    }
  }

  return DailySessionPlan(items: List<DailySessionItem>.unmodifiable(items));
}

int _modeFromMetric(LearningDimensionMetrics metric) =>
    int.parse(metric.key.substring('mode_'.length));

int _dimensionWeakestFirst(
  LearningDimensionMetrics a,
  LearningDimensionMetrics b,
) {
  final mastery = a.averageMastery.compareTo(b.averageMastery);
  if (mastery != 0) return mastery;
  final due = b.dueReviews.compareTo(a.dueReviews);
  if (due != 0) return due;
  final attempted = b.attempted.compareTo(a.attempted);
  if (attempted != 0) return attempted;
  return a.key.compareTo(b.key);
}

int _baselineMode(AnalyticsTarget target) {
  switch (target) {
    case AnalyticsTarget.biblicalHebrew:
      return 1;
    case AnalyticsTarget.koineGreek:
      return 2;
    case AnalyticsTarget.esperanto:
      return 3;
  }
}

BiblicalLesson _activeLesson(BiblicalProgressSnapshot progress) {
  for (final lesson in implementedBiblicalLessons) {
    if (!progress.isCompleted(lesson.id)) return lesson;
  }
  return implementedBiblicalLessons.last;
}

bool _lessonUnlocked(BiblicalProgressSnapshot progress, int lessonNumber) {
  if (lessonNumber <= 1) return true;
  return progress.isCompleted(biblicalLessonId(lessonNumber - 1));
}
