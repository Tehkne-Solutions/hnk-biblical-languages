import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/biblical_languages_catalog_screen.dart';

BiblicalProgressSnapshot _completedThrough11() {
  var snapshot = const BiblicalProgressSnapshot();
  for (var number = 1; number <= 11; number++) {
    snapshot = snapshot.completeLesson(
      biblicalLessonId(number),
      timestamp: DateTime.utc(2026, 9, 4),
    );
  }
  return snapshot;
}

Future<void> _scrollUntil(
  WidgetTester tester,
  Finder finder, {
  double delta = 600,
}) async {
  await tester.scrollUntilVisible(
    finder,
    delta,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('student can complete Lesson 012 and finish all 12 levels',
      (tester) async {
    final store = MemoryBiblicalProgressStore(_completedThrough11());

    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesCatalogScreen(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();

    await _scrollUntil(tester, find.text('Exegese Linguística Integrada'));
    await tester.tap(find.text('Exegese Linguística Integrada'));
    await tester.pumpAndSettle();

    expect(find.text('Lesson 012 · Plano'), findsOneWidget);
    await _scrollUntil(tester, find.text('INICIAR ANÁLISE'), delta: 320);
    await tester.tap(find.text('INICIAR ANÁLISE'));
    await tester.pumpAndSettle();

    expect(
      find.text('PESHAT · EXĒGĒSIS · EXEGESE LINGUÍSTICA INTEGRADA'),
      findsOneWidget,
    );

    await _scrollUntil(tester, find.text('Revelar resposta'), delta: 900);
    await tester.tap(find.text('Revelar resposta'));
    await tester.pumpAndSettle();

    expect(find.text('Concluir Lesson 012'), findsOneWidget);
    await _scrollUntil(
      tester,
      find.text('Concluir Lesson 012'),
      delta: 320,
    );
    await tester.tap(find.text('Concluir Lesson 012'));
    await tester.pumpAndSettle();

    expect(store.snapshot.isCompleted('biblical_lesson_012'), isTrue);
    expect(store.snapshot.completedLessonIds, hasLength(12));
    expect(store.snapshot.drillPositionFor('biblical_lesson_012'), 71);
    expect(find.text('Lesson concluída'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    const summary =
        '12 de 12 Lessons implementadas concluídas · 12 níveis no mapa total.';
    await _scrollUntil(tester, find.text(summary), delta: -600);
    expect(find.text(summary), findsOneWidget);
  });
}
