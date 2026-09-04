import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'course_registry.dart';
import 'drill_practice_factory.dart';
import 'learning_analytics.dart';

enum DailySessionItemKind { review, newContent, reinforcement }

class DailySessionItem {
  const DailySessionItem({
    required this.lesson,
    required this.drill,
    required this.zeroBasedIndex,
    required this.kind,
  });

  final BiblicalLesson lesson;
  final DrillItem drill;
  final int zeroBasedIndex;
  final DailySessionItemKind kind;
}

class DailySessionPlan {
  const DailySessionPlan({required this.items});

  final List<DailySessionItem> items;

  int get reviewCount =>
      items.where((item) => item.kind == DailySessionItemKind.review).length;
  int get newCount =>
      items.where((item) => item.kind == DailySessionItemKind.newContent).length;
  int get reinforcementCount => items
      .where((item) => item.kind == DailySessionItemKind.reinforcement)
      .length;
}

DailySessionPlan buildDailySessionPlan(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
  int targetSize = 12,
}) {
  if (targetSize <= 0) {
    throw RangeError.range(targetSize, 1, 864, 'targetSize');
  }

  final items = <DailySessionItem>[];
  final seen = <String>{};
  final due = buildDueReviewQueue(progress, now: now);
  final analytics = buildLearningAnalytics(progress, now: now);
  final languagePriority = analytics.languagePriority;

  void addItem(
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

  for (final entry in due) {
    addItem(
      entry.lesson,
      entry.drill,
      entry.zeroBasedIndex,
      DailySessionItemKind.review,
    );
    if (items.length == targetSize) break;
  }

  BiblicalLesson? activeLesson;
  for (final lesson in implementedBiblicalLessons) {
    if (!progress.isCompleted(lesson.id)) {
      activeLesson = lesson;
      break;
    }
  }

  if (items.length < targetSize && activeLesson != null) {
    final start = progress
        .drillPositionFor(activeLesson.id)
        .clamp(0, activeLesson.drills.length - 1)
        .toInt();
    for (var index = start;
        index < activeLesson.drills.length && items.length < targetSize;
        index++) {
      final drill = activeLesson.drills[index];
      if (progress.masteryFor(drill.id) == 0) {
        addItem(
          activeLesson,
          drill,
          index,
          DailySessionItemKind.newContent,
        );
      }
    }
  }

  if (items.length < targetSize) {
    final unlockedLessons = activeLesson == null
        ? implementedBiblicalLessons
        : implementedBiblicalLessons
            .where(
              (lesson) =>
                  progress.isCompleted(lesson.id) || lesson.id == activeLesson!.id,
            )
            .toList(growable: false);

    final candidates = <({BiblicalLesson lesson, DrillItem drill, int index})>[];
    for (final lesson in unlockedLessons) {
      for (var index = 0; index < lesson.drills.length; index++) {
        final drill = lesson.drills[index];
        if (!seen.contains(drill.id)) {
          candidates.add((lesson: lesson, drill: drill, index: index));
        }
      }
    }

    int languageRank(DrillItem drill) {
      if (languagePriority.isEmpty) return 0;
      final rank = languagePriority.indexOf(targetForVariant(drill.variant));
      return rank < 0 ? languagePriority.length : rank;
    }

    candidates.sort((a, b) {
      final masteryCompare = progress
          .masteryFor(a.drill.id)
          .compareTo(progress.masteryFor(b.drill.id));
      if (masteryCompare != 0) return masteryCompare;
      final languageCompare = languageRank(a.drill).compareTo(languageRank(b.drill));
      if (languageCompare != 0) return languageCompare;
      final lessonCompare = a.lesson.number.compareTo(b.lesson.number);
      if (lessonCompare != 0) return lessonCompare;
      return a.index.compareTo(b.index);
    });

    for (final candidate in candidates) {
      addItem(
        candidate.lesson,
        candidate.drill,
        candidate.index,
        DailySessionItemKind.reinforcement,
      );
      if (items.length == targetSize) break;
    }
  }

  return DailySessionPlan(items: List<DailySessionItem>.unmodifiable(items));
}
