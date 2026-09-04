import '../models/biblical_lesson.dart';
import 'drill_factory.dart';
import 'lesson_008_greek.dart';
import 'lesson_008_hebrew.dart';
import 'lesson_008_patterns.dart';

final lesson008ReisPovosLugares = BiblicalLesson(
  id: 'biblical_lesson_008',
  number: 8,
  title: 'MELEKH · BASILEUS · REIS, POVOS E LUGARES',
  subtitle: '1 Samuel 8:5 + Mateus 2:1 · títulos, povos, origem e destino',
  objectivePt: 'Ler títulos políticos, relações entre povo e rei e marcadores de origem/destino, distinguindo imperativo, infinitivo, genitivo e preposições espaciais.',
  scriptures: const [lesson008Hebrew, lesson008Greek],
  patterns: lesson008Patterns,
  drills: build72Drills(lessonId: 'biblical_lesson_008', patterns: lesson008Patterns),
  challenge: const LessonChallenge(
    id: 'decode_king_route',
    promptPt: 'Decifre שִׂימָה־לָּנוּ מֶלֶךְ e depois explique ἀπὸ ἀνατολῶν → εἰς Ἱεροσόλυμα.',
    answer: 'שִׂימָה־לָּנוּ מֶלֶךְ = “estabelece para nós um rei”. ἀπὸ ἀνατολῶν marca origem “do oriente”; εἰς Ἱεροσόλυμα marca destino “para Jerusalém”.',
    hintPt: 'Use as estruturas 01, 02, 09, 11 e 12.',
  ),
);