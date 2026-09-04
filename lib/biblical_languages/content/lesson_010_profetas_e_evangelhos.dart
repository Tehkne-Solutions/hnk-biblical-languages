import '../models/biblical_lesson.dart';
import 'drill_factory.dart';
import 'lesson_010_greek.dart';
import 'lesson_010_hebrew.dart';
import 'lesson_010_patterns.dart';

final lesson010ProfetasEEvangelhos = BiblicalLesson(
  id: 'biblical_lesson_010',
  number: 10,
  title: 'QOL · PHŌNĒ · PROFETAS E EVANGELHOS',
  subtitle: 'Isaías 40:3 + Marcos 1:2–3 · voz, citação e preparação do caminho',
  objectivePt: 'Reconhecer discurso profético, imperativos e marcadores de citação, comparando Isaías 40:3 com seu reaproveitamento em Marcos sem ocultar a natureza composta de Marcos 1:2–3.',
  scriptures: const [lesson010Hebrew, lesson010Greek],
  patterns: lesson010Patterns,
  drills: build72Drills(lessonId: 'biblical_lesson_010', patterns: lesson010Patterns),
  challenge: const LessonChallenge(
    id: 'decode_prophetic_quote',
    promptPt: 'Decifre קוֹל קוֹרֵא בַּמִּדְבָּר פַּנּוּ e depois explique por que Marcos 1:2–3 é tratado como citação composta.',
    answer: 'קוֹל קוֹרֵא בַּמִּדְבָּר פַּנּוּ = “voz de alguém clamando: no deserto, preparem...”. Marcos 1:3 corresponde diretamente a Isaías 40:3; o material de Marcos 1:2 também ecoa outros textos proféticos/da Torá.',
    hintPt: 'Use as estruturas 01–05, 09, 11 e 12.',
  ),
);