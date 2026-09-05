import '../progress/biblical_progress.dart';
import 'course_registry.dart';
import 'learning_analytics.dart';
import 'smart_coach.dart';

enum LearningPathTrend { baseline, improving, stable, stalled }

class LearningPathStep {
  const LearningPathStep({
    required this.order,
    required this.target,
    required this.mode,
    required this.lessonNumbers,
    required this.attempted,
    required this.availableDrills,
    required this.averageMastery,
    required this.dueReviews,
    required this.coachSessions,
    required this.averageCoachDelta,
    required this.trend,
    required this.current,
  });

  final int order;
  final AnalyticsTarget target;
  final int mode;
  final List<int> lessonNumbers;
  final int attempted;
  final int availableDrills;
  final double averageMastery;
  final int dueReviews;
  final int coachSessions;
  final double averageCoachDelta;
  final LearningPathTrend trend;
  final bool current;

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

  String get focusLabel => '$targetLabel · Modo $mode';

  String get trendLabel {
    switch (trend) {
      case LearningPathTrend.baseline:
        return 'SEM HISTÓRICO';
      case LearningPathTrend.improving:
        return 'EM EVOLUÇÃO';
      case LearningPathTrend.stable:
        return 'ESTÁVEL';
      case LearningPathTrend.stalled:
        return 'PEDE REFORÇO';
    }
  }

  String get advanceCondition {
    if (attempted == 0) {
      return 'Formar uma linha de base real antes de projetar consolidação.';
    }
    if (averageMastery < 3) {
      return 'Chegar a mastery médio ≥3 no material já introduzido, com ganho verificável nas sessões focadas.';
    }
    if (averageMastery < 4) {
      return 'Consolidar mastery médio ≥4 e reduzir as revisões vencidas deste modo.';
    }
    if (averageMastery < 5) {
      return 'Levar o material já introduzido deste modo a mastery 5; conteúdo novo continua pela sequência canônica.';
    }
    return 'Manter mastery 5 e responder às revisões vencidas antes de retirar este foco da rota.';
  }
}

class LearningPathPlan {
  const LearningPathPlan({
    required this.steps,
    required this.coachOutcomesAnalyzed,
    required this.unlockedLessons,
  });

  final List<LearningPathStep> steps;
  final int coachOutcomesAnalyzed;
  final int unlockedLessons;

  bool get hasData => steps.isNotEmpty;
  bool get complete => steps.isEmpty;
  LearningPathStep? get currentStep => steps.isEmpty ? null : steps.first;
}

