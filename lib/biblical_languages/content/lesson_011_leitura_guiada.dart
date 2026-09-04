import '../models/biblical_lesson.dart';
import 'drill_factory.dart';
import 'lesson_001_bereshit_en_arche.dart';
import 'lesson_003_ser_e_existir.dart';
import 'lesson_007_greek.dart';
import 'lesson_011_greek.dart';
import 'lesson_011_hebrew.dart';
import 'lesson_011_patterns.dart';

final lesson011LeituraGuiada = BiblicalLesson(
  id: 'biblical_lesson_011',
  number: 11,
  title: 'MIQRA · ANAGNŌSIS · LEITURA BÍBLICA GUIADA',
  subtitle: 'Gênesis 1–3 + João 1 · checkpoints progressivos de leitura',
  objectivePt: 'Passar de reconhecimento assistido para leitura source-first usando blocos selecionados e já validados de Gênesis 1–3 e João 1, reduzindo Português e transliteração até consultar o CODEX apenas depois da tentativa própria.',
  scriptures: [
    lesson001Scriptures.first,
    lesson003Scriptures.first,
    lesson011Genesis27,
    lesson011Genesis39,
    lesson001Scriptures.last,
    lesson007Greek,
    lesson011John114,
  ],
  patterns: lesson011Patterns,
  drills: build72Drills(lessonId: 'biblical_lesson_011', patterns: lesson011Patterns),
  readingPlan: const [
    ReadingStage(number: 1, title: 'ASSISTED', instructionPt: 'Leia o texto-fonte com transliteração e Português visíveis. Identifique primeiro as âncoras conhecidas.', showPortuguese: true, showTransliteration: true, codexAllowed: true),
    ReadingStage(number: 2, title: 'BRIDGE OFF', instructionPt: 'Desligue o Português e recupere o sentido por Esperanto, transliteração e formas já estudadas.', showPortuguese: false, showTransliteration: true, codexAllowed: true),
    ReadingStage(number: 3, title: 'SOURCE FIRST', instructionPt: 'Desligue também a transliteração. Leia Hebraico/Grego primeiro e só então reconstrua o significado.', showPortuguese: false, showTransliteration: false, codexAllowed: true),
    ReadingStage(number: 4, title: 'COLD READ', instructionPt: 'Faça uma passagem sem CODEX. Marque mentalmente apenas o que você consegue reconhecer pelo contexto e morfologia.', showPortuguese: false, showTransliteration: false, codexAllowed: false),
    ReadingStage(number: 5, title: 'VERIFY', instructionPt: 'Reabra o CODEX e o Português para verificar hipóteses, corrigir leitura e registrar quais formas ainda precisam de drill.', showPortuguese: true, showTransliteration: false, codexAllowed: true),
  ],
  challenge: const LessonChallenge(
    id: 'guided_reading_chain',
    promptPt: 'Sem Português e sem transliteração, conecte בְּרֵאשִׁית → וַיִּיצֶר → אַיֶּכָּה e Ἐν ἀρχῇ → ζωὴ → σὰρξ ἐγένετο em uma leitura resumida.',
    answer: 'A sequência revisa criação → formação do humano → pergunta “onde estás?” em Gênesis; e princípio → vida/luz → o Logos tornou-se carne em João. A resposta deve vir da leitura das formas, não de decorar uma tradução única.',
    hintPt: 'Use as estruturas 01, 04, 07, 08, 09 e os cinco Reading Stages.',
  ),
);