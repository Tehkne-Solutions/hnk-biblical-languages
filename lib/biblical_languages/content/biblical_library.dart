import '../models/biblical_lesson.dart';
import 'course_registry.dart';

List<ScripturePassage> buildCanonicalScriptureLibrary() {
  final byId = <String, ScripturePassage>{};
  for (final lesson in implementedBiblicalLessons) {
    for (final passage in lesson.scriptures) {
      byId.putIfAbsent(passage.id, () => passage);
    }
  }
  return List<ScripturePassage>.unmodifiable(byId.values);
}

class BiblicalCodexEntry {
  const BiblicalCodexEntry({
    required this.passage,
    required this.token,
  });

  final ScripturePassage passage;
  final ScriptureToken token;

  String get searchableText => [
        token.surface,
        token.transliteration,
        token.lemma,
        token.glossPt,
        token.morphology,
        passage.reference,
      ].join(' ').toLowerCase();
}

List<BiblicalCodexEntry> buildCanonicalCodexIndex() {
  return List<BiblicalCodexEntry>.unmodifiable([
    for (final passage in buildCanonicalScriptureLibrary())
      for (final token in passage.tokens)
        BiblicalCodexEntry(passage: passage, token: token),
  ]);
}
