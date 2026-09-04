import 'package:flutter/material.dart';

import '../content/drill_practice_factory.dart';
import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _red = Color(0xFFE63946);
const _green = Color(0xFF15803D);

class DrillPracticeScreen extends StatefulWidget {
  const DrillPracticeScreen({
    super.key,
    required this.lesson,
    required this.initialIndex,
    required this.progressStore,
    required this.initialProgress,
  });

  final BiblicalLesson lesson;
  final int initialIndex;
  final BiblicalProgressStore progressStore;
  final BiblicalProgressSnapshot initialProgress;

  @override
  State<DrillPracticeScreen> createState() => _DrillPracticeScreenState();
}

class _DrillPracticeScreenState extends State<DrillPracticeScreen> {
  late BiblicalProgressSnapshot _progress;
  late int _index;
  String? _selected;
  bool? _correct;

  BiblicalLesson get lesson => widget.lesson;
  DrillItem get drill => lesson.drills[_index];
  DrillPracticeQuestion get question => buildDrillPracticeQuestion(
        lesson: lesson,
        drill: drill,
      );

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress;
    _index = widget.initialIndex.clamp(0, lesson.drills.length - 1).toInt();
  }

  Future<void> _answer(String option) async {
    if (_correct != null) return;
    final isCorrect = option == question.correctAnswer;
    final next = _progress.recordDrillResult(
      lessonId: lesson.id,
      drillId: drill.id,
      zeroBasedIndex: _index,
      correct: isCorrect,
    );
    await widget.progressStore.save(next);
    if (!mounted) return;
    setState(() {
      _selected = option;
      _correct = isCorrect;
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

    if (_index < lesson.drills.length - 1) {
      setState(() {
        _index += 1;
        _selected = null;
        _correct = null;
      });
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = question;
    final mastery = _progress.masteryFor(drill.id);
    final answered = _correct != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: Text(
          'DRILL · Lesson ${lesson.number.toString().padLeft(3, '0')}',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 36),
          children: [
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (_index + 1) / lesson.drills.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_index + 1}/${lesson.drills.length}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetricChip(label: '${_progress.xp} XP', icon: Icons.bolt_rounded),
                _MetricChip(
                  label: '${_progress.streakDays} dias',
                  icon: Icons.local_fire_department_rounded,
                ),
                _MetricChip(
                  label: 'Mastery $mastery/5',
                  icon: Icons.auto_graph_rounded,
                ),
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
                    'ESTRUTURA ${drill.structure} · MODO ${drill.variant}',
                    style: const TextStyle(
                      color: _gold,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
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
                  const SizedBox(height: 18),
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
                            height: 1.3,
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
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            for (final option in currentQuestion.options)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AnswerOption(
                  text: option,
                  selected: option == _selected,
                  correctAnswer: answered && option == currentQuestion.correctAnswer,
                  wrongSelection: answered && option == _selected && _correct == false,
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
                      _correct == true ? 'CORRETO · +10 XP' : 'REVISÃO AGENDADA',
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
                    if (currentQuestion.correctTransliteration != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        currentQuestion.correctTransliteration!,
                        style: const TextStyle(color: _blue),
                      ),
                    ],
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
                      ? (_index == lesson.drills.length - 1
                          ? 'ENCERRAR SESSÃO'
                          : 'PRÓXIMO DRILL')
                      : 'TENTAR DE NOVO',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: _blue),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFE2E8F0)),
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
    Color border = const Color(0xFFCBD5E1);
    Color background = Colors.white;
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
            height: 1.3,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
