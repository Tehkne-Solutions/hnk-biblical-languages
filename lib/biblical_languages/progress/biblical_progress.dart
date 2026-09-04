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
    this.lastLessonId,
    this.updatedAt,
  });

  static const int currentSchemaVersion = 1;

  final int schemaVersion;
  final Map<String, int> drillPositions;
  final Set<String> completedLessonIds;
  final BiblicalLearningPreferences preferences;
  final String? lastLessonId;
  final DateTime? updatedAt;

  int drillPositionFor(String lessonId) => drillPositions[lessonId] ?? 0;

  bool isCompleted(String lessonId) => completedLessonIds.contains(lessonId);

  BiblicalProgressSnapshot saveDrillPosition(
    String lessonId,
    int zeroBasedIndex, {
    DateTime? timestamp,
  }) {
    if (zeroBasedIndex < 0 || zeroBasedIndex > 71) {
      throw RangeError.range(zeroBasedIndex, 0, 71, 'zeroBasedIndex');
    }
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    return BiblicalProgressSnapshot(
      drillPositions: Map<String, int>.unmodifiable({
        ...drillPositions,
        lessonId: zeroBasedIndex,
      }),
      completedLessonIds: completedLessonIds,
      preferences: preferences,
      lastLessonId: lessonId,
      updatedAt: eventAt,
    );
  }

  BiblicalProgressSnapshot completeLesson(
    String lessonId, {
    DateTime? timestamp,
  }) {
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    return BiblicalProgressSnapshot(
      drillPositions: drillPositions,
      completedLessonIds: Set<String>.unmodifiable({
        ...completedLessonIds,
        lessonId,
      }),
      preferences: preferences,
      lastLessonId: lessonId,
      updatedAt: eventAt,
    );
  }

  BiblicalProgressSnapshot withPreferences(
    BiblicalLearningPreferences nextPreferences, {
    DateTime? timestamp,
  }) {
    final eventAt = (timestamp ?? DateTime.now().toUtc()).toUtc();
    return BiblicalProgressSnapshot(
      drillPositions: drillPositions,
      completedLessonIds: completedLessonIds,
      preferences: nextPreferences,
      lastLessonId: lastLessonId,
      updatedAt: eventAt,
    );
  }

  Map<String, Object?> toJson() => {
        'schemaVersion': currentSchemaVersion,
        'drillPositions': drillPositions,
        'completedLessonIds': completedLessonIds.toList()..sort(),
        'preferences': preferences.toJson(),
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
    final lastLessonId = '${json['lastLessonId'] ?? ''}'.trim();

    return BiblicalProgressSnapshot(
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
