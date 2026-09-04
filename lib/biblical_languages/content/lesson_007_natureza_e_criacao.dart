import '../models/biblical_lesson.dart';
import 'drill_factory.dart';
import 'lesson_007_greek.dart';
import 'lesson_007_hebrew.dart';
import 'lesson_007_patterns.dart';

final lesson007NaturezaECriacao = BiblicalLesson(
  id: 'biblical_lesson_007',
  number: 7,
  title: 'ERETZ · ZŌĒ · PHŌS · NATUREZA E CRIAÇÃO',
  subtitle: 'Gênesis 1:11–12 + João 1:3–5 · brotar, vida, luz e trevas',
  objectivePt: 'Ler descrição da criação distinguindo jussivo e realização narrativa no Hebraico, e reconhecer vida, luz, trevas e aspecto verbal no Grego sem forçar equivalências lexicais.',
  scriptures: const [lesson007Hebrew, lesson007Greek],
  patterns: lesson007Patterns,
  drills: build72Drills(lessonId: 'biblical_lesson_007', patterns: lesson007Patterns),
  challenge: const LessonChallenge(
    id: 'decode_creation_light',
    promptPt: 'Explique o movimento תַּדְשֵׁא → וַתּוֹצֵא e depois decifre τὸ φῶς ἐν τῇ σκοτίᾳ φαίνει.',
    answer: 'תַּדְשֵׁא convoca a terra a fazer brotar; וַתּוֹצֵא narra a realização. τὸ φῶς ἐν τῇ σκοτίᾳ φαίνει = “a luz brilha nas trevas”.',
    hintPt: 'Use as estruturas 01, 02 e 12.',
  ),
);