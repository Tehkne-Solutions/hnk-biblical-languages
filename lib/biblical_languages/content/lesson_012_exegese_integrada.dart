import '../models/biblical_lesson.dart';
import 'drill_factory.dart';
import 'lesson_001_bereshit_en_arche.dart';
import 'lesson_002_identidade.dart';
import 'lesson_009_greek.dart';
import 'lesson_009_hebrew.dart';
import 'lesson_012_patterns.dart';

final lesson012ExegeseIntegrada = BiblicalLesson(
  id: 'biblical_lesson_012',
  number: 12,
  title: 'PESHAT · EXĒGĒSIS · EXEGESE LINGUÍSTICA INTEGRADA',
  subtitle: 'Torá + Sabedoria + Evangelho · do texto ao limite interpretativo',
  objectivePt:
      'Aplicar um protocolo completo de análise a passagens já conhecidas, separando texto-fonte, lema, morfologia, sintaxe, semântica, tradução, inferência e limite interpretativo. O objetivo final não é produzir uma doutrina automática, mas demonstrar exatamente o que cada evidência linguística permite afirmar.',
  scriptures: [
    lesson001Scriptures.first,
    lesson002Scriptures.first,
    lesson009Hebrew,
    lesson001Scriptures.last,
    lesson009Greek,
  ],
  patterns: lesson012Patterns,
  drills: build72Drills(
    lessonId: 'biblical_lesson_012',
    patterns: lesson012Patterns,
  ),
  readingPlan: const [
    ReadingStage(
      number: 1,
      title: 'SOURCE',
      instructionPt:
          'Leia somente o texto-fonte e delimite a unidade que será analisada. Não consulte tradução ou CODEX ainda.',
      showPortuguese: false,
      showTransliteration: false,
      codexAllowed: false,
    ),
    ReadingStage(
      number: 2,
      title: 'MORPHOLOGY',
      instructionPt:
          'Abra o CODEX e identifique lema, pessoa, número, caso, estado e forma verbal antes de interpretar.',
      showPortuguese: false,
      showTransliteration: false,
      codexAllowed: true,
    ),
    ReadingStage(
      number: 3,
      title: 'SYNTAX',
      instructionPt:
          'Determine as funções sintáticas e as relações entre os termos. Não trate ordem de palavras como argumento suficiente.',
      showPortuguese: false,
      showTransliteration: false,
      codexAllowed: true,
    ),
    ReadingStage(
      number: 4,
      title: 'SEMANTICS',
      instructionPt:
          'Mapeie os sentidos lexicalmente possíveis e elimine apenas os que o contexto realmente exclui.',
      showPortuguese: false,
      showTransliteration: true,
      codexAllowed: true,
    ),
    ReadingStage(
      number: 5,
      title: 'TRANSLATION',
      instructionPt:
          'Compare a camada literal com a natural e registre cada decisão de tradução que altera ou explicita a estrutura.',
      showPortuguese: true,
      showTransliteration: true,
      codexAllowed: true,
    ),
    ReadingStage(
      number: 6,
      title: 'INFERENCE',
      instructionPt:
          'Formule apenas a inferência diretamente sustentada por texto, morfologia, sintaxe, semântica e discurso.',
      showPortuguese: true,
      showTransliteration: false,
      codexAllowed: true,
    ),
    ReadingStage(
      number: 7,
      title: 'LIMIT',
      instructionPt:
          'Escreva explicitamente o que a análise linguística não consegue provar sozinha e quais premissas adicionais seriam necessárias para uma conclusão exegética ou teológica mais ampla.',
      showPortuguese: true,
      showTransliteration: false,
      codexAllowed: true,
    ),
  ],
  challenge: const LessonChallenge(
    id: 'integrated_exegesis_final',
    promptPt:
        'Escolha אֶהְיֶה אֲשֶׁר אֶהְיֶה ou θεὸς ἦν ὁ λόγος e produza uma análise em sete etapas: SOURCE → MORPHOLOGY → SYNTAX → SEMANTICS → TRANSLATION → INFERENCE → LIMIT. A resposta perde validade se transformar a morfologia, sozinha, em conclusão teológica.',
    answer:
        'Uma resposta válida identifica primeiro a forma textual; faz o parsing correto; descreve a sintaxe; apresenta o campo semântico; distingue tradução literal e natural; formula apenas uma inferência sustentada pelos dados; e termina declarando o limite interpretativo. Em Êxodo 3:14, אֶהְיֶה permanece Qal imperfeito 1cs mesmo quando a tradução natural tradicional usa “EU SOU”. Em João 1:1c, ὁ λόγος funciona como sujeito e θεός como predicativo; a descrição sintática é evidência linguística, mas a formulação de uma doutrina completa exige argumentos além do parsing isolado.',
    hintPt:
        'Use as estruturas 01–12 como checklist. Se uma frase não puder ser ligada a uma evidência textual explícita, marque-a como inferência ou interpretação.',
  ),
);
