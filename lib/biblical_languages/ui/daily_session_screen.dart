import 'package:flutter/material.dart';

import '../content/daily_session_factory.dart';
import '../content/drill_practice_factory.dart';
import '../progress/biblical_progress.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _red = Color(0xFFE63946);
const _green = Color(0xFF15803D);

class DailySessionScreen extends StatefulWidget {
  const DailySessionScreen({
    super.key,
    required this.plan,
    required this.progressStore,
    required this.initialProgress,
  });

  final DailySessionPlan plan;
  final BiblicalProgressStore progressStore;
  final BiblicalProgressSnapshot initialProgress;

  @override
  State<DailySessionScreen> createState() => _DailySessionScreenState();
}

class _DailySessionScreenState extends State<DailySessionScreen> {
  late BiblicalProgressSnapshot _progress;
  late final int _startXp;
  late final Map<String, int> _startMastery;
  int _sessionIndex = 0;
  int _attempts = 0;
  int _correctAttempts = 0;
  String? _selected;
  bool? _correct;
  bool _finished = false;

  DailySessionItem get item => widget.plan.items[_sessionIndex];

  DrillPracticeQuestion get question => buildDrillPracticeQuestion(
        lesson: item.lesson,
        drill: item.drill,
      );

  @override
  void initState() {
    super.initState();
    assert(widget.plan.items.isNotEmpty);
    _progress = widget.initialProgress;
    _startXp = _progress.xp;
    _startMastery = {
      for (final sessionItem in widget.plan.items)
        sessionItem.drill.id: _progress.masteryFor(sessionItem.drill.id),
    };
  }

  Future<void> _answer(String option) async {
    if (_correct != null) return;
    final isCorrect = option == question.correctAnswer;
    final next = _progress.recordDrillResult(
      lessonId: item.lesson.id,
      drillId: item.drill.id,
      zeroBasedIndex: item.zeroBasedIndex,
      correct: isCorrect,
    );
    await widget.progressStore.save(next);
    if (!mounted) return;
    setState(() {
      _selected = option;
      _correct = isCorrect;
      _attempts += 1;
      if (isCorrect) _correctAttempts += 1;
      _progress = next;
    });
  }

  void _continue() {
    if (_correct == false) {
      setState(() {
        _selected = null;
        _correct = null;
      });
      return;
    }

    if (_sessionIndex == widget.plan.items.length - 1) {
      setState(() => _finished = true);
      return;
    }

    setState(() {
      _sessionIndex += 1;
      _selected = null;
      _correct = null;
    });
  }

  int get _accuracy =>
      _attempts == 0 ? 0 : ((_correctAttempts / _attempts) * 100).round();

  int get _masteryImproved => widget.plan.items.where((sessionItem) {
        final before = _startMastery[sessionItem.drill.id] ?? 0;
        return _progress.masteryFor(sessionItem.drill.id) > before;
      }).length;

  @override
  Widget build(BuildContext context) {
    if (_finished) return _buildSummary(context);

    final current = item;
    final currentQuestion = question;
    final answered = _correct != null;
    final mastery = _progress.masteryFor(current.drill.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('DAILY SESSION 12'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 36),
          children: [
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (_sessionIndex + 1) / widget.plan.items.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_sessionIndex + 1}/${widget.plan.items.length}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetricChip(label: '${_progress.xp - _startXp} XP sessão'),
                _MetricChip(label: 'Mastery $mastery/5'),
                _MetricChip(label: _kindLabel(current.kind)),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LESSON ${current.lesson.number.toString().padLeft(3, '0')} · DRILL ${current.zeroBasedIndex + 1}',
                    style: const TextStyle(
                      color: _gold,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentQuestion.promptPt,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentQuestion.cueLabel.toUpperCase(),
                          style: const TextStyle(
                            color: _blue,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          currentQuestion.cueText,
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              currentQuestion.targetLabel.toUpperCase(),
              style: const TextStyle(
                color: _blue,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            for (final option in currentQuestion.options)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AnswerOption(
                  text: option,
                  selected: option == _selected,
                  correctAnswer:
                      answered && option == currentQuestion.correctAnswer,
                  wrongSelection:
                      answered && option == _selected && _correct == false,
                  onTap: answered ? null : () => _answer(option),
                ),
              ),
            if (answered) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _correct == true
                      ? const Color(0xFFECFDF3)
                      : const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _correct == true
                          ? 'CORRETO · +10 XP'
                          : 'REVISÃO AGENDADA · TENTE NOVAMENTE',
                      style: TextStyle(
                        color: _correct == true ? _green : _red,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currentQuestion.correctAnswer,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: _continue,
                style: FilledButton.styleFrom(
                  backgroundColor: _correct == true ? _blue : _red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _correct == true
                      ? (_sessionIndex == widget.plan.items.length - 1
                          ? 'VER RESUMO'
                          : 'PRÓXIMO')
                      : 'TENTAR DE NOVO',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final xpGained = _progress.xp - _startXp;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 560),
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  const Icon(Icons.verified_rounded, color: _gold, size: 58),
                  const SizedBox(height: 14),
                  const Text(
                    'SESSÃO CONCLUÍDA',
                    style: TextStyle(
                      color: _gold,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '12 contatos intencionais com o texto bíblico.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _SummaryMetric(label: 'XP', value: '+$xpGained'),
                      _SummaryMetric(label: 'ACURÁCIA', value: '$_accuracy%'),
                      _SummaryMetric(
                        label: 'MASTERY ↑',
                        value: '$_masteryImproved',
                      ),
                      _SummaryMetric(
                        label: 'STREAK',
                        value: '${_progress.streakDays}d',
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${widget.plan.reviewCount} revisão · ${widget.plan.newCount} novo · ${widget.plan.reinforcementCount} reforço',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 22),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(
                      backgroundColor: _blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 15,
                      ),
                    ),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('VOLTAR AO DRILL'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _kindLabel(DailySessionItemKind kind) {
  switch (kind) {
    case DailySessionItemKind.review:
      return 'REVISÃO';
    case DailySessionItemKind.newContent:
      return 'NOVO';
    case DailySessionItemKind.reinforcement:
      return 'REFORÇO';
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFE2E8F0)),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
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

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.text,
    required this.selected,
    required this.correctAnswer,
    required this.wrongSelection,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final bool correctAnswer;
  final bool wrongSelection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var border = const Color(0xFFCBD5E1);
    var background = Colors.white;
    if (correctAnswer) {
      border = _green;
      background = const Color(0xFFECFDF3);
    } else if (wrongSelection) {
      border = _red;
      background = const Color(0xFFFFF1F2);
    } else if (selected) {
      border = _blue;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: _ink,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
