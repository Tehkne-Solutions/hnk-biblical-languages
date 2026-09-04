import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/course_registry.dart';
import 'package:hnk_biblical_languages/biblical_languages/content/mastery_map.dart';
import 'package:hnk_biblical_languages/biblical_languages/progress/biblical_progress.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/learning_analytics_screen.dart';
import 'package:hnk_biblical_languages/biblical_languages/ui/mastery_map_screen.dart';

BiblicalProgressSnapshot _mapSnapshot() {
  final lesson = implementedBiblicalLessons.first;
  final mode1 = lesson.drills.where((drill) => drill.variant == 1).toList();
  final mode2 = lesson.drills.where((drill) => drill.variant == 2).toList();
  return BiblicalProgressSnapshot(
    masteryByDrillId: {
      mode1[0].id: 1,
      mode1[1].id: 3,
      mode2[0].id: 5,
    },
    reviewDueAtByDrillId: {
      mode1[0].id: DateTime.utc(2026, 9, 4, 10),
    },
  );
}

void main() {
  test('mastery map is 12 lessons by 6 modes with canonical drill counts', () {
    final map = buildMasteryMap(
      _mapSnapshot(),
      now: DateTime.utc(2026, 9, 4, 12),
    );

    expect(map.rows, hasLength(12));
    expect(map.totalDrills, 864);
    for (final row in map.rows) {
      expect(row.cells, hasLength(6));
      expect(row.total, 72);
      for (final cell in row.cells) {
        expect(cell.total, 12);
      }
    }
  });

  test('mastery map averages attempted drills and keeps due review signal', () {
    final map = buildMasteryMap(
      _mapSnapshot(),
      now: DateTime.utc(2026, 9, 4, 12),
    );
    final row = map.rows.first;
    final mode1 = row.cells.firstWhere((cell) => cell.mode == 1);
    final mode2 = row.cells.firstWhere((cell) => cell.mode == 2);
    final mode3 = row.cells.firstWhere((cell) => cell.mode == 3);

    expect(map.totalAttempted, 3);
    expect(row.attempted, 3);
    expect(mode1.attempted, 2);
    expect(mode1.averageMastery, 2);
    expect(mode1.dueReviews, 1);
    expect(mode2.attempted, 1);
    expect(mode2.averageMastery, 5);
    expect(mode3.attempted, 0);
    expect(mode3.averageMastery, 0);
  });

  testWidgets('mastery map screen exposes the 12x6 learning view',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: MasteryMapScreen(progress: _mapSnapshot())),
    );

    expect(find.text('MASTERY MAP'), findsOneWidget);
    expect(find.text('12 LESSONS × 6 MODOS'), findsOneWidget);
    expect(find.text('LESSON 001'), findsOneWidget);
    expect(find.text('HE · Hebraico'), findsOneWidget);
  });

  testWidgets('learning analytics opens mastery map', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LearningAnalyticsScreen(progress: _mapSnapshot())),
    );

    await tester.tap(find.byTooltip('Mastery Map'));
    await tester.pumpAndSettle();

    expect(find.text('MASTERY MAP'), findsOneWidget);
    expect(find.text('12 LESSONS × 6 MODOS'), findsOneWidget);
  });
}
