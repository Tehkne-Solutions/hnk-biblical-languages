import 'package:flutter/material.dart';

import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';
import 'biblical_lesson_screen.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _canvas = Color(0xFFF8FAFC);

class BiblicalLessonPlanScreen extends StatelessWidget {
  const BiblicalLessonPlanScreen({
    super.key,
    required this.lesson,
    required this.progressStore,
    required this.initialProgress,
  });

  final BiblicalLesson lesson;
  final BiblicalProgressStore progressStore;
  final BiblicalProgressSnapshot initialProgress;

  @override
  Widget build(BuildContext context) {
    final isExegesis = lesson.number == 12;
    final eyebrow = isExegesis ? 'EXEGESIS PROTOCOL' : 'GUIDED READING';
    final heading = isExegesis
        ? 'Do texto ao limite interpretativo.'
        : 'Retire o apoio em etapas.';

    return Scaffold(
      backgroundColor: _canvas,
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: Text('Lesson ${lesson.number.toString().padLeft(3, '0')} · Plano'),
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
                Text(
                  eyebrow,
                  style: const TextStyle(
                    color: _gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  heading,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lesson.objectivePt,
                  style: const TextStyle(color: Colors.white70, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (final stage in lesson.readingPlan)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _StageCard(stage: stage),
            ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  settings: RouteSettings(
                    name: '/lesson/${lesson.number.toString().padLeft(3, '0')}/study',
                  ),
                  builder: (_) => BiblicalLessonScreen(
                    lesson: lesson,
                    progressStore: progressStore,
                    initialProgress: initialProgress,
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: _blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(Icons.menu_book_rounded),
            label: Text(isExegesis ? 'INICIAR ANÁLISE' : 'INICIAR LEITURA'),
          ),
        ],
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  const _StageCard({required this.stage});

  final ReadingStage stage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _blue,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              stage.number.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  stage.instructionPt,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    _StateChip(
                      label: 'PT',
                      enabled: stage.showPortuguese,
                    ),
                    _StateChip(
                      label: 'TRANSLIT',
                      enabled: stage.showTransliteration,
                    ),
                    _StateChip(
                      label: 'CODEX',
                      enabled: stage.codexAllowed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StateChip extends StatelessWidget {
  const _StateChip({required this.label, required this.enabled});

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: enabled ? const Color(0xFFEFF6FF) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label ${enabled ? 'ON' : 'OFF'}',
        style: TextStyle(
          color: enabled ? _blue : const Color(0xFF64748B),
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
