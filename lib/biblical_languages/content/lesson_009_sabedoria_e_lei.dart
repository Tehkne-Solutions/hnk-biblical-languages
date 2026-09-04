import '../models/biblical_lesson.dart';
import 'drill_factory.dart';
import 'lesson_009_greek.dart';
import 'lesson_009_hebrew.dart';
import 'lesson_009_patterns.dart';

final lesson009SabedoriaELei = BiblicalLesson(
  id: 'biblical_lesson_009',
  number: 9,
  title: 'ASHREI · NOMOS · SABEDORIA E LEI',
  subtitle: 'Salmo 1:1 + Mateus 5:17 · negação, caminho, Lei e contraste',
  objectivePt: 'Reconhecer paralelismo negativo no Hebraico e proibição + infinitivos contrastados no Grego, mantendo semântica, tradução e interpretação doutrinária em camadas distintas.',
  scriptures: const [lesson009Hebrew, lesson009Greek],
  patterns: lesson009Patterns,
  drills: build72Drills(lessonId: 'biblical_lesson_009', patterns: lesson009Patterns),
  challenge: const LessonChallenge(
    id: 'decode_wisdom_law',
    promptPt: 'Identifique o paralelismo de לֹא הָלַךְ / לֹא עָמָד / לֹא יָשָׁב e depois explique οὐκ ἦλθον καταλῦσαι ἀλλὰ πληρῶσαι.',
    answer: 'O Salmo usa três cláusulas negativas paralelas: não andou, não permaneceu, não se assentou. Mateus contrasta “não vim abolir/desfazer” com “mas cumprir/completar”.',
    hintPt: 'Use as estruturas 03, 07, 08, 11 e 12.',
  ),
);