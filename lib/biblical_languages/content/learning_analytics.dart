import '../progress/biblical_progress.dart';
import 'course_registry.dart';

enum AnalyticsTarget { biblicalHebrew, koineGreek, esperanto }

class LearningDimensionMetrics {
  const LearningDimensionMetrics({
    required this.key,
    required this.label,
    required this.attempted,
    required this.averageMastery,
    required this.dueReviews,
  });

  final String key;
  final String label;
  final int attempted;
  final double averageMastery;
  final int dueReviews;
}

class LearningAnalyticsMetrics {
  const LearningAnalyticsMetrics({
    required this.languages,
    required this.modes,
    required this.totalAttempted,
  });

  final List<LearningDimensionMetrics> languages;
  final List<LearningDimensionMetrics> modes;
  final int totalAttempted;

  bool get hasData => totalAttempted > 0;

  LearningDimensionMetrics? get weakestLanguage {
    final attempted = languages.where((item) => item.attempted > 0).toList();
    if (attempted.isEmpty) return null;
    attempted.sort(_weakestFirst);
    return attempted.first;
  }

  LearningDimensionMetrics? get weakestMode {
    final attempted = modes.where((item) => item.attempted > 0).toList();
    if (attempted.isEmpty) return null;
    attempted.sort(_weakestFirst);
    return attempted.first;
  }

  List<AnalyticsTarget> get languagePriority {
    final attempted = languages.where((item) => item.attempted > 0).toList();
    if (attempted.isEmpty) return const <AnalyticsTarget>[];
    attempted.sort(_weakestFirst);
    return attempted.map((item) => analyticsTargetFromKey(item.key)).toList();
  }
}

LearningAnalyticsMetrics buildLearningAnalytics(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
}) {
  final reference = (now ?? DateTime.now().toUtc()).toUtc();
  final modeAttempted = <int, int>{for (var mode = 1; mode <= 6; mode++) mode: 0};
  final modeMastery = <int, int>{for (var mode = 1; mode <= 6; mode++) mode: 0};
  final modeDue = <int, int>{for (var mode = 1; mode <= 6; mode++) mode: 0};

  for (final lesson in implementedBiblicalLessons) {
    for (final drill in lesson.drills) {
      if (!progress.masteryByDrillId.containsKey(drill.id)) continue;
      modeAttempted[drill.variant] = (modeAttempted[drill.variant] ?? 0) + 1;
      modeMastery[drill.variant] =
          (modeMastery[drill.variant] ?? 0) + progress.masteryFor(drill.id);
      if (progress.isReviewDue(drill.id, now: reference)) {
        modeDue[drill.variant] = (modeDue[drill.variant] ?? 0) + 1;
      }
    }
  }

  final modes = <LearningDimensionMetrics>[
    for (var mode = 1; mode <= 6; mode++)
      LearningDimensionMetrics(
        key: 'mode_$mode',
        label: 'Modo $mode',
        attempted: modeAttempted[mode] ?? 0,
        averageMastery: _average(
          modeMastery[mode] ?? 0,
          modeAttempted[mode] ?? 0,
        ),
        dueReviews: modeDue[mode] ?? 0,
      ),
  ];

  final languages = <LearningDimensionMetrics>[
    _languageMetrics(
      AnalyticsTarget.biblicalHebrew,
      'Hebraico Bíblico',
      const [1, 4],
      modeAttempted,
      modeMastery,
      modeDue,
    ),
    _languageMetrics(
      AnalyticsTarget.koineGreek,
      'Grego Koiné',
      const [2, 5],
      modeAttempted,
      modeMastery,
      modeDue,
    ),
    _languageMetrics(
      AnalyticsTarget.esperanto,
      'Esperanto',
      const [3, 6],
      modeAttempted,
      modeMastery,
      modeDue,
    ),
  ];

  return LearningAnalyticsMetrics(
    languages: List.unmodifiable(languages),
    modes: List.unmodifiable(modes),
    totalAttempted: modeAttempted.values.fold(0, (sum, value) => sum + value),
  );
}

AnalyticsTarget targetForVariant(int variant) {
  switch (variant) {
    case 1:
    case 4:
      return AnalyticsTarget.biblicalHebrew;
    case 2:
    case 5:
      return AnalyticsTarget.koineGreek;
    case 3:
    case 6:
      return AnalyticsTarget.esperanto;
    default:
      throw RangeError.range(variant, 1, 6, 'variant');
  }
}

String analyticsTargetKey(AnalyticsTarget target) {
  switch (target) {
    case AnalyticsTarget.biblicalHebrew:
      return 'biblical_hebrew';
    case AnalyticsTarget.koineGreek:
      return 'koine_greek';
    case AnalyticsTarget.esperanto:
      return 'esperanto';
  }
}

AnalyticsTarget analyticsTargetFromKey(String key) {
  switch (key) {
    case 'biblical_hebrew':
      return AnalyticsTarget.biblicalHebrew;
    case 'koine_greek':
      return AnalyticsTarget.koineGreek;
    case 'esperanto':
      return AnalyticsTarget.esperanto;
    default:
      throw ArgumentError.value(key, 'key', 'Unknown analytics target');
  }
}

LearningDimensionMetrics _languageMetrics(
  AnalyticsTarget target,
  String label,
  List<int> modes,
  Map<int, int> attempted,
  Map<int, int> mastery,
  Map<int, int> due,
) {
  final attemptedCount = modes.fold(0, (sum, mode) => sum + (attempted[mode] ?? 0));
  final masteryTotal = modes.fold(0, (sum, mode) => sum + (mastery[mode] ?? 0));
  final dueCount = modes.fold(0, (sum, mode) => sum + (due[mode] ?? 0));
  return LearningDimensionMetrics(
    key: analyticsTargetKey(target),
    label: label,
    attempted: attemptedCount,
    averageMastery: _average(masteryTotal, attemptedCount),
    dueReviews: dueCount,
  );
}

double _average(int total, int count) => count == 0 ? 0 : total / count;

int _weakestFirst(LearningDimensionMetrics a, LearningDimensionMetrics b) {
  final mastery = a.averageMastery.compareTo(b.averageMastery);
  if (mastery != 0) return mastery;
  final due = b.dueReviews.compareTo(a.dueReviews);
  if (due != 0) return due;
  return a.label.compareTo(b.label);
}
