import 'package:flutter/material.dart';

import '../content/learning_analytics.dart';
import '../content/smart_coach.dart';
import '../progress/biblical_progress.dart';
import 'daily_session_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _green = Color(0xFF15803D);
const _muted = Color(0xFF64748B);

class SmartCoachScreen extends StatefulWidget {
  const SmartCoachScreen({
    super.key,
    required this.initialProgress,
    required this.progressStore,
  });

  final BiblicalProgressSnapshot initialProgress;
  final BiblicalProgressStore progressStore;

  @override
  State<SmartCoachScreen> createState() => _SmartCoachScreenState();
}

class _SmartCoachScreenState extends State<SmartCoachScreen> {
  late BiblicalProgressSnapshot _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress;
  }

  Future<void> _startSession(SmartCoachRecommendation recommendation) async {
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
    final recommendation = buildSmartCoachRecommendation(_progress);
    final outcome = buildLatestSmartCoachOutcome(_progress);
    final lessons = recommendation.lessonNumbers
        .map((number) => 'Lesson ${number.toString().padLeft(3, '0')}')
        .join(' · ');

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('SMART COACH'),
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
                  'PRESCRIÇÃO DE HOJE',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recommendation.focusLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    height: 1.12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lessons,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  recommendation.personalized
                      ? 'O foco foi derivado do idioma mais frágil, do modo cognitivo mais frágil dentro dele e das Lessons desbloqueadas onde esse padrão aparece com menor mastery.'
                      : 'Ainda não há dados suficientes para personalização. O Coach começa pela Lesson ativa e usa a sessão para formar uma linha de base real.',
                  style: const TextStyle(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _MetricCard(
                label: 'MASTERY',
                value: recommendation.personalized
                    ? '${recommendation.averageMastery.toStringAsFixed(1)}/5'
                    : 'BASE',
              ),
              _MetricCard(
                label: 'TENTADOS',
                value: '${recommendation.attempted}',
              ),
              _MetricCard(
                label: 'VENCIDOS',
                value: '${recommendation.dueReviews}',
              ),
            ],
          ),
          if (outcome != null) ...[
            const SizedBox(height: 22),
            _OutcomeCard(outcome: outcome),
          ],
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMO A SESSÃO É MONTADA',
                  style: TextStyle(
                    color: _blue,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  '1. Revisões vencidas entram primeiro.\n'
                  '2. O Coach prioriza drills já conhecidos do modo e idioma prescritos.\n'
                  '3. Apenas Lessons desbloqueadas entram no foco.\n'
                  '4. Se faltarem itens, a Daily Session canônica completa as vagas.\n'
                  '5. XP, retry, mastery, histórico e spaced repetition continuam no mesmo motor.\n'
                  '6. Ao concluir, o Coach compara mastery antes/depois e recalcula a próxima decisão.',
                  style: TextStyle(
                    color: _ink,
                    height: 1.55,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () => _startSession(recommendation),
            style: FilledButton.styleFrom(
              backgroundColor: _blue,
              padding: const EdgeInsets.symmetric(vertical: 17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(
              recommendation.personalized
                  ? 'INICIAR SESSÃO FOCADA'
                  : 'INICIAR SESSÃO DE BASE',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'O Smart Coach recomenda prática linguística. Ele não atribui autoridade espiritual, não produz conclusão teológica e não substitui a camada de exegese responsável do curso.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, height: 1.45, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _OutcomeCard extends StatelessWidget {
  const _OutcomeCard({required this.outcome});

  final SmartCoachOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final delta = outcome.masteryDelta;
    final deltaLabel = '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(2)}';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RESULTADO DA ÚLTIMA SESSÃO DO COACH',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            outcome.decisionLabel,
            style: const TextStyle(
              color: _ink,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SmallChip(
                label:
                    '${outcome.masteryBefore.toStringAsFixed(2)} → ${outcome.masteryAfter.toStringAsFixed(2)}',
              ),
              _SmallChip(label: 'Δ $deltaLabel'),
              _SmallChip(label: '${outcome.session.accuracy}% acurácia'),
              _SmallChip(
                label: '${outcome.session.coachFocusedItemCount} itens de foco',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            outcome.rationale,
            style: const TextStyle(color: _ink, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  const _SmallChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _ink,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
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
      constraints: const BoxConstraints(minWidth: 104),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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
