import 'package:flutter/material.dart';

import '../content/course_registry.dart';
import '../content/drill_factory.dart';
import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'biblical_lesson_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);

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

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('DRILL'),
        backgroundColor: _ink,
        foregroundColor: Colors.white,
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
                  'ACTIVE RECALL',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  completed == implementedBiblicalLessons.length
                      ? 'Curso concluído. Continue refinando a leitura.'
                      : 'Retome exatamente de onde parou.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Lesson ${lesson.number.toString().padLeft(3, '0')} · ${lesson.title}\nDrill $position / ${lesson.drills.length}',
                  style: const TextStyle(color: Colors.white70, height: 1.45),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => _openLesson(lesson, progress),
                  style: FilledButton.styleFrom(backgroundColor: _blue),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('RETOMAR DRILL'),
                ),
              ],
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
