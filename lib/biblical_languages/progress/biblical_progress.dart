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

class PracticeSessionRecord {
  const PracticeSessionRecord({
    required this.completedAt,
    required this.itemCount,
    required this.attempts,
    required this.correctAttempts,
    required this.xpGained,
    required this.masteryImproved,
    required this.reviewCount,
    required this.newCount,
    required this.reinforcementCount,
    this.coachSession = false,
    this.coachBaseline = false,
    this.coachTargetKey,
    this.coachMode,
    this.coachLessonNumbers = const <int>[],
    this.coachFocusedItemCount = 0,
    this.coachMasteryBefore,
    this.coachMasteryAfter,
  });

  final DateTime completedAt;
  final int itemCount;
  final int attempts;
  final int correctAttempts;
  final int xpGained;
  final int masteryImproved;
  final int reviewCount;
  final int newCount;
  final int reinforcementCount;
  final bool coachSession;
  final bool coachBaseline;
  final String? coachTargetKey;
  final int? coachMode;
  final List<int> coachLessonNumbers;
  final int coachFocusedItemCount;
  final double? coachMasteryBefore;
  final double? coachMasteryAfter;

  int get accuracy =>
      attempts == 0 ? 0 : ((correctAttempts / attempts) * 100).round();

  double? get coachMasteryDelta {
    final before = coachMasteryBefore;
    final after = coachMasteryAfter;
    if (before == null || after == null) return null;
    return after - before;
  }

  PracticeSessionRecord withCoachOutcome({
    required bool baseline,
    required String targetKey,
    required int mode,
    required List<int> lessonNumbers,
    required int focusedItemCount,
    required double masteryBefore,
    required double masteryAfter,
  }) {
    if (targetKey.trim().isEmpty) {
      throw ArgumentError.value(targetKey, 'targetKey');
    }
    if (mode < 1 || mode > 6) {
      throw RangeError.range(mode, 1, 6, 'mode');
    }
    if (focusedItemCount < 0 || focusedItemCount > itemCount) {
      throw RangeError.range(focusedItemCount, 0, itemCount, 'focusedItemCount');
    }
    if (masteryBefore < 0 || masteryBefore > 5) {
      throw RangeError.range(masteryBefore, 0, 5, 'masteryBefore');
    }
    if (masteryAfter < 0 || masteryAfter > 5) {
      throw RangeError.range(masteryAfter, 0, 5, 'masteryAfter');
    }
    final normalizedLessons = lessonNumbers
        .where((number) => number >= 1 && number <= 12)
        .toSet()
        .toList()
      ..sort();
    return PracticeSessionRecord(
      completedAt: completedAt,
      itemCount: itemCount,
      attempts: attempts,
      correctAttempts: correctAttempts,
      xpGained: xpGained,
      masteryImproved: masteryImproved,
      reviewCount: reviewCount,
      newCount: newCount,
      reinforcementCount: reinforcementCount,
      coachSession: true,
      coachBaseline: baseline,
      coachTargetKey: targetKey.trim(),
      coachMode: mode,
      coachLessonNumbers: List<int>.unmodifiable(normalizedLessons),
      coachFocusedItemCount: focusedItemCount,
      coachMasteryBefore: masteryBefore,
      coachMasteryAfter: masteryAfter,
    );
  }

  Map<String, Object?> toJson() => {
        'completedAt': completedAt.toUtc().toIso8601String(),
        'itemCount': itemCount,
        'attempts': attempts,
        'correctAttempts': correctAttempts,
        'xpGained': xpGained,
        'masteryImproved': masteryImproved,
        'reviewCount': reviewCount,
        'newCount': newCount,
        'reinforcementCount': reinforcementCount,
        if (coachSession) ...{
          'coachSession': true,
          'coachBaseline': coachBaseline,
          'coachTargetKey': coachTargetKey,
          'coachMode': coachMode,
          'coachLessonNumbers': coachLessonNumbers,
          'coachFocusedItemCount': coachFocusedItemCount,
          'coachMasteryBefore': coachMasteryBefore,
          'coachMasteryAfter': coachMasteryAfter,
        },
      };

