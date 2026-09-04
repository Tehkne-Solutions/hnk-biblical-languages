import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_009_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_009_hebrew.dart';

void main() {
  group('Lesson 009 contracts', () {
    test('Psalm 1:1 keeps three negative parallel clauses', () {
      final walk = lesson009Hebrew.tokens.firstWhere((x) => x.surface == 'לֹא הָלַךְ');
      final stand = lesson009Hebrew.tokens.firstWhere((x) => x.surface == 'לֹא עָמָד');
      final sit = lesson009Hebrew.tokens.firstWhere((x) => x.surface == 'לֹא יָשָׁב');
      expect(walk.morphology, contains('Qal perfeito 3ms'));
      expect(stand.morphology, contains('Qal perfeito 3ms'));
      expect(sit.morphology, contains('Qal perfeito 3ms'));
      expect(lesson009Hebrew.translationNotePt, contains('três cláusulas negativas'));
      expect(lesson009Hebrew.translationNotePt, contains('antes de qualquer leitura homilética'));
    });

    test('Matthew 5:17 keeps prohibition and infinitive contrast', () {
      final prohibition = lesson009Greek.tokens.firstWhere((x) => x.surface == 'Μὴ νομίσητε');
      final abolish = lesson009Greek.tokens.firstWhere((x) => x.surface == 'καταλῦσαι');
      final fulfill = lesson009Greek.tokens.firstWhere((x) => x.surface == 'ἀλλὰ πληρῶσαι');
      expect(prohibition.morphology, contains('subjuntivo'));
      expect(abolish.morphology, contains('aoristo ativo infinitivo'));
      expect(fulfill.morphology, contains('aoristo ativo infinitivo'));
      expect(lesson009Greek.translationNotePt, contains('conclusão doutrinária'));
    });
  });
}
