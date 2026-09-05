import 'package:flutter/material.dart';

import '../content/player_progression.dart';
import '../progress/biblical_progress.dart';
import 'learning_analytics_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _green = Color(0xFF15803D);
const _muted = Color(0xFF64748B);

class PlayerProgressScreen extends StatefulWidget {
  const PlayerProgressScreen({
    super.key,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
  });

  final BiblicalProgressStore progressStore;

  @override
  State<PlayerProgressScreen> createState() => _PlayerProgressScreenState();
}

class _PlayerProgressScreenState extends State<PlayerProgressScreen> {
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

  @override
  Widget build(BuildContext context) {
    final progress = _progress;
    if (progress == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final metrics = buildPlayerProgressMetrics(progress);
    final history = progress.practiceSessions.reversed.take(12).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('PLAYER PROGRESSION'),
        actions: [
          IconButton(
            tooltip: 'Learning Analytics',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => LearningAnalyticsScreen(
                  progress: progress,
                  progressStore: widget.progressStore,
                ),
              ),
            ),
            icon: const Icon(Icons.insights_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          _RankCard(progress: progress, metrics: metrics),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _MetricCard(label: 'XP', value: '${progress.xp}'),
              _MetricCard(label: 'STREAK', value: '${progress.streakDays}d'),
              _MetricCard(
                label: 'SESSÕES',
                value: '${metrics.sessionsCompleted}',
              ),
              _MetricCard(
                label: 'ACURÁCIA 7',
                value: '${metrics.averageAccuracyLast7}%',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _DailyGoalCard(completed: metrics.dailyGoalCompleted),
          const SizedBox(height: 24),
          const _SectionTitle('MASTERY'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MasteryTile(
                  label: 'INICIADO',
                  value: metrics.masteryOneCount,
                  detail: 'mastery ≥ 1',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MasteryTile(
                  label: 'CONSOLIDADO',
                  value: metrics.masteryThreeCount,
                  detail: 'mastery ≥ 3',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MasteryTile(
                  label: 'MÁXIMO',
                  value: metrics.masteryFiveCount,
                  detail: 'mastery = 5',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(child: _SectionTitle('CONQUISTAS')),
              Text(
                '${metrics.unlockedAchievementCount}/${metrics.achievements.length}',
                style: const TextStyle(
                  color: _blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final achievement in metrics.achievements)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _AchievementTile(achievement: achievement),
            ),
          const SizedBox(height: 20),
          const _SectionTitle('HISTÓRICO DE SESSÕES'),
          const SizedBox(height: 10),
          if (history.isEmpty)
            const Card(
              elevation: 0,
              child: ListTile(
                leading: Icon(Icons.history_rounded, color: _blue),
                title: Text(
                  'Nenhuma sessão concluída ainda.',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text('Conclua uma Daily Session para iniciar o histórico.'),
              ),
            )
          else
            for (final session in history)
              Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFEFF6FF),
                    foregroundColor: _blue,
                    child: Text('${session.accuracy}%'),
                  ),
                  title: Text(
                    '${session.itemCount} itens · +${session.xpGained} XP',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    '${_dateLabel(session.completedAt)} · mastery +${session.masteryImproved} · '
                    '${session.reviewCount}R/${session.newCount}N/${session.reinforcementCount}F',
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

String _dateLabel(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$day/$month · $hour:$minute';
}

class _RankCard extends StatelessWidget {
  const _RankCard({required this.progress, required this.metrics});

  final BiblicalProgressSnapshot progress;
  final PlayerProgressMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _ink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RANK DE APRENDIZAGEM',
            style: TextStyle(
              color: _gold,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'NÍVEL ${metrics.rank.level} · ${metrics.rank.title}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: metrics.rankProgress,
            minHeight: 9,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: Colors.white.withValues(alpha: .12),
          ),
          const SizedBox(height: 8),
          Text(
            metrics.nextRank == null
                ? '${progress.xp} XP · rank máximo atual'
                : '${progress.xp} XP · faltam ${metrics.xpToNextRank} XP para ${metrics.nextRank!.title}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _DailyGoalCard extends StatelessWidget {
  const _DailyGoalCard({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: completed ? const Color(0xFFECFDF3) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: completed ? _green : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            completed ? Icons.verified_rounded : Icons.radio_button_unchecked,
            color: completed ? _green : _muted,
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'META DIÁRIA · DAILY SESSION',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 3),
                Text(
                  completed
                      ? 'Concluída hoje. O foco agora é consistência, não volume.'
                      : 'Conclua uma Daily Session para fechar a meta de hoje.',
                  style: const TextStyle(color: _muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 112),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _muted,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _ink,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _MasteryTile extends StatelessWidget {
  const _MasteryTile({
    required this.label,
    required this.value,
    required this.detail,
  });

  final String label;
  final int value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              color: _blue,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900),
          ),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _muted, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({required this.achievement});

  final PlayerAchievement achievement;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(
          achievement.unlocked
              ? Icons.emoji_events_rounded
              : Icons.lock_outline_rounded,
          color: achievement.unlocked ? _gold : _muted,
        ),
        title: Text(
          achievement.title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: achievement.unlocked ? _ink : _muted,
          ),
        ),
        subtitle: Text(achievement.description),
        trailing: achievement.unlocked
            ? const Icon(Icons.check_circle_rounded, color: _green)
            : null,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _blue,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.4,
      ),
    );
  }
}
