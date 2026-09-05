import 'package:flutter/material.dart';

import '../content/learning_analytics.dart';
import '../content/learning_path.dart';
import '../content/smart_coach.dart';
import '../progress/biblical_progress.dart';
import 'daily_session_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _green = Color(0xFF15803D);
const _muted = Color(0xFF64748B);

class LearningPathScreen extends StatefulWidget {
  const LearningPathScreen({
    super.key,
    required this.initialProgress,
    required this.progressStore,
  });

  final BiblicalProgressSnapshot initialProgress;
  final BiblicalProgressStore progressStore;

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> {
  late BiblicalProgressSnapshot _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress;
  }

  Future<void> _trainCurrent(LearningPathStep step) async {
    final recommendation = recommendationForLearningPathStep(step);
    final plan = buildSmartCoachSession(_progress, recommendation);
    if (plan.items.isEmpty || !mounted) return;

    final masteryBefore = smartCoachFocusMastery(_progress, recommendation);
    final focusedItemCount = smartCoachFocusedItemCount(plan, recommendation);
    final previousSessionAt = _progress.practiceSessions.isEmpty
        ? null
        : _progress.practiceSessions.last.completedAt;

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DailySessionScreen(
          plan: plan,
          progressStore: widget.progressStore,
          initialProgress: _progress,
        ),
      ),
    );

    var refreshed = await widget.progressStore.load();
    final latestSessionAt = refreshed.practiceSessions.isEmpty
        ? null
        : refreshed.practiceSessions.last.completedAt;
    final completedNewSession =
        latestSessionAt != null && latestSessionAt != previousSessionAt;

    if (completedNewSession) {
      final masteryAfter = smartCoachFocusMastery(refreshed, recommendation);
      refreshed = refreshed.annotateLatestPracticeSessionWithCoach(
        baseline: !recommendation.personalized,
        targetKey: analyticsTargetKey(recommendation.target),
        mode: recommendation.mode,
        lessonNumbers: recommendation.lessonNumbers,
        focusedItemCount: focusedItemCount,
        masteryBefore: masteryBefore,
        masteryAfter: masteryAfter,
      );
      await widget.progressStore.save(refreshed);
    }

    if (!mounted) return;
    setState(() => _progress = refreshed);
  }

  @override
  Widget build(BuildContext context) {
    final path = buildLearningPathPlan(_progress);
    final latestOutcome = buildLatestSmartCoachOutcome(_progress);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('LEARNING PATH'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ROTA PARA MASTERY 5',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  path.complete
                      ? 'Material conhecido consolidado.'
                      : '${path.steps.length} checkpoints adaptativos',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    height: 1.12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  path.complete
                      ? 'Os modos já introduzidos estão em mastery 5 e sem revisões vencidas. Conteúdo novo continua entrando pela sequência canônica da Academy/Daily Session.'
                      : 'A rota usa mastery atual, revisões vencidas e Outcomes recentes do Smart Coach. Ela é recalculada depois de cada sessão; não é um cronograma rígido.',
                  style: const TextStyle(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _MetricCard(
                label: 'OUTCOMES',
                value: '${path.coachOutcomesAnalyzed}',
              ),
              _MetricCard(
                label: 'LESSONS ABERTAS',
                value: '${path.unlockedLessons}/12',
              ),
              _MetricCard(
                label: 'CHECKPOINTS',
                value: '${path.steps.length}',
              ),
            ],
          ),
          if (latestOutcome != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF3),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF86EFAC)),
              ),
              child: Text(
                'Último Outcome: ${latestOutcome.decisionLabel} · Δ ${latestOutcome.masteryDelta >= 0 ? '+' : ''}${latestOutcome.masteryDelta.toStringAsFixed(2)}. A rota abaixo já incorpora esse resultado.',
                style: const TextStyle(
                  color: _ink,
                  height: 1.45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
          const SizedBox(height: 22),
          if (path.complete)
            const _CompleteCard()
          else
            for (final step in path.steps) ...[
              _PathStepCard(
                step: step,
                onTrain: step.current ? () => _trainCurrent(step) : null,
              ),
              const SizedBox(height: 12),
            ],
          const SizedBox(height: 10),
          const Text(
            'A rota organiza prática linguística. Ela não antecipa conteúdo bíblico bloqueado, não substitui a ordem da Academy e não produz conclusão espiritual ou teológica.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, height: 1.45, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _PathStepCard extends StatelessWidget {
  const _PathStepCard({required this.step, required this.onTrain});

  final LearningPathStep step;
  final VoidCallback? onTrain;

  @override
  Widget build(BuildContext context) {
    final lessons = step.lessonNumbers
        .map((number) => 'L${number.toString().padLeft(3, '0')}')
        .join(' · ');
    final progress = (step.averageMastery / BiblicalProgressSnapshot.maxMastery)
        .clamp(0.0, 1.0);
    final deltaLabel = step.coachSessions == 0
        ? '—'
        : '${step.averageCoachDelta >= 0 ? '+' : ''}${step.averageCoachDelta.toStringAsFixed(2)}';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: step.current ? _blue : const Color(0xFFE2E8F0),
          width: step.current ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor:
                    step.current ? _blue : const Color(0xFFEFF6FF),
                foregroundColor: step.current ? Colors.white : _blue,
                child: Text('${step.order}'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.current ? 'CHECKPOINT ATUAL' : 'PRÓXIMO CHECKPOINT',
                      style: TextStyle(
                        color: step.current ? _blue : _muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      step.focusLabel,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (lessons.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        lessons,
                        style: const TextStyle(
                          color: _muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _TrendBadge(step.trendLabel),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 9,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${step.averageMastery.toStringAsFixed(1)}/5',
                style: const TextStyle(
                  color: _blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TinyChip('${step.attempted} introduzidos'),
              _TinyChip('${step.dueReviews} revisões'),
              _TinyChip('${step.coachSessions} outcomes'),
              _TinyChip('Δ médio $deltaLabel'),
            ],
          ),
          const SizedBox(height: 13),
          const Text(
            'CONDIÇÃO PARA AVANÇAR',
            style: TextStyle(
              color: _muted,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            step.advanceCondition,
            style: const TextStyle(color: _ink, height: 1.42),
          ),
          if (onTrain != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onTrain,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text(
                  'TREINAR CHECKPOINT ATUAL',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  const _TrendBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _muted,
          fontSize: 8,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _TinyChip extends StatelessWidget {
  const _TinyChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _muted,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _CompleteCard extends StatelessWidget {
  const _CompleteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      child: const Column(
        children: [
          Icon(Icons.verified_rounded, color: _green, size: 42),
          SizedBox(height: 10),
          Text(
            'ROTA ATUAL CONSOLIDADA',
            style: TextStyle(
              color: _ink,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Nenhum modo já introduzido precisa de checkpoint adicional agora. Continue a sequência canônica e responda às revisões quando vencerem.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, height: 1.45),
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
      constraints: const BoxConstraints(minWidth: 105),
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
          const SizedBox(height: 3),
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
