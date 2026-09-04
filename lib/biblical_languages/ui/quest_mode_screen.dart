import 'package:flutter/material.dart';

import '../content/course_registry.dart';
import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _red = Color(0xFFE63946);

class QuestModeScreen extends StatefulWidget {
  const QuestModeScreen({
    super.key,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
  });

  final BiblicalProgressStore progressStore;

  @override
  State<QuestModeScreen> createState() => _QuestModeScreenState();
}

class _QuestModeScreenState extends State<QuestModeScreen> {
  BiblicalProgressSnapshot? _progress;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final progress = await widget.progressStore.load();
    if (!mounted) return;
    setState(() => _progress = progress);
  }

  bool _unlocked(BiblicalProgressSnapshot progress, BiblicalLesson lesson) {
    if (lesson.number == 1) return true;
    return progress.isCompleted(biblicalLessonId(lesson.number - 1));
  }

  void _openQuest(BiblicalLesson lesson) {
    var revealed = false;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUEST ${lesson.number.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: _red,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  lesson.challenge.promptPt,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 22,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Pista: ${lesson.challenge.hintPt}',
                  style: const TextStyle(color: Color(0xFF475569), height: 1.4),
                ),
                if (revealed) ...[
                  const Divider(height: 30),
                  Text(
                    lesson.challenge.answer,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 17,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: () => setModalState(() => revealed = !revealed),
                  style: FilledButton.styleFrom(backgroundColor: _blue),
                  child: Text(revealed ? 'OCULTAR RESPOSTA' : 'REVELAR RESPOSTA'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progress;
    if (progress == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('QUEST'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _gold,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12 FINAL QUESTS',
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Decodificação antes da resposta.',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final lesson in implementedBiblicalLessons)
            _QuestTile(
              lesson: lesson,
              unlocked: _unlocked(progress, lesson),
              completed: progress.isCompleted(lesson.id),
              onTap: () => _openQuest(lesson),
            ),
        ],
      ),
    );
  }
}

class _QuestTile extends StatelessWidget {
  const _QuestTile({
    required this.lesson,
    required this.unlocked,
    required this.completed,
    required this.onTap,
  });

  final BiblicalLesson lesson;
  final bool unlocked;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        enabled: unlocked,
        onTap: unlocked ? onTap : null,
        leading: CircleAvatar(
          backgroundColor: completed
              ? _gold
              : unlocked
                  ? _blue
                  : const Color(0xFFE2E8F0),
          foregroundColor: completed || unlocked ? Colors.white : const Color(0xFF64748B),
          child: completed
              ? const Icon(Icons.check_rounded)
              : Text(lesson.number.toString().padLeft(2, '0')),
        ),
        title: Text(
          lesson.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          completed
              ? 'Quest concluída com a Lesson'
              : unlocked
                  ? lesson.challenge.hintPt
                  : 'Conclua a Lesson anterior para desbloquear.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          unlocked ? Icons.chevron_right_rounded : Icons.lock_outline_rounded,
        ),
      ),
    );
  }
}