LearningPathPlan buildLearningPathPlan(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
  int maxSteps = 5,
}) {
  if (maxSteps <= 0) {
    throw RangeError.range(maxSteps, 1, 6, 'maxSteps');
  }
  final reference = (now ?? DateTime.now().toUtc()).toUtc();
  final currentRecommendation = buildSmartCoachRecommendation(progress, now: reference);
  final unlocked = implementedBiblicalLessons
      .where((lesson) => _lessonUnlocked(progress, lesson.number))
      .toList(growable: false);
  final coachOutcomes = progress.practiceSessions.where((session) {
    return session.coachSession &&
        session.coachMasteryBefore != null &&
        session.coachMasteryAfter != null;
  }).length;

  if (!progress.masteryByDrillId.isNotEmpty) {
    final baseline = LearningPathStep(
      order: 1,
      target: currentRecommendation.target,
      mode: currentRecommendation.mode,
      lessonNumbers: currentRecommendation.lessonNumbers,
      attempted: 0,
      availableDrills: unlocked.fold(
        0,
        (sum, lesson) =>
            sum + lesson.drills.where((drill) => drill.variant == currentRecommendation.mode).length,
      ),
      averageMastery: 0,
      dueReviews: currentRecommendation.dueReviews,
      coachSessions: 0,
      averageCoachDelta: 0,
      trend: LearningPathTrend.baseline,
      current: true,
    );
    return LearningPathPlan(
      steps: List<LearningPathStep>.unmodifiable([baseline]),
      coachOutcomesAnalyzed: coachOutcomes,
      unlockedLessons: unlocked.length,
    );
  }

  final candidates = <_PathCandidate>[];
  for (var mode = 1; mode <= 6; mode++) {
    var attempted = 0;
    var masteryTotal = 0;
    var dueReviews = 0;
    var available = 0;
    final lessonStats = <_LessonModeStats>[];

    for (final lesson in unlocked) {
      var lessonAttempted = 0;
      var lessonMastery = 0;
      var lessonDue = 0;
      final modeDrills = lesson.drills.where((drill) => drill.variant == mode).toList();
      available += modeDrills.length;
      for (final drill in modeDrills) {
        if (!progress.masteryByDrillId.containsKey(drill.id)) continue;
        lessonAttempted += 1;
        lessonMastery += progress.masteryFor(drill.id);
        if (progress.isReviewDue(drill.id, now: reference)) lessonDue += 1;
      }
      attempted += lessonAttempted;
      masteryTotal += lessonMastery;
      dueReviews += lessonDue;
      if (lessonAttempted > 0) {
        lessonStats.add(
          _LessonModeStats(
            lessonNumber: lesson.number,
            attempted: lessonAttempted,
            averageMastery: lessonMastery / lessonAttempted,
            dueReviews: lessonDue,
          ),
        );
      }
    }

    if (attempted == 0) continue;
    final averageMastery = masteryTotal / attempted;
    if (averageMastery >= BiblicalProgressSnapshot.maxMastery && dueReviews == 0) {
      continue;
    }

    lessonStats.sort((a, b) {
      final mastery = a.averageMastery.compareTo(b.averageMastery);
      if (mastery != 0) return mastery;
      final due = b.dueReviews.compareTo(a.dueReviews);
      if (due != 0) return due;
      final exposure = b.attempted.compareTo(a.attempted);
      if (exposure != 0) return exposure;
      return a.lessonNumber.compareTo(b.lessonNumber);
    });

    final target = targetForVariant(mode);
    final historical = progress.practiceSessions.reversed.where((session) {
      return session.coachSession &&
          session.coachFocusedItemCount > 0 &&
          session.coachTargetKey == analyticsTargetKey(target) &&
          session.coachMode == mode &&
          session.coachMasteryDelta != null;
    }).take(5).toList(growable: false);
    final averageDelta = historical.isEmpty
        ? 0.0
        : historical
                .map((session) => session.coachMasteryDelta!)
                .fold<double>(0, (sum, delta) => sum + delta) /
            historical.length;

    candidates.add(
      _PathCandidate(
        target: target,
        mode: mode,
        lessonNumbers: lessonStats.take(3).map((item) => item.lessonNumber).toList(),
        attempted: attempted,
        availableDrills: available,
        averageMastery: averageMastery,
        dueReviews: dueReviews,
        coachSessions: historical.length,
        averageCoachDelta: averageDelta,
        trend: _trendFor(historical.length, averageDelta),
      ),
    );
  }

  candidates.sort((a, b) {
    final currentA = a.target == currentRecommendation.target &&
            a.mode == currentRecommendation.mode
        ? 0
        : 1;
    final currentB = b.target == currentRecommendation.target &&
            b.mode == currentRecommendation.mode
        ? 0
        : 1;
    final current = currentA.compareTo(currentB);
    if (current != 0) return current;

    final mastery = a.averageMastery.compareTo(b.averageMastery);
    if (mastery != 0) return mastery;
    final trend = a.averageCoachDelta.compareTo(b.averageCoachDelta);
    if (trend != 0) return trend;
    final due = b.dueReviews.compareTo(a.dueReviews);
    if (due != 0) return due;
    final attempted = b.attempted.compareTo(a.attempted);
    if (attempted != 0) return attempted;
    return a.mode.compareTo(b.mode);
  });

  final selected = candidates.take(maxSteps).toList(growable: false);
  return LearningPathPlan(
    steps: List<LearningPathStep>.unmodifiable([
      for (var index = 0; index < selected.length; index++)
        selected[index].toStep(order: index + 1, current: index == 0),
    ]),
    coachOutcomesAnalyzed: coachOutcomes,
    unlockedLessons: unlocked.length,
  );
}

SmartCoachRecommendation recommendationForLearningPathStep(
  LearningPathStep step,
) {
  return SmartCoachRecommendation(
    personalized: step.attempted > 0,
    target: step.target,
    mode: step.mode,
    lessonNumbers: step.lessonNumbers,
    attempted: step.attempted,
    averageMastery: step.averageMastery,
    dueReviews: step.dueReviews,
  );
}

LearningPathTrend _trendFor(int sessions, double averageDelta) {
  if (sessions == 0) return LearningPathTrend.baseline;
  if (averageDelta >= 0.25) return LearningPathTrend.improving;
  if (averageDelta >= 0.05) return LearningPathTrend.stable;
  return LearningPathTrend.stalled;
}

bool _lessonUnlocked(BiblicalProgressSnapshot progress, int lessonNumber) {
  if (lessonNumber <= 1) return true;
  return progress.isCompleted(biblicalLessonId(lessonNumber - 1));
}

class _LessonModeStats {
  const _LessonModeStats({
    required this.lessonNumber,
    required this.attempted,
    required this.averageMastery,
    required this.dueReviews,
  });

  final int lessonNumber;
  final int attempted;
  final double averageMastery;
  final int dueReviews;
}

class _PathCandidate {
  const _PathCandidate({
    required this.target,
    required this.mode,
    required this.lessonNumbers,
    required this.attempted,
    required this.availableDrills,
    required this.averageMastery,
    required this.dueReviews,
    required this.coachSessions,
    required this.averageCoachDelta,
    required this.trend,
  });

  final AnalyticsTarget target;
  final int mode;
  final List<int> lessonNumbers;
  final int attempted;
  final int availableDrills;
  final double averageMastery;
  final int dueReviews;
  final int coachSessions;
  final double averageCoachDelta;
  final LearningPathTrend trend;

  LearningPathStep toStep({required int order, required bool current}) {
    return LearningPathStep(
      order: order,
      target: target,
      mode: mode,
      lessonNumbers: List<int>.unmodifiable(lessonNumbers),
      attempted: attempted,
      availableDrills: availableDrills,
      averageMastery: averageMastery,
      dueReviews: dueReviews,
      coachSessions: coachSessions,
      averageCoachDelta: averageCoachDelta,
      trend: trend,
      current: current,
    );
  }
}
