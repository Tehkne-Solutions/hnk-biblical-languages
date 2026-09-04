import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_011_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_011_hebrew.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_011_leitura_guiada.dart';

void main() {
  group('Lesson 011 contracts', () {
    test('reading plan reduces support before verification', () {
      final plan = lesson011LeituraGuiada.readingPlan;
      expect(plan, hasLength(5));
      expect(plan.map((s) => s.number).toList(), [1, 2, 3, 4, 5]);
      expect(plan.first.showPortuguese, isTrue);
      expect(plan.first.showTransliteration, isTrue);
      expect(plan[2].showPortuguese, isFalse);
      expect(plan[2].showTransliteration, isFalse);
      expect(plan[3].codexAllowed, isFalse);
      expect(plan.last.codexAllowed, isTrue);
      expect(plan.last.title, 'VERIFY');
    });

    test('guided reading reuses and extends canonical checkpoints', () {
      expect(lesson011LeituraGuiada.scriptures, hasLength(7));
      expect(lesson011LeituraGuiada.scriptures.map((p) => p.reference).toList(), [
        'Gênesis 1:1',
        'Gênesis 1:3',
        'Gênesis 2:7',
        'Gênesis 3:9',
        'João 1:1',
        'João 1:3–5',
        'João 1:14',
      ]);
    });

    test('Genesis checkpoints preserve narrative morphology and question', () {
      expect(lesson011Genesis27.tokens.firstWhere((x) => x.surface == 'וַיִּיצֶר').morphology, contains('consecutivo'));
      expect(lesson011Genesis27.tokens.firstWhere((x) => x.surface == 'נִשְׁמַת חַיִּים').morphology, contains('construto'));
      expect(lesson011Genesis39.tokens.firstWhere((x) => x.surface == 'אַיֶּכָּה').morphology, contains('interrogativo'));
      expect(lesson011Genesis39.translationNotePt, contains('etapa interpretativa posterior'));
    });

    test('John 1:14 preserves becoming dwelling and seeing forms', () {
      expect(lesson011John114.tokens.firstWhere((x) => x.surface == 'ἐγένετο').morphology, contains('aoristo médio'));
      expect(lesson011John114.tokens.firstWhere((x) => x.surface == 'ἐσκήνωσεν').morphology, contains('aoristo ativo'));
      expect(lesson011John114.tokens.firstWhere((x) => x.surface == 'ἐθεασάμεθα').morphology, contains('1ª pessoa plural'));
      expect(lesson011John114.translationNotePt, contains('sem transformar essa imagem'));
    });
  });
}
