enum BiblicalLanguage {
  portuguese,
  esperanto,
  biblicalHebrew,
  koineGreek,
}

enum ScriptDirection { ltr, rtl }

class LanguageLine {
  const LanguageLine({required this.language, required this.text, required this.label, this.transliteration, this.direction = ScriptDirection.ltr, this.note});
  final BiblicalLanguage language;
  final String text;
  final String label;
  final String? transliteration;
  final ScriptDirection direction;
  final String? note;
}

class ScriptureToken {
  const ScriptureToken({required this.surface, required this.transliteration, required this.glossPt, required this.lemma, required this.morphology});
  final String surface;
  final String transliteration;
  final String glossPt;
  final String lemma;
  final String morphology;
}

class ScripturePassage {
  const ScripturePassage({required this.id, required this.reference, required this.language, required this.text, required this.transliteration, required this.literalPt, required this.naturalPt, required this.tokens, required this.sourceEdition, required this.sourceLicense, required this.sourceAttribution, this.direction = ScriptDirection.ltr, this.translationNotePt});
  final String id;
  final String reference;
  final BiblicalLanguage language;
  final String text;
  final String transliteration;
  final String literalPt;
  final String naturalPt;
  final List<ScriptureToken> tokens;
  final String sourceEdition;
  final String sourceLicense;
  final String sourceAttribution;
  final ScriptDirection direction;
  final String? translationNotePt;
}

class ComparativePattern {
  const ComparativePattern({required this.id, required this.title, required this.explanationPt, required this.lines});
  final String id;
  final String title;
  final String explanationPt;
  final List<LanguageLine> lines;
}

class DrillItem {
  const DrillItem({required this.id, required this.structure, required this.variant, required this.taskPt, required this.lines});
  final String id;
  final int structure;
  final int variant;
  final String taskPt;
  final List<LanguageLine> lines;
}

class LessonChallenge {
  const LessonChallenge({required this.id, required this.promptPt, required this.answer, required this.hintPt});
  final String id;
  final String promptPt;
  final String answer;
  final String hintPt;
}

class ReadingStage {
  const ReadingStage({required this.number, required this.title, required this.instructionPt, required this.showPortuguese, required this.showTransliteration, required this.codexAllowed});
  final int number;
  final String title;
  final String instructionPt;
  final bool showPortuguese;
  final bool showTransliteration;
  final bool codexAllowed;
}

class BiblicalLesson {
  const BiblicalLesson({required this.id, required this.number, required this.title, required this.subtitle, required this.objectivePt, required this.scriptures, required this.patterns, required this.drills, required this.challenge, this.readingPlan = const []});
  final String id;
  final int number;
  final String title;
  final String subtitle;
  final String objectivePt;
  final List<ScripturePassage> scriptures;
  final List<ComparativePattern> patterns;
  final List<DrillItem> drills;
  final LessonChallenge challenge;
  final List<ReadingStage> readingPlan;
}
