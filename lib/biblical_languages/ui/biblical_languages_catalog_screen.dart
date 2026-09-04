import 'package:flutter/material.dart';

import '../content/course_map.dart';
import '../content/course_registry.dart';
import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'biblical_lesson_plan_screen.dart';
import 'biblical_lesson_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _red = Color(0xFFE63946);
const _gold = Color(0xFFFFD166);
const _canvas = Color(0xFFF8FAFC);

class BiblicalLanguagesCatalogScreen extends StatefulWidget {
  const BiblicalLanguagesCatalogScreen({
    super.key,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
  });

  final BiblicalProgressStore progressStore;

  @override
  State<BiblicalLanguagesCatalogScreen> createState() =>
      _BiblicalLanguagesCatalogScreenState();
}

class _BiblicalLanguagesCatalogScreenState
    extends State<BiblicalLanguagesCatalogScreen> {
  BiblicalProgressSnapshot? _progress;

  int get _implemented => implementedBiblicalLessons.length;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final snapshot = await widget.progressStore.load();
    if (!mounted) return;
    setState(() => _progress = snapshot);
  }

  BiblicalLesson? _lesson(int number) => biblicalLessonByNumber(number);

  bool _unlocked(BiblicalProgressSnapshot progress, int number) {
    if (number == 1) return true;
    if (number > _implemented) return false;
    return progress.isCompleted(biblicalLessonId(number - 1));
  }

  Future<void> _open(int number) async {
    final progress = _progress;
    final lesson = _lesson(number);
    if (progress == null || lesson == null || !_unlocked(progress, number)) return;

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        settings: RouteSettings(
          name: '/lesson/${number.toString().padLeft(3, '0')}',
        ),
        builder: (_) => lesson.readingPlan.isNotEmpty
            ? BiblicalLessonPlanScreen(
                lesson: lesson,
                progressStore: widget.progressStore,
                initialProgress: progress,
              )
            : BiblicalLessonScreen(
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
      return const Scaffold(
        backgroundColor: _canvas,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final completedLessons = [
      for (var i = 1; i <= _implemented; i++)
        if (progress.isCompleted(biblicalLessonId(i))) i,
    ].length;

    return Scaffold(
      backgroundColor: _canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const _Brand(),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 48),
        children: [
          _Hero(
            completedLessons: completedLessons,
            implementedLessons: _implemented,
          ),
          const SizedBox(height: 22),
          const Text(
            'OS 12 NÍVEIS',
            style: TextStyle(
              color: _blue,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Da primeira letra à leitura exegética.',
            style: TextStyle(color: _ink, fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          const Text(
            'O mapa completo fica visível desde o início. Lessons implementadas desbloqueiam em sequência.',
            style: TextStyle(color: Color(0xFF64748B), height: 1.45),
          ),
          const SizedBox(height: 16),
          for (final level in biblicalLanguagesCourseMap)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _LevelCard(
                level: level,
                implemented: level.number <= _implemented,
                unlocked: _unlocked(progress, level.number),
                completed: progress.isCompleted(biblicalLessonId(level.number)),
                drillPosition: level.number <= _implemented
                    ? progress.drillPositionFor(biblicalLessonId(level.number)) + 1
                    : 0,
                onTap: () => _open(level.number),
              ),
            ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('HNK', style: TextStyle(color: _red, fontWeight: FontWeight.w900, fontSize: 18)),
        Text(
          'BIBLICAL LANGUAGES',
          style: TextStyle(color: _blue, fontWeight: FontWeight.w900, fontSize: 8, letterSpacing: 1.8),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({
    required this.completedLessons,
    required this.implementedLessons,
  });

  final int completedLessons;
  final int implementedLessons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: _ink, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PORTUGUÊS → ESPERANTO → HEBRAICO + GREGO → ESCRITURAS',
            style: TextStyle(color: _gold, fontSize: 11, height: 1.4, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text(
            'Aprenda a ler a arquitetura da Bíblia.',
            style: TextStyle(color: Colors.white, fontSize: 28, height: 1.08, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Text(
            '$completedLessons de $implementedLessons Lessons implementadas concluídas · 12 níveis no mapa total.',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: implementedLessons == 0
                  ? 0
                  : completedLessons / implementedLessons,
              minHeight: 8,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(_gold),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.level,
    required this.implemented,
    required this.unlocked,
    required this.completed,
    required this.drillPosition,
    required this.onTap,
  });

  final BiblicalCourseLevel level;
  final bool implemented;
  final bool unlocked;
  final bool completed;
  final int drillPosition;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = implemented && unlocked;
    final label = !implemented
        ? 'EM PRODUÇÃO'
        : completed
            ? 'CONCLUÍDO'
            : unlocked
                ? 'DRILL $drillPosition / 72'
                : 'BLOQUEADO';

    return Material(
      color: enabled ? Colors.white : const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: completed
                      ? _gold
                      : enabled
                          ? _blue
                          : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: completed
                    ? const Icon(Icons.check_rounded, color: _ink)
                    : Text(
                        level.number.toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: enabled ? Colors.white : const Color(0xFF64748B),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            level.title,
                            style: TextStyle(
                              color: enabled ? _ink : const Color(0xFF64748B),
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: completed
                                ? const Color(0xFF8A6415)
                                : enabled
                                    ? _red
                                    : const Color(0xFF94A3B8),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      level.anchor,
                      style: TextStyle(
                        color: enabled ? _blue : const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      level.focusPt,
                      style: TextStyle(
                        color: enabled ? const Color(0xFF475569) : const Color(0xFF94A3B8),
                        height: 1.38,
                      ),
                    ),
                    if (implemented) ...[
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: completed
                            ? 1.0
                            : (drillPosition / 72.0).clamp(0.0, 1.0).toDouble(),
                        minHeight: 5,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: AlwaysStoppedAnimation<Color>(completed ? _gold : _blue),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                enabled ? Icons.chevron_right_rounded : Icons.lock_outline_rounded,
                color: enabled ? _ink : const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
