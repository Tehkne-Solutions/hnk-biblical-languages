import 'package:flutter/material.dart';

import '../content/mastery_map.dart';
import '../progress/biblical_progress.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _red = Color(0xFFE63946);
const _muted = Color(0xFF64748B);

class MasteryMapScreen extends StatelessWidget {
  const MasteryMapScreen({
    super.key,
    required this.progress,
  });

  final BiblicalProgressSnapshot progress;

  @override
  Widget build(BuildContext context) {
    final map = buildMasteryMap(progress);
    final coverage = (map.coverage * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('MASTERY MAP'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '12 LESSONS × 6 MODOS',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$coverage% do mapa já recebeu prática.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${map.totalAttempted}/${map.totalDrills} drills tentados · '
                  'mastery médio ${map.averageMastery.toStringAsFixed(1)}/5 · '
                  '${map.dueReviews} revisões vencidas',
                  style: const TextStyle(color: Colors.white70, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _Legend(),
          const SizedBox(height: 24),
          for (final row in map.rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _LessonMasteryRow(row: row),
            ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        Chip(label: Text('HE · Hebraico')),
        Chip(label: Text('GR · Grego')),
        Chip(label: Text('EO · Esperanto')),
        Chip(label: Text('● revisão vencida')),
      ],
    );
  }
}

class _LessonMasteryRow extends StatelessWidget {
  const _LessonMasteryRow({required this.row});

  final MasteryMapRow row;

  @override
  Widget build(BuildContext context) {
    final lessonNumber = row.lesson.number.toString().padLeft(3, '0');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LESSON $lessonNumber',
                      style: const TextStyle(
                        color: _blue,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      row.lesson.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                row.attempted == 0
                    ? 'SEM PRÁTICA'
                    : '${row.averageMastery.toStringAsFixed(1)}/5',
                style: const TextStyle(
                  color: _blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: row.coverage,
            minHeight: 6,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: const Color(0xFFE2E8F0),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = (constraints.maxWidth - 10) / 3;
              return Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  for (final cell in row.cells)
                    SizedBox(
                      width: width,
                      child: _MasteryCell(cell: cell),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MasteryCell extends StatelessWidget {
  const _MasteryCell({required this.cell});

  final MasteryMapCell cell;

  @override
  Widget build(BuildContext context) {
    final active = cell.attempted > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
      decoration: BoxDecoration(
        color: active
            ? Color.lerp(
                const Color(0xFFFFF7DB),
                const Color(0xFFEFF6FF),
                cell.normalizedMastery,
              )
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: cell.dueReviews > 0 ? _red : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'M${cell.mode} · ${masteryTargetShortLabel(cell.target)}',
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  active ? cell.averageMastery.toStringAsFixed(1) : '—',
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${cell.attempted}/${cell.total}',
                  style: const TextStyle(color: _muted, fontSize: 9),
                ),
              ],
            ),
          ),
          if (cell.dueReviews > 0)
            Text(
              '●${cell.dueReviews}',
              style: const TextStyle(
                color: _red,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
        ],
      ),
    );
  }
}