  factory PracticeSessionRecord.fromJson(Map<String, Object?> json) {
    final coachSession = json['coachSession'] as bool? ?? false;
    final rawTargetKey = '${json['coachTargetKey'] ?? ''}'.trim();
    final rawMode = (json['coachMode'] as num?)?.toInt();
    final rawLessons = json['coachLessonNumbers'] as List? ?? const [];
    final before = (json['coachMasteryBefore'] as num?)?.toDouble();
    final after = (json['coachMasteryAfter'] as num?)?.toDouble();
    return PracticeSessionRecord(
      completedAt: DateTime.tryParse('${json['completedAt'] ?? ''}')?.toUtc() ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      itemCount:
          ((json['itemCount'] as num?)?.toInt() ?? 0).clamp(0, 864).toInt(),
      attempts: ((json['attempts'] as num?)?.toInt() ?? 0)
          .clamp(0, 1000000)
          .toInt(),
      correctAttempts: ((json['correctAttempts'] as num?)?.toInt() ?? 0)
          .clamp(0, 1000000)
          .toInt(),
      xpGained: ((json['xpGained'] as num?)?.toInt() ?? 0)
          .clamp(0, 1000000)
          .toInt(),
      masteryImproved: ((json['masteryImproved'] as num?)?.toInt() ?? 0)
          .clamp(0, 864)
          .toInt(),
      reviewCount:
          ((json['reviewCount'] as num?)?.toInt() ?? 0).clamp(0, 864).toInt(),
      newCount:
          ((json['newCount'] as num?)?.toInt() ?? 0).clamp(0, 864).toInt(),
      reinforcementCount:
          ((json['reinforcementCount'] as num?)?.toInt() ?? 0)
              .clamp(0, 864)
              .toInt(),
      coachSession: coachSession,
      coachBaseline: coachSession && (json['coachBaseline'] as bool? ?? false),
      coachTargetKey:
          coachSession && rawTargetKey.isNotEmpty ? rawTargetKey : null,
      coachMode: coachSession && rawMode != null
          ? rawMode.clamp(1, 6).toInt()
          : null,
      coachLessonNumbers: List<int>.unmodifiable(
        rawLessons
            .whereType<num>()
            .map((value) => value.toInt())
            .where((value) => value >= 1 && value <= 12)
            .toSet()
            .toList()
          ..sort(),
      ),
      coachFocusedItemCount: coachSession
          ? ((json['coachFocusedItemCount'] as num?)?.toInt() ?? 0)
              .clamp(0, 864)
              .toInt()
          : 0,
      coachMasteryBefore: coachSession && before != null
          ? before.clamp(0.0, 5.0).toDouble()
          : null,
      coachMasteryAfter: coachSession && after != null
          ? after.clamp(0.0, 5.0).toDouble()
          : null,
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
    this.practiceSessions = const <PracticeSessionRecord>[],
    this.xp = 0,
    this.streakDays = 0,
    this.lastPracticeDay,
    this.lastLessonId,
    this.updatedAt,
  });

  static const int currentSchemaVersion = 4;
  static const int maxMastery = 5;
  static const int maxSessionHistory = 90;

  final int schemaVersion;
  final Map<String, int> drillPositions;
  final Set<String> completedLessonIds;
  final BiblicalLearningPreferences preferences;
  final Map<String, int> masteryByDrillId;
  final Map<String, DateTime> reviewDueAtByDrillId;
  final List<PracticeSessionRecord> practiceSessions;
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

  bool dailyGoalCompletedOn(DateTime day) {
    final target = _utcDay(day);
    return practiceSessions.any(
      (session) => _utcDay(session.completedAt) == target,
    );
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
    final currentPosition = drillPositionFor(lessonId);
    final advancedPosition = (zeroBasedIndex + 1).clamp(0, 71).toInt();
    final nextPosition = correct && advancedPosition > currentPosition
        ? advancedPosition
        : currentPosition;
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

  BiblicalProgressSnapshot recordPracticeSession({
    required int itemCount,
    required int attempts,
    required int correctAttempts,
    required int xpGained,
    required int masteryImproved,
    required int reviewCount,
    required int newCount,
    required int reinforcementCount,
    DateTime? timestamp,
  }) {
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    final session = PracticeSessionRecord(
      completedAt: eventAt,
      itemCount: itemCount,
      attempts: attempts,
      correctAttempts: correctAttempts,
      xpGained: xpGained,
      masteryImproved: masteryImproved,
      reviewCount: reviewCount,
      newCount: newCount,
      reinforcementCount: reinforcementCount,
    );
    final nextHistory = <PracticeSessionRecord>[...practiceSessions, session];
    final trimmed = nextHistory.length <= maxSessionHistory
        ? nextHistory
        : nextHistory.sublist(nextHistory.length - maxSessionHistory);

    return _copyWith(
      practiceSessions: List<PracticeSessionRecord>.unmodifiable(trimmed),
      updatedAt: eventAt,
    );
  }

  BiblicalProgressSnapshot annotateLatestPracticeSessionWithCoach({
    required bool baseline,
    required String targetKey,
    required int mode,
    required List<int> lessonNumbers,
    required int focusedItemCount,
    required double masteryBefore,
    required double masteryAfter,
    DateTime? timestamp,
  }) {
    if (practiceSessions.isEmpty) return this;
    final nextHistory = List<PracticeSessionRecord>.of(practiceSessions);
    nextHistory[nextHistory.length - 1] = nextHistory.last.withCoachOutcome(
      baseline: baseline,
      targetKey: targetKey,
      mode: mode,
      lessonNumbers: lessonNumbers,
      focusedItemCount: focusedItemCount,
      masteryBefore: masteryBefore,
      masteryAfter: masteryAfter,
    );
    return _copyWith(
      practiceSessions: List<PracticeSessionRecord>.unmodifiable(nextHistory),
      updatedAt: (timestamp ?? DateTime.now().toUtc()).toUtc(),
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
    List<PracticeSessionRecord>? practiceSessions,
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
      practiceSessions: practiceSessions ?? this.practiceSessions,
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
        'practiceSessions':
            practiceSessions.map((session) => session.toJson()).toList(),
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
    final rawSessions = json['practiceSessions'] as List? ?? const [];
    final lastLessonId = '${json['lastLessonId'] ?? ''}'.trim();
    final parsedSessions = rawSessions
        .whereType<Map>()
        .map(
          (value) => PracticeSessionRecord.fromJson(
            value.cast<String, Object?>(),
          ),
        )
        .toList(growable: false);
    final trimmedSessions = parsedSessions.length <= maxSessionHistory
        ? parsedSessions
        : parsedSessions.sublist(parsedSessions.length - maxSessionHistory);

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
      practiceSessions:
          List<PracticeSessionRecord>.unmodifiable(trimmedSessions),
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
