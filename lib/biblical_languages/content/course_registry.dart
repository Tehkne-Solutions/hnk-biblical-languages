import '../models/biblical_lesson.dart';
import 'lesson_001_bereshit_en_arche.dart';
import 'lesson_002_identidade.dart';
import 'lesson_003_ser_e_existir.dart';
import 'lesson_004_casa_e_familia.dart';
import 'lesson_005_tempo_e_dias.dart';
import 'lesson_006_corpo_e_acoes.dart';
import 'lesson_007_natureza_e_criacao.dart';
import 'lesson_008_reis_povos_lugares.dart';
import 'lesson_009_sabedoria_e_lei.dart';
import 'lesson_010_profetas_e_evangelhos.dart';

final List<BiblicalLesson> implementedBiblicalLessons = List.unmodifiable([
  lesson001BereshitEnArche,
  lesson002Identidade,
  lesson003SerEExistir,
  lesson004CasaEFamilia,
  lesson005TempoEDias,
  lesson006CorpoEAcoes,
  lesson007NaturezaECriacao,
  lesson008ReisPovosLugares,
  lesson009SabedoriaELei,
  lesson010ProfetasEEvangelhos,
]);

BiblicalLesson? biblicalLessonByNumber(int number) {
  if (number < 1 || number > implementedBiblicalLessons.length) return null;
  return implementedBiblicalLessons[number - 1];
}

String biblicalLessonId(int number) =>
    'biblical_lesson_${number.toString().padLeft(3, '0')}';
