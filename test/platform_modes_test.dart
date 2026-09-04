import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/biblical_library.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/biblical_languages_platform_shell.dart';

Future<void> _scrollUntil(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    420,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  test('canonical scripture library deduplicates reused passages', () {
    final passages = buildCanonicalScriptureLibrary();
    final ids = passages.map((passage) => passage.id).toList();
    expect(ids, isNotEmpty);
    expect(ids.toSet(), hasLength(ids.length));

    final codex = buildCanonicalCodexIndex();
    expect(codex, isNotEmpty);
    expect(codex.any((entry) => entry.token.surface.contains('λόγος')), isTrue);
    expect(codex.any((entry) => entry.token.lemma.contains('היה')), isTrue);
  });

  testWidgets('platform shell exposes five functional modes', (tester) async {
    final store = MemoryBiblicalProgressStore();
    await tester.pumpWidget(
      MaterialApp(
        home: BiblicalLanguagesPlatformShell(progressStore: store),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('OS 12 NÍVEIS'), findsOneWidget);

    await tester.tap(find.text('Drill'));
    await tester.pumpAndSettle();
    expect(find.text('RETOMAR PRÁTICA'), findsOneWidget);
    await _scrollUntil(tester, find.text('6 MODOS COGNITIVOS'));
    expect(find.text('6 MODOS COGNITIVOS'), findsOneWidget);

    await tester.tap(find.text('Codex'));
    await tester.pumpAndSettle();
    expect(find.text('LÉXICO · LEMA · MORFOLOGIA · PROVENIÊNCIA'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'λόγος');
    await tester.pumpAndSettle();
    expect(find.textContaining('logos'), findsWidgets);

    await tester.tap(find.text('Scripture'));
    await tester.pumpAndSettle();
    expect(find.text('BIBLIOTECA CANÔNICA DO CURSO'), findsOneWidget);

    await tester.tap(find.text('Quest'));
    await tester.pumpAndSettle();
    expect(find.text('12 FINAL QUESTS'), findsOneWidget);

    await tester.tap(find.text('Academy'));
    await tester.pumpAndSettle();
    expect(find.text('OS 12 NÍVEIS'), findsOneWidget);
  });
}
