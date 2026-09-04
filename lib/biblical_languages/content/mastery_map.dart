import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'course_registry.dart';
import 'learning_analytics.dart';

class MasteryMapCell {
  const MasteryMapCell({
    required this.mode,
    required this.target,
    required this.attempted,
    required this.total,
    required this.averageMastery,
    required this.dueReviews,
  });

  final int mode;
  final AnalyticsTarget target;
  final int attempted;
  final int total;
  final double averageMastery;
  final int dueReviews;

  double get normalizedMastery =>
      (averageMastery / BiblicalProgressSnapshot.maxMastery).clamp(0.0, 1.0);
}

class MasteryMapRow {
  const MasteryMapRow({
    required this.lesson,
    required this.cells,
    required this.attempted,
    required this.total,
    required this.averageMastery,
    required this.dueReviews,
  });

  final BiblicalLesson lesson;
  final List<MasteryMapCell> cells;
  final int attempted;
  final int total;
  final double averageMastery;
  final int dueReviews;

  double get coverage => total == 0 ? 0 : attempted / total;
  double get normalizedMastery =>
      (averageMastery / BiblicalProgressSnapshot.maxMastery).clamp(0.0, 1.0);
}

class MasteryMapMetrics {
  const MasteryMapMetrics({
    required this.rows,
    required this.totalAttempted,
    required this.totalDrills,
    required this.averageMastery,
    required this.dueReviews,
  });

  final List<MasteryMapRow> rows;
  final int totalAttempted;
  final int totalDrills;
  final double averageMastery;
  final int dueReviews;

  double get coverage => totalDrills == 0 ? 0 : totalAttempted / totalDrills;
}

MasteryMapMetrics buildMasteryMap(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
}) {
  final reference = (now ?? DateTime.now().toUtc()).toUtc();
  final rows = <MasteryMapRow>[];
  var globalAttempted = 0;
  var globalMastery = 0;
  var globalDue = 0;
  var globalTotal = 0;

  for (final lesson in implementedBiblicalLessons) {
    final cells = <MasteryMapCell>[];
    var lessonAttempted = 0;
    var lessonMastery = 0;
    var lessonDue = 0;

    for (var mode = 1; mode <= 6; mode++) {
      final drills = lesson.drills.where((drill) => drill.variant == mode).toList();
      var attempted = 0;
      var mastery = 0;
      var due = 0;

      for (final drill in drills) {
        if (!progress.masteryByDrillId.containsKey(drill.id)) continue;
        attempted += 1;
        mastery += progress.masteryFor(drill.id);
        if (progress.isReviewDue(drill.id, now: reference)) due += 1;
      }

      cells.add(
        MasteryMapCell(
          mode: mode,
          target: targetForVariant(mode),
          attempted: attempted,
          total: drills.length,
          averageMastery: attempted == 0 ? 0 : mastery / attempted,
          dueReviews: due,
        ),
      );
      lessonAttempted += attempted;
      lessonMastery += mastery;
      lessonDue += due;
    }

    rows.add(
      MasteryMapRow(
        lesson: lesson,
        cells: List<MasteryMapCell>.unmodifiable(cells),
        attempted: lessonAttempted,
        total: lesson.drills.length,
        averageMastery:
            lessonAttempted == 0 ? 0 : lessonMastery / lessonAttempted,
        dueReviews: lessonDue,
      ),
    );

    globalAttempted += lessonAttempted;
    globalMastery += lessonMastery;
    globalDue += lessonDue;
    globalTotal += lesson.drills.length;
  }

  return MasteryMapMetrics(
    rows: List<MasteryMapRow>.unmodifiable(rows),
    totalAttempted: globalAttempted,
    totalDrills: globalTotal,
    averageMastery: globalAttempted == 0 ? 0 : globalMastery / globalAttempted,
    dueReviews: globalDue,
  );
}

String masteryTargetShortLabel(AnalyticsTarget target) {
  switch (target) {
    case AnalyticsTarget.biblicalHebrew:
      return 'HE';
    case AnalyticsTarget.koineGreek:
      return 'GR';
    case AnalyticsTarget.esperanto:
      return 'EO';
  }
}
