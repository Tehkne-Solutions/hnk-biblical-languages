import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'course_registry.dart';

class DrillPracticeQuestion {
  const DrillPracticeQuestion({
    required this.drillId,
    required this.promptPt,
    required this.cueLabel,
    required this.cueText,
    required this.targetLabel,
    required this.options,
    required this.correctAnswer,
    this.correctTransliteration,
  });

  final String drillId;
  final String promptPt;
  final String cueLabel;
  final String cueText;
  final String targetLabel;
  final List<String> options;
  final String correctAnswer;
  final String? correctTransliteration;
}

class DrillReviewEntry {
  const DrillReviewEntry({
    required this.lesson,
    required this.drill,
    required this.zeroBasedIndex,
    required this.dueAt,
  });

  final BiblicalLesson lesson;
  final DrillItem drill;
  final int zeroBasedIndex;
  final DateTime dueAt;
}

DrillPracticeQuestion buildDrillPracticeQuestion({
  required BiblicalLesson lesson,
  required DrillItem drill,
}) {
  final targetLanguage = _targetLanguageForVariant(drill.variant);
  final cue = _lineFor(drill.lines, BiblicalLanguage.portuguese);
  final correct = _lineFor(drill.lines, targetLanguage);
  final candidates = <String>[correct.text];

  for (var offset = 1; offset < lesson.patterns.length; offset++) {
    final patternIndex = (drill.structure - 1 + offset) % lesson.patterns.length;
    final candidate = _lineFor(lesson.patterns[patternIndex].lines, targetLanguage).text;
    if (!candidates.contains(candidate)) candidates.add(candidate);
    if (candidates.length == 3) break;
  }

  final rotation = (drill.structure + drill.variant) % candidates.length;
  final options = <String>[
    ...candidates.skip(rotation),
    ...candidates.take(rotation),
  ];

  return DrillPracticeQuestion(
    drillId: drill.id,
    promptPt: '${drill.taskPt}\nEscolha a forma correta em ${_languageName(targetLanguage)}.',
    cueLabel: cue.label,
    cueText: cue.text,
    targetLabel: _languageName(targetLanguage),
    options: List<String>.unmodifiable(options),
    correctAnswer: correct.text,
    correctTransliteration: correct.transliteration,
  );
}

List<DrillReviewEntry> buildDueReviewQueue(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
}) {
  final reference = (now ?? DateTime.now().toUtc()).toUtc();
  final queue = <DrillReviewEntry>[];

  for (final lesson in implementedBiblicalLessons) {
    for (var index = 0; index < lesson.drills.length; index++) {
      final drill = lesson.drills[index];
      final dueAt = progress.reviewDueAtFor(drill.id);
      if (dueAt != null && !dueAt.isAfter(reference)) {
        queue.add(
          DrillReviewEntry(
            lesson: lesson,
            drill: drill,
            zeroBasedIndex: index,
            dueAt: dueAt,
          ),
        );
      }
    }
  }

  queue.sort((a, b) => a.dueAt.compareTo(b.dueAt));
  return List<DrillReviewEntry>.unmodifiable(queue);
}

BiblicalLanguage _targetLanguageForVariant(int variant) {
  switch (variant) {
    case 1:
    case 4:
      return BiblicalLanguage.biblicalHebrew;
    case 2:
    case 5:
      return BiblicalLanguage.koineGreek;
    case 3:
    case 6:
      return BiblicalLanguage.esperanto;
    default:
      throw RangeError.range(variant, 1, 6, 'variant');
  }
}

LanguageLine _lineFor(List<LanguageLine> lines, BiblicalLanguage language) {
  return lines.firstWhere((line) => line.language == language);
}

String _languageName(BiblicalLanguage language) {
  switch (language) {
    case BiblicalLanguage.portuguese:
      return 'Português';
    case BiblicalLanguage.esperanto:
      return 'Esperanto';
    case BiblicalLanguage.biblicalHebrew:
      return 'Hebraico Bíblico';
    case BiblicalLanguage.koineGreek:
      return 'Grego Koiné';
  }
}
