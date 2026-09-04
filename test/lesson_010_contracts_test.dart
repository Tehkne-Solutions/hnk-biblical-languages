import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_010_greek.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/lesson_010_hebrew.dart';

void main() {
  group('Lesson 010 contracts', () {
    test('Isaiah 40:3 keeps participle and two Piel imperatives', () {
      final calling = lesson010Hebrew.tokens.firstWhere((x) => x.surface == 'קוֹרֵא');
      final prepare = lesson010Hebrew.tokens.firstWhere((x) => x.surface == 'פַּנּוּ');
      final straighten = lesson010Hebrew.tokens.firstWhere((x) => x.surface == 'יַשְּׁרוּ');
      expect(calling.morphology, contains('Qal particípio'));
      expect(prepare.morphology, contains('Piel imperativo'));
      expect(straighten.morphology, contains('Piel imperativo'));
    });

    test('Mark distinguishes written perfect and two imperative aspects', () {
      final written = lesson010Greek.tokens.firstWhere((x) => x.surface == 'Καθὼς γέγραπται');
      final prepare = lesson010Greek.tokens.firstWhere((x) => x.surface == 'Ἑτοιμάσατε');
      final make = lesson010Greek.tokens.firstWhere((x) => x.surface == 'ποιεῖτε');
      expect(written.morphology, contains('perfeito passivo'));
      expect(prepare.morphology, contains('aoristo ativo do imperativo'));
      expect(make.morphology, contains('presente ativo do imperativo'));
    });

    test('Mark quotation note explicitly preserves composite citation', () {
      expect(lesson010Greek.translationNotePt, contains('bloco de citação composto'));
      expect(lesson010Greek.translationNotePt, contains('Êxodo 23:20/Malaquias 3:1'));
      expect(lesson010Greek.translationNotePt, contains('Isaías 40:3'));
      expect(lesson010Greek.translationNotePt, contains('antes de discutir'));
    });
  });
}
