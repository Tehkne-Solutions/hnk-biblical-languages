import 'package:flutter/material.dart';

import '../content/learning_analytics.dart';
import '../progress/biblical_progress.dart';
import 'mastery_map_screen.dart';
import 'smart_coach_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _muted = Color(0xFF64748B);

class LearningAnalyticsScreen extends StatelessWidget {
  const LearningAnalyticsScreen({
    super.key,
    required this.progress,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
  });

  final BiblicalProgressSnapshot progress;
  final BiblicalProgressStore progressStore;

  @override
  Widget build(BuildContext context) {
    final metrics = buildLearningAnalytics(progress);
    final weakestLanguage = metrics.weakestLanguage;
    final weakestMode = metrics.weakestMode;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('LEARNING ANALYTICS'),
        actions: [
          IconButton(
            tooltip: 'Smart Coach',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SmartCoachScreen(
                  initialProgress: progress,
                  progressStore: progressStore,
                ),
              ),
            ),
            icon: const Icon(Icons.psychology_alt_rounded),
          ),
          IconButton(
            tooltip: 'Mastery Map',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MasteryMapScreen(progress: progress),
              ),
            ),
            icon: const Icon(Icons.grid_view_rounded),
          ),
        ],
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
                  'FOCO RECOMENDADO',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  weakestLanguage == null
                      ? 'Pratique alguns drills para formar seu perfil.'
                      : '${weakestLanguage.label} · ${weakestMode?.label ?? 'modo ainda sem contraste'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  metrics.hasData
                      ? 'A recomendação usa mastery acumulado e revisões vencidas. Revisões continuam primeiro; conteúdo novo continua sequencial.'
                      : 'O Analytics V1 não cria telemetria extra: ele deriva o perfil do mesmo progresso canônico já salvo pelo DRILL.',
                  style: const TextStyle(color: Colors.white70, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('IDIOMAS-ALVO'),
          const SizedBox(height: 10),
          for (final language in metrics.languages)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _AnalyticsTile(metric: language),
            ),
          const SizedBox(height: 18),
          const _SectionTitle('6 MODOS COGNITIVOS'),
          const SizedBox(height: 10),
          for (final mode in metrics.modes)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _AnalyticsTile(metric: mode),
            ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'ADAPTAÇÃO DA DAILY SESSION: revisões vencidas mantêm prioridade absoluta. Conteúdo novo segue a Lesson ativa. Apenas a etapa de reforço usa o perfil de fraqueza para desempatar drills com mastery equivalente.',
              style: TextStyle(color: _ink, height: 1.45, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsTile extends StatelessWidget {
  const _AnalyticsTile({required this.metric});

  final LearningDimensionMetrics metric;

  @override
  Widget build(BuildContext context) {
    final normalized = metric.attempted == 0
        ? 0.0
        : (metric.averageMastery / BiblicalProgressSnapshot.maxMastery)
            .clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  metric.label,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                metric.attempted == 0
                    ? 'SEM DADOS'
                    : '${metric.averageMastery.toStringAsFixed(1)}/5',
                style: const TextStyle(
                  color: _blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          LinearProgressIndicator(
            value: normalized,
            minHeight: 7,
            borderRadius: BorderRadius.circular(99),
          ),
          const SizedBox(height: 8),
          Text(
            '${metric.attempted} drills tentados · ${metric.dueReviews} revisões vencidas',
            style: const TextStyle(color: _muted, fontSize: 12),
          ),
        ],
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
