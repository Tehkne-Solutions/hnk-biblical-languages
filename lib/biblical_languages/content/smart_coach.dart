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

enum SmartCoachDecision {
  maintainFocus,
  changeMode,
  changeLanguage,
  advance,
}

class SmartCoachOutcome {
  const SmartCoachOutcome({
    required this.session,
    required this.decision,
    required this.masteryBefore,
    required this.masteryAfter,
    required this.masteryDelta,
    required this.rationale,
  });

  final PracticeSessionRecord session;
  final SmartCoachDecision decision;
  final double masteryBefore;
  final double masteryAfter;
  final double masteryDelta;
  final String rationale;

  String get decisionLabel {
    switch (decision) {
      case SmartCoachDecision.maintainFocus:
        return 'MANTER FOCO';
      case SmartCoachDecision.changeMode:
        return 'TROCAR MODO';
      case SmartCoachDecision.changeLanguage:
        return 'TROCAR IDIOMA';
      case SmartCoachDecision.advance:
        return 'AVANÇAR';
    }
  }
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

  final mode =
      targetModes.isEmpty ? _baselineMode(target) : _modeFromMetric(targetModes.first);
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
      if (!progress.masteryByDrillId.containsKey(drill.id) ||
          seen.contains(drill.id)) {
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

    final lesson =
        lessonRank(a.lesson.number).compareTo(lessonRank(b.lesson.number));
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
    final fallback =
        buildDailySessionPlan(progress, now: now, targetSize: targetSize);
    for (final item in fallback.items) {
      add(item.lesson, item.drill, item.zeroBasedIndex, item.kind);
      if (items.length == targetSize) break;
    }
  }

  return DailySessionPlan(items: List<DailySessionItem>.unmodifiable(items));
}

double smartCoachFocusMastery(
  BiblicalProgressSnapshot progress,
  SmartCoachRecommendation recommendation,
) {
  final lessonNumbers = recommendation.lessonNumbers.toSet();
  var attempted = 0;
  var mastery = 0;

  for (final lesson in implementedBiblicalLessons) {
    if (!lessonNumbers.contains(lesson.number)) continue;
    for (final drill in lesson.drills) {
      if (drill.variant != recommendation.mode ||
          !progress.masteryByDrillId.containsKey(drill.id)) {
        continue;
      }
      attempted += 1;
      mastery += progress.masteryFor(drill.id);
    }
  }

  return attempted == 0 ? 0 : mastery / attempted;
}

int smartCoachFocusedItemCount(
  DailySessionPlan plan,
  SmartCoachRecommendation recommendation,
) {
  final lessonNumbers = recommendation.lessonNumbers.toSet();
  return plan.items.where((item) {
    return lessonNumbers.contains(item.lesson.number) &&
        item.drill.variant == recommendation.mode &&
        targetForVariant(item.drill.variant) == recommendation.target;
  }).length;
}

SmartCoachOutcome? buildLatestSmartCoachOutcome(
  BiblicalProgressSnapshot progress,
) {
  PracticeSessionRecord? session;
  for (final candidate in progress.practiceSessions.reversed) {
    if (candidate.coachSession &&
        candidate.coachTargetKey != null &&
        candidate.coachMode != null &&
        candidate.coachMasteryBefore != null &&
        candidate.coachMasteryAfter != null) {
      session = candidate;
      break;
    }
  }
  if (session == null) return null;

  final before = session.coachMasteryBefore!;
  final after = session.coachMasteryAfter!;
  final delta = after - before;

  if (session.coachBaseline) {
    return SmartCoachOutcome(
      session: session,
      decision: SmartCoachDecision.advance,
      masteryBefore: before,
      masteryAfter: after,
      masteryDelta: delta,
      rationale:
          'A linha de base foi registrada. O Coach já pode recalcular o ponto mais frágil usando dados reais.',
    );
  }

  if (session.coachFocusedItemCount == 0) {
    return SmartCoachOutcome(
      session: session,
      decision: SmartCoachDecision.maintainFocus,
      masteryBefore: before,
      masteryAfter: after,
      masteryDelta: delta,
      rationale:
          'As revisões vencidas consumiram a sessão e o foco prescrito não recebeu exposição real. A prescrição será mantida.',
    );
  }

  final previousTarget = _targetFromKey(session.coachTargetKey!);
  final current = buildSmartCoachRecommendation(progress);
  if (previousTarget != null && current.target != previousTarget) {
    return SmartCoachOutcome(
      session: session,
      decision: SmartCoachDecision.changeLanguage,
      masteryBefore: before,
      masteryAfter: after,
      masteryDelta: delta,
      rationale:
          'O idioma mais frágil mudou depois da sessão. O próximo foco deve acompanhar o novo gargalo linguístico.',
    );
  }

  if (current.mode != session.coachMode) {
    return SmartCoachOutcome(
      session: session,
      decision: SmartCoachDecision.changeMode,
      masteryBefore: before,
      masteryAfter: after,
      masteryDelta: delta,
      rationale:
          'Dentro do mesmo idioma, outro modo cognitivo agora apresenta menor domínio. O Coach deslocará o treino para ele.',
    );
  }

  if (after >= 3.0 && delta >= 0.25) {
    return SmartCoachOutcome(
      session: session,
      decision: SmartCoachDecision.advance,
      masteryBefore: before,
      masteryAfter: after,
      masteryDelta: delta,
      rationale:
          'O foco respondeu bem e atingiu domínio funcional. O Coach pode avançar para o próximo ponto frágil sem abandonar as revisões.',
    );
  }

  return SmartCoachOutcome(
    session: session,
    decision: SmartCoachDecision.maintainFocus,
    masteryBefore: before,
    masteryAfter: after,
    masteryDelta: delta,
    rationale:
        'O ganho ainda não é suficiente para abandonar este foco. A próxima sessão preservará a prescrição enquanto o mastery consolida.',
  );
}

AnalyticsTarget? _targetFromKey(String key) {
  try {
    return analyticsTargetFromKey(key);
  } on ArgumentError {
    return null;
  }
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
