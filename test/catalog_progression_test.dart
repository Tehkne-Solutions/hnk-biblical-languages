import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/biblical_languages_catalog_screen.dart';

Future<void> _scrollToLesson004(WidgetTester tester) async {
  await tester.scrollUntilVisible(
    find.text('Casa e Família'),
    360,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Lesson 004 unlocks only after Lessons 001–003 are completed',
      (tester) async {
    var progress = const BiblicalProgressSnapshot();
    progress = progress.completeLesson(
      'biblical_lesson_001',
      timestamp: DateTime.utc(2026, 9, 4),
    );
    progress = progress.completeLesson(
      'biblical_lesson_002',
      timestamp: DateTime.utc(2026, 9, 4),
    );
    progress = progress.completeLesson(
      'biblical_lesson_003',
      timestamp: DateTime.utc(2026, 9, 4),
    );

    final store = MemoryBiblicalProgressStore(progress);

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollToLesson004(tester);

    expect(find.text('Casa e Família'), findsOneWidget);
    expect(find.text('DRILL 1 / 72'), findsOneWidget);

    await tester.tap(find.text('Casa e Família'));
    await tester.pumpAndSettle();

    expect(find.text('BAYIT · OIKOS · CASA E FAMÍLIA'), findsOneWidget);
    expect(find.textContaining('Gênesis 12:1 + Lucas 1:27'), findsOneWidget);
  });

  testWidgets('Lesson 004 remains locked when Lesson 003 is incomplete',
      (tester) async {
    var progress = const BiblicalProgressSnapshot();
    progress = progress.completeLesson(
      'biblical_lesson_001',
      timestamp: DateTime.utc(2026, 9, 4),
    );
    progress = progress.completeLesson(
      'biblical_lesson_002',
      timestamp: DateTime.utc(2026, 9, 4),
    );

    final store = MemoryBiblicalProgressStore(progress);

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollToLesson004(tester);

    final casa = find.text('Casa e Família');
    expect(casa, findsOneWidget);
    expect(find.text('BLOQUEADO'), findsWidgets);

    await tester.tap(casa);
    await tester.pumpAndSettle();

    expect(find.text('BAYIT · OIKOS · CASA E FAMÍLIA'), findsNothing);
  });
}
