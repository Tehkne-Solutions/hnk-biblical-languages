import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BiblicalLearningPreferences {
  const BiblicalLearningPreferences({
    this.showPortuguese = true,
    this.showEsperanto = true,
    this.showTransliteration = true,
  });

  final bool showPortuguese;
  final bool showEsperanto;
  final bool showTransliteration;

  BiblicalLearningPreferences copyWith({
    bool? showPortuguese,
    bool? showEsperanto,
    bool? showTransliteration,
  }) {
    return BiblicalLearningPreferences(
      showPortuguese: showPortuguese ?? this.showPortuguese,
      showEsperanto: showEsperanto ?? this.showEsperanto,
      showTransliteration: showTransliteration ?? this.showTransliteration,
    );
  }

  Map<String, Object?> toJson() => {
        'showPortuguese': showPortuguese,
        'showEsperanto': showEsperanto,
        'showTransliteration': showTransliteration,
      };

  factory BiblicalLearningPreferences.fromJson(Map<String, Object?> json) {
    return BiblicalLearningPreferences(
      showPortuguese: json['showPortuguese'] as bool? ?? true,
      showEsperanto: json['showEsperanto'] as bool? ?? true,
      showTransliteration: json['showTransliteration'] as bool? ?? true,
    );
  }
}

class BiblicalProgressSnapshot {
  const BiblicalProgressSnapshot({
    this.schemaVersion = currentSchemaVersion,
    this.drillPositions = const <String, int>{},
    this.completedLessonIds = const <String>{},
    this.preferences = const BiblicalLearningPreferences(),
    this.masteryByDrillId = const <String, int>{},
    this.reviewDueAtByDrillId = const <String, DateTime>{},
    this.xp = 0,
    this.streakDays = 0,
    this.lastPracticeDay,
    this.lastLessonId,
    this.updatedAt,
  });

  static const int currentSchemaVersion = 2;
  static const int maxMastery = 5;

  final int schemaVersion;
  final Map<String, int> drillPositions;
  final Set<String> completedLessonIds;
  final BiblicalLearningPreferences preferences;
  final Map<String, int> masteryByDrillId;
  final Map<String, DateTime> reviewDueAtByDrillId;
  final int xp;
  final int streakDays;
  final DateTime? lastPracticeDay;
  final String? lastLessonId;
  final DateTime? updatedAt;

  int drillPositionFor(String lessonId) => drillPositions[lessonId] ?? 0;

  int masteryFor(String drillId) => masteryByDrillId[drillId] ?? 0;

  DateTime? reviewDueAtFor(String drillId) => reviewDueAtByDrillId[drillId];

  bool isCompleted(String lessonId) => completedLessonIds.contains(lessonId);

  bool isReviewDue(String drillId, {DateTime? now}) {
    final dueAt = reviewDueAtFor(drillId);
    if (dueAt == null) return false;
    final reference = (now ?? DateTime.now().toUtc()).toUtc();
    return !dueAt.isAfter(reference);
  }

  BiblicalProgressSnapshot saveDrillPosition(
    String lessonId,
    int zeroBasedIndex, {
    DateTime? timestamp,
  }) {
    if (zeroBasedIndex < 0 || zeroBasedIndex > 71) {
      throw RangeError.range(zeroBasedIndex, 0, 71, 'zeroBasedIndex');
    }
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    return _copyWith(
      drillPositions: Map<String, int>.unmodifiable({
        ...drillPositions,
        lessonId: zeroBasedIndex,
      }),
      lastLessonId: lessonId,
      updatedAt: eventAt,
    );
  }

