import 'package:flutter/material.dart';

import '../content/course_registry.dart';
import '../content/daily_session_factory.dart';
import '../content/drill_factory.dart';
import '../content/drill_practice_factory.dart';
import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'biblical_lesson_screen.dart';
import 'daily_session_screen.dart';
import 'drill_practice_screen.dart';
import 'player_progress_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _red = Color(0xFFE63946);

class DrillModeScreen extends StatefulWidget {
  const DrillModeScreen({
    super.key,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
  });

  final BiblicalProgressStore progressStore;

  @override
  State<DrillModeScreen> createState() => _DrillModeScreenState();
}

class _DrillModeScreenState extends State<DrillModeScreen> {
  BiblicalProgressSnapshot? _progress;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final progress = await widget.progressStore.load();
    if (!mounted) return;
    setState(() => _progress = progress);
  }

  BiblicalLesson _resumeLesson(BiblicalProgressSnapshot progress) {
    for (final lesson in implementedBiblicalLessons) {
      if (!progress.isCompleted(lesson.id)) return lesson;
    }
    return implementedBiblicalLessons.last;
  }

  Future<void> _openPlayerProgress() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PlayerProgressScreen(progressStore: widget.progressStore),
      ),
    );
    await _reload();
  }

  Future<void> _openDailySession(
    DailySessionPlan plan,
    BiblicalProgressSnapshot progress,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DailySessionScreen(
          plan: plan,
          progressStore: widget.progressStore,
          initialProgress: progress,
        ),
      ),
    );
    await _reload();
  }

  Future<void> _openPractice(
    BiblicalLesson lesson,
    BiblicalProgressSnapshot progress, {
    int? zeroBasedIndex,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DrillPracticeScreen(
          lesson: lesson,
          initialIndex: zeroBasedIndex ?? progress.drillPositionFor(lesson.id),
          progressStore: widget.progressStore,
          initialProgress: progress,
        ),
      ),
    );
    await _reload();
  }

  Future<void> _openLesson(
    BiblicalLesson lesson,
    BiblicalProgressSnapshot progress,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BiblicalLessonScreen(
          lesson: lesson,
          progressStore: widget.progressStore,
          initialProgress: progress,
        ),
      ),
    );
    await _reload();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progress;
    if (progress == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final lesson = _resumeLesson(progress);
    final position = progress.drillPositionFor(lesson.id) + 1;
    final completed = progress.completedLessonIds.length;
    final reviewQueue = buildDueReviewQueue(progress);
    final dailyPlan = buildDailySessionPlan(progress);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('DRILL'),
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Player Progression',
            onPressed: _openPlayerProgress,
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MetricCard(label: 'XP', value: '${progress.xp}', icon: Icons.bolt_rounded),
              _MetricCard(
                label: 'STREAK',
                value: '${progress.streakDays} d',
                icon: Icons.local_fire_department_rounded,
              ),
              _MetricCard(
                label: 'REVISÕES',
                value: '${reviewQueue.length}',
                icon: Icons.replay_circle_filled_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                  'DAILY SESSION 12',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Doze decisões. Revisar primeiro. Avançar depois.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  '${dailyPlan.reviewCount} revisão · ${dailyPlan.newCount} novo · ${dailyPlan.reinforcementCount} reforço',
                  style: const TextStyle(color: Colors.white70, height: 1.45),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: dailyPlan.items.isEmpty
                      ? null
                      : () => _openDailySession(dailyPlan, progress),
                  style: FilledButton.styleFrom(backgroundColor: _blue),
                  icon: const Icon(Icons.today_rounded),
                  label: Text('INICIAR ${dailyPlan.items.length}/12'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PRÁTICA LIVRE',
                  style: TextStyle(
                    color: _blue,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  completed == implementedBiblicalLessons.length
                      ? 'Curso concluído. Continue consolidando mastery.'
                      : 'Lesson ${lesson.number.toString().padLeft(3, '0')} · ${lesson.title} · Drill $position/${lesson.drills.length}',
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 17,
                    height: 1.35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _openPractice(lesson, progress),
                      style: FilledButton.styleFrom(backgroundColor: _blue),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('RETOMAR PRÁTICA'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openLesson(lesson, progress),
                      icon: const Icon(Icons.menu_book_rounded),
                      label: const Text('ESTUDAR LESSON'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'FILA DE REVISÃO',
                  style: TextStyle(
                    color: _blue,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              if (reviewQueue.isNotEmpty)
                Text(
                  '${reviewQueue.length} vencida${reviewQueue.length == 1 ? '' : 's'}',
                  style: const TextStyle(color: _red, fontWeight: FontWeight.w800),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (reviewQueue.isEmpty)
            const Card(
              elevation: 0,
              child: ListTile(
                leading: Icon(Icons.check_circle_rounded, color: _blue),
                title: Text(
                  'Nenhuma revisão vencida agora.',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text('Os acertos retornam em 1, 3, 7, 14 e 30 dias conforme o mastery.'),
              ),
            )
          else
            for (final entry in reviewQueue.take(8))
              Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFFFF1F2),
                    foregroundColor: _red,
                    child: Text('${entry.zeroBasedIndex + 1}'),
                  ),
                  title: Text(
                    'Lesson ${entry.lesson.number.toString().padLeft(3, '0')} · Drill ${entry.zeroBasedIndex + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text('Mastery ${progress.masteryFor(entry.drill.id)}/5 · revisão disponível'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _openPractice(
                    entry.lesson,
                    progress,
                    zeroBasedIndex: entry.zeroBasedIndex,
                  ),
                ),
              ),
          const SizedBox(height: 24),
          const Text(
            '6 MODOS COGNITIVOS',
            style: TextStyle(
              color: _blue,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < biblicalDrillTasks.length; i++)
            Card(
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFEFF6FF),
                  foregroundColor: _blue,
                  child: Text('${i + 1}'),
                ),
                title: Text(
                  biblicalDrillTasks[i],
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 104),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _blue, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              Text(value, style: const TextStyle(color: _ink, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }
}
