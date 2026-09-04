import '../models/biblical_lesson.dart';

const List<String> biblicalDrillTasks = [
  'Leia as quatro camadas em voz alta, sem traduzir durante a primeira passagem.',
  'Olhe para a forma bíblica e identifique o conceito antes de consultar o Português.',
  'Oculte o Português e recupere o significado pelas outras camadas.',
  'Oculte o Esperanto e reconstrua a língua-ponte a partir do conceito.',
  'Use a transliteração como pista e reconstrua mentalmente o texto bíblico.',
  'Faça tradução reversa: Português → Esperanto → forma bíblica-alvo.',
];

List<DrillItem> build72Drills({
  required String lessonId,
  required List<ComparativePattern> patterns,
}) {
  assert(patterns.length == 12);
  return <DrillItem>[
    for (var structureIndex = 0;
        structureIndex < patterns.length;
        structureIndex++)
      for (var variantIndex = 0;
          variantIndex < biblicalDrillTasks.length;
          variantIndex++)
        DrillItem(
          id: '${lessonId}_s${structureIndex + 1}_v${variantIndex + 1}',
          structure: structureIndex + 1,
          variant: variantIndex + 1,
          taskPt: biblicalDrillTasks[variantIndex],
          lines: patterns[structureIndex].lines,
        ),
  ];
}