  BiblicalProgressSnapshot recordDrillResult({
    required String lessonId,
    required String drillId,
    required int zeroBasedIndex,
    required bool correct,
    DateTime? timestamp,
  }) {
    if (zeroBasedIndex < 0 || zeroBasedIndex > 71) {
      throw RangeError.range(zeroBasedIndex, 0, 71, 'zeroBasedIndex');
    }

    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    final previousMastery = masteryFor(drillId);
    final nextMastery = correct
        ? (previousMastery + 1).clamp(0, maxMastery).toInt()
        : (previousMastery - 1).clamp(0, maxMastery).toInt();
    final savedPosition = drillPositionFor(lessonId);
    final candidatePosition =
        correct ? (zeroBasedIndex + 1).clamp(0, 71).toInt() : savedPosition;
    final nextPosition = candidatePosition > savedPosition
        ? candidatePosition
        : savedPosition;
    final nextStreak = _streakFor(eventAt);
    final dueAt = correct
        ? eventAt.add(Duration(days: _reviewIntervalDays(nextMastery)))
        : eventAt;

    return _copyWith(
      drillPositions: Map<String, int>.unmodifiable({
        ...drillPositions,
        lessonId: nextPosition,
      }),
      masteryByDrillId: Map<String, int>.unmodifiable({
        ...masteryByDrillId,
        drillId: nextMastery,
      }),
      reviewDueAtByDrillId: Map<String, DateTime>.unmodifiable({
        ...reviewDueAtByDrillId,
        drillId: dueAt,
      }),
      xp: xp + (correct ? 10 : 0),
      streakDays: nextStreak,
      lastPracticeDay: _utcDay(eventAt),
      lastLessonId: lessonId,
      updatedAt: eventAt,
    );
  }

  BiblicalProgressSnapshot completeLesson(
    String lessonId, {
    DateTime? timestamp,
  }) {
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    return _copyWith(
      completedLessonIds: Set<String>.unmodifiable({
        ...completedLessonIds,
        lessonId,
      }),
      lastLessonId: lessonId,
      updatedAt: eventAt,
    );
  }

  BiblicalProgressSnapshot withPreferences(
    BiblicalLearningPreferences nextPreferences, {
    DateTime? timestamp,
  }) {
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    return _copyWith(
      preferences: nextPreferences,
      updatedAt: eventAt,
    );
  }

  int _streakFor(DateTime eventAt) {
    final previousDay = lastPracticeDay == null ? null : _utcDay(lastPracticeDay!);
    final currentDay = _utcDay(eventAt);
    if (previousDay == null) return 1;
    final difference = currentDay.difference(previousDay).inDays;
    if (difference <= 0) return streakDays == 0 ? 1 : streakDays;
    if (difference == 1) return streakDays + 1;
    return 1;
  }

  static int _reviewIntervalDays(int mastery) {
    switch (mastery) {
      case 1:
        return 1;
      case 2:
        return 3;
      case 3:
        return 7;
      case 4:
        return 14;
      case 5:
        return 30;
      default:
        return 0;
    }
  }

  static DateTime _utcDay(DateTime value) {
    final utc = value.toUtc();
    return DateTime.utc(utc.year, utc.month, utc.day);
  }

  BiblicalProgressSnapshot _copyWith({
    Map<String, int>? drillPositions,
    Set<String>? completedLessonIds,
    BiblicalLearningPreferences? preferences,
    Map<String, int>? masteryByDrillId,
    Map<String, DateTime>? reviewDueAtByDrillId,
    int? xp,
    int? streakDays,
    DateTime? lastPracticeDay,
    String? lastLessonId,
    DateTime? updatedAt,
  }) {
    return BiblicalProgressSnapshot(
      schemaVersion: currentSchemaVersion,
      drillPositions: drillPositions ?? this.drillPositions,
      completedLessonIds: completedLessonIds ?? this.completedLessonIds,
      preferences: preferences ?? this.preferences,
      masteryByDrillId: masteryByDrillId ?? this.masteryByDrillId,
      reviewDueAtByDrillId: reviewDueAtByDrillId ?? this.reviewDueAtByDrillId,
      xp: xp ?? this.xp,
      streakDays: streakDays ?? this.streakDays,
      lastPracticeDay: lastPracticeDay ?? this.lastPracticeDay,
      lastLessonId: lastLessonId ?? this.lastLessonId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() => {
        'schemaVersion': currentSchemaVersion,
        'drillPositions': drillPositions,
        'completedLessonIds': completedLessonIds.toList()..sort(),
        'preferences': preferences.toJson(),
        'masteryByDrillId': masteryByDrillId,
        'reviewDueAtByDrillId': reviewDueAtByDrillId.map(
          (key, value) => MapEntry(key, value.toUtc().toIso8601String()),
        ),
        'xp': xp,
        'streakDays': streakDays,
        'lastPracticeDay': lastPracticeDay?.toUtc().toIso8601String(),
        'lastLessonId': lastLessonId,
        'updatedAt': updatedAt?.toUtc().toIso8601String(),
      };

  factory BiblicalProgressSnapshot.fromJson(Map<String, Object?> json) {
    final version = (json['schemaVersion'] as num?)?.toInt() ?? 1;
    if (version > currentSchemaVersion) {
      throw StateError('Unsupported Biblical Languages progress schema: $version');
    }

    final rawPositions =
        (json['drillPositions'] as Map?)?.cast<String, Object?>() ??
            const <String, Object?>{};
    final rawCompleted = json['completedLessonIds'] as List? ?? const [];
    final rawPreferences =
        (json['preferences'] as Map?)?.cast<String, Object?>() ??
            const <String, Object?>{};
    final rawMastery =
        (json['masteryByDrillId'] as Map?)?.cast<String, Object?>() ??
            const <String, Object?>{};
    final rawReviewDue =
        (json['reviewDueAtByDrillId'] as Map?)?.cast<String, Object?>() ??
            const <String, Object?>{};
    final lastLessonId = '${json['lastLessonId'] ?? ''}'.trim();

    return BiblicalProgressSnapshot(
      schemaVersion: currentSchemaVersion,
      drillPositions: Map<String, int>.unmodifiable(
        rawPositions.map(
          (key, value) => MapEntry(
            key,
            (value as num).toInt().clamp(0, 71).toInt(),
          ),
        ),
      ),
      completedLessonIds: Set<String>.unmodifiable(
        rawCompleted.map((value) => '$value').where((value) => value.isNotEmpty),
      ),
      preferences: BiblicalLearningPreferences.fromJson(rawPreferences),
      masteryByDrillId: Map<String, int>.unmodifiable(
        rawMastery.map(
          (key, value) => MapEntry(
            key,
            (value as num).toInt().clamp(0, maxMastery).toInt(),
          ),
        ),
      ),
      reviewDueAtByDrillId: Map<String, DateTime>.unmodifiable({
        for (final entry in rawReviewDue.entries)
          if (DateTime.tryParse('${entry.value}') != null)
            entry.key: DateTime.parse('${entry.value}').toUtc(),
      }),
      xp: ((json['xp'] as num?)?.toInt() ?? 0).clamp(0, 1 << 31).toInt(),
      streakDays:
          ((json['streakDays'] as num?)?.toInt() ?? 0).clamp(0, 1 << 20).toInt(),
      lastPracticeDay:
          DateTime.tryParse('${json['lastPracticeDay'] ?? ''}')?.toUtc(),
      lastLessonId: lastLessonId.isEmpty ? null : lastLessonId,
      updatedAt: DateTime.tryParse('${json['updatedAt'] ?? ''}')?.toUtc(),
    );
  }
}

abstract interface class BiblicalProgressStore {
  Future<BiblicalProgressSnapshot> load();
  Future<void> save(BiblicalProgressSnapshot snapshot);
}

class SharedPreferencesBiblicalProgressStore implements BiblicalProgressStore {
  const SharedPreferencesBiblicalProgressStore({
    this.storageKey = 'simpleway.biblical_languages.progress.v1',
  });

  final String storageKey;

  @override
  Future<BiblicalProgressSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getString(storageKey);
    if (encoded == null || encoded.trim().isEmpty) {
      return const BiblicalProgressSnapshot();
    }

    try {
      return BiblicalProgressSnapshot.fromJson(
        (jsonDecode(encoded) as Map).cast<String, Object?>(),
      );
    } on Object {
      return const BiblicalProgressSnapshot();
    }
  }

  @override
  Future<void> save(BiblicalProgressSnapshot snapshot) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(storageKey, jsonEncode(snapshot.toJson()));
  }
}

class MemoryBiblicalProgressStore implements BiblicalProgressStore {
  MemoryBiblicalProgressStore([
    this.snapshot = const BiblicalProgressSnapshot(),
  ]);

  BiblicalProgressSnapshot snapshot;

  @override
  Future<BiblicalProgressSnapshot> load() async => snapshot;

  @override
  Future<void> save(BiblicalProgressSnapshot snapshot) async {
    this.snapshot = snapshot;
  }
}
