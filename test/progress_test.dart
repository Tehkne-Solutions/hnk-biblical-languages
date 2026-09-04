import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';

void main() {
  test('saves drill position independently per lesson', () {
    var progress = const BiblicalProgressSnapshot();
    progress = progress.saveDrillPosition('biblical_lesson_001', 5);
    progress = progress.saveDrillPosition('biblical_lesson_002', 11);

    expect(progress.drillPositionFor('biblical_lesson_001'), 5);
    expect(progress.drillPositionFor('biblical_lesson_002'), 11);
  });

  test('completion and layer preferences survive JSON round trip', () {
    final snapshot = const BiblicalProgressSnapshot()
        .completeLesson('biblical_lesson_001')
        .withPreferences(
          const BiblicalLearningPreferences(
            showPortuguese: false,
            showEsperanto: true,
            showTransliteration: false,
          ),
        );

    final restored = BiblicalProgressSnapshot.fromJson(snapshot.toJson());

    expect(restored.isCompleted('biblical_lesson_001'), isTrue);
    expect(restored.preferences.showPortuguese, isFalse);
    expect(restored.preferences.showEsperanto, isTrue);
    expect(restored.preferences.showTransliteration, isFalse);
  });

  test('rejects drill positions outside 0..71', () {
    expect(
      () => const BiblicalProgressSnapshot()
          .saveDrillPosition('biblical_lesson_001', 72),
      throwsRangeError,
    );
  });
}
