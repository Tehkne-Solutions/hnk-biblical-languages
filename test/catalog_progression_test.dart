import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/biblical_languages_catalog_screen.dart';

Future<void> _scrollTo(WidgetTester tester, String title) async {
  await tester.scrollUntilVisible(
    find.text(title),
    360,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

BiblicalProgressSnapshot _completedThrough(int lessonNumber) {
  var progress = const BiblicalProgressSnapshot();
  for (var number = 1; number <= lessonNumber; number++) {
    progress = progress.completeLesson(
      'biblical_lesson_${number.toString().padLeft(3, '0')}',
      timestamp: DateTime.utc(2026, 9, 4),
    );
  }
  return progress;
}

void main() {
  testWidgets('Lesson 004 unlocks only after Lessons 001–003 are completed',
      (tester) async {
    final store = MemoryBiblicalProgressStore(_completedThrough(3));

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollTo(tester, 'Casa e Família');

    expect(find.text('Casa e Família'), findsOneWidget);
    expect(find.text('DRILL 1 / 72'), findsWidgets);

    await tester.tap(find.text('Casa e Família'));
    await tester.pumpAndSettle();

    expect(find.text('BAYIT · OIKOS · CASA E FAMÍLIA'), findsOneWidget);
    expect(find.textContaining('Gênesis 12:1 + Lucas 1:27'), findsOneWidget);
  });

  testWidgets('Lesson 004 remains locked when Lesson 003 is incomplete',
      (tester) async {
    final store = MemoryBiblicalProgressStore(_completedThrough(2));

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollTo(tester, 'Casa e Família');

    final casa = find.text('Casa e Família');
    expect(casa, findsOneWidget);

    await tester.tap(casa);
    await tester.pumpAndSettle();

    expect(find.text('BAYIT · OIKOS · CASA E FAMÍLIA'), findsNothing);
  });

  testWidgets('Lesson 005 unlocks after Lessons 001–004 are completed',
      (tester) async {
    final store = MemoryBiblicalProgressStore(_completedThrough(4));

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollTo(tester, 'Tempo e Dias');

    expect(find.text('Tempo e Dias'), findsOneWidget);

    await tester.tap(find.text('Tempo e Dias'));
    await tester.pumpAndSettle();

    expect(find.text('YOM · KAIROS · TEMPO E DIAS'), findsOneWidget);
    expect(find.textContaining('Gênesis 1:5 + Marcos 1:15'), findsOneWidget);
  });

  testWidgets('Lesson 005 remains locked when Lesson 004 is incomplete',
      (tester) async {
    final store = MemoryBiblicalProgressStore(_completedThrough(3));

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollTo(tester, 'Tempo e Dias');

    final tempo = find.text('Tempo e Dias');
    expect(tempo, findsOneWidget);

    await tester.tap(tempo);
    await tester.pumpAndSettle();

    expect(find.text('YOM · KAIROS · TEMPO E DIAS'), findsNothing);
  });
}
