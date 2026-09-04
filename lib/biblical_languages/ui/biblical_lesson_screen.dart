import 'package:flutter/material.dart';

import '../models/biblical_lesson.dart';
import '../progress/biblical_progress.dart';

const _ink = Color(0xFF0F172A);
const _paper = Color(0xFFF8FAFC);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);
const _red = Color(0xFFE63946);

class BiblicalLessonScreen extends StatefulWidget {
  const BiblicalLessonScreen({
    super.key,
    required this.lesson,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
    this.initialProgress = const BiblicalProgressSnapshot(),
  });

  final BiblicalLesson lesson;
  final BiblicalProgressStore progressStore;
  final BiblicalProgressSnapshot initialProgress;

  @override
  State<BiblicalLessonScreen> createState() => _BiblicalLessonScreenState();
}

class _BiblicalLessonScreenState extends State<BiblicalLessonScreen> {
  late BiblicalProgressSnapshot _progress;
  late BiblicalLearningPreferences _preferences;
  late int _drillIndex;
  bool _showAnswer = false;

  BiblicalLesson get lesson => widget.lesson;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress;
    _preferences = _progress.preferences;
    _drillIndex = lesson.drills.isEmpty
        ? 0
        : _progress
            .drillPositionFor(lesson.id)
            .clamp(0, lesson.drills.length - 1)
            .toInt();
  }

  Future<void> _save(BiblicalProgressSnapshot next) async {
    setState(() {
      _progress = next;
      _preferences = next.preferences;
    });
    await widget.progressStore.save(next);
  }

  Future<void> _setDrill(int index) async {
    if (lesson.drills.isEmpty) return;
    final next = index.clamp(0, lesson.drills.length - 1).toInt();
    setState(() => _drillIndex = next);
    await _save(_progress.saveDrillPosition(lesson.id, next));
  }

  Future<void> _setPreferences(BiblicalLearningPreferences value) async {
    await _save(_progress.withPreferences(value));
  }

  Future<void> _complete() async {
    var next = _progress;
    if (lesson.drills.isNotEmpty) {
      next = next.saveDrillPosition(lesson.id, lesson.drills.length - 1);
    }
    await _save(next.completeLesson(lesson.id));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lesson ${lesson.number.toString().padLeft(3, '0')} concluída.')),
    );
  }

  void _openCodex(ScripturePassage passage, ScriptureToken token) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CodexSheet(
        passage: passage,
        token: token,
        showTransliteration: _preferences.showTransliteration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completed = _progress.isCompleted(lesson.id);
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('HNK · Biblical Languages'),
      ),
      body: SelectionArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 48),
          children: [
            _Hero(lesson: lesson, completed: completed),
            const SizedBox(height: 14),
            _LayerControls(
              preferences: _preferences,
              onChanged: _setPreferences,
            ),
            const SizedBox(height: 24),
            const _Section(
              eyebrow: 'SCRIPTURE',
              title: 'Texto primeiro. Gramática depois.',
              subtitle: 'Toque em uma palavra para abrir o CODEX linguístico.',
            ),
            const SizedBox(height: 12),
            for (final passage in lesson.scriptures)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _ScriptureCard(
                  passage: passage,
                  preferences: _preferences,
                  onTokenTap: (token) => _openCodex(passage, token),
                ),
              ),
            const SizedBox(height: 12),
            const _Section(
              eyebrow: '12 STRUCTURES',
              title: 'Português → Esperanto → Bíblia',
              subtitle: 'Reduza o apoio gradualmente usando os filtros.',
            ),
            const SizedBox(height: 12),
            for (final pattern in lesson.patterns)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PatternCard(
                  pattern: pattern,
                  preferences: _preferences,
                ),
              ),
            if (lesson.drills.isNotEmpty) ...[
              const SizedBox(height: 12),
              const _Section(
                eyebrow: '72 DRILLS',
                title: '12 estruturas × 6 modos cognitivos',
                subtitle: 'A posição é salva automaticamente.',
              ),
              const SizedBox(height: 12),
              _DrillDeck(
                item: lesson.drills[_drillIndex],
                preferences: _preferences,
                current: _drillIndex + 1,
                total: lesson.drills.length,
                onPrevious: _drillIndex == 0
                    ? null
                    : () => _setDrill(_drillIndex - 1),
                onNext: _drillIndex == lesson.drills.length - 1
                    ? null
                    : () => _setDrill(_drillIndex + 1),
              ),
            ],
            const SizedBox(height: 20),
            _Challenge(
              lesson: lesson,
              showAnswer: _showAnswer,
              completed: completed,
              onToggle: () => setState(() => _showAnswer = !_showAnswer),
              onComplete: completed ? null : _complete,
            ),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.lesson, required this.completed});

  final BiblicalLesson lesson;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: _ink, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'LESSON ${lesson.number.toString().padLeft(3, '0')}',
                  style: const TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              if (completed)
                const Chip(
                  avatar: Icon(Icons.check_circle_rounded, size: 18),
                  label: Text('CONCLUÍDA'),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            lesson.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.06,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(lesson.subtitle, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Pill('PORTUGUÊS'),
              _Pill('ESPERANTO'),
              _Pill('עברית מקראית'),
              _Pill('ΚΟΙΝΗ'),
            ],
          ),
          const SizedBox(height: 16),
          Text(lesson.objectivePt, style: const TextStyle(color: Colors.white, height: 1.5)),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: .16)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _LayerControls extends StatelessWidget {
  const _LayerControls({required this.preferences, required this.onChanged});
  final BiblicalLearningPreferences preferences;
  final ValueChanged<BiblicalLearningPreferences> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FilterChip(
            selected: preferences.showPortuguese,
            label: const Text('Português'),
            onSelected: (v) => onChanged(preferences.copyWith(showPortuguese: v)),
          ),
          FilterChip(
            selected: preferences.showEsperanto,
            label: const Text('Esperanto'),
            onSelected: (v) => onChanged(preferences.copyWith(showEsperanto: v)),
          ),
          FilterChip(
            selected: preferences.showTransliteration,
            label: const Text('Transliteração'),
            onSelected: (v) => onChanged(preferences.copyWith(showTransliteration: v)),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.eyebrow, required this.title, required this.subtitle});
  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(color: _blue, fontWeight: FontWeight.w900, letterSpacing: 1.8),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: _ink, fontSize: 22, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), height: 1.4)),
      ],
    );
  }
}

class _ScriptureCard extends StatelessWidget {
  const _ScriptureCard({
    required this.passage,
    required this.preferences,
    required this.onTokenTap,
  });

  final ScripturePassage passage;
  final BiblicalLearningPreferences preferences;
  final ValueChanged<ScriptureToken> onTokenTap;

  @override
  Widget build(BuildContext context) {
    final rtl = passage.direction == ScriptDirection.rtl;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(passage.reference, style: const TextStyle(color: _red, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            Directionality(
              textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
              child: Align(
                alignment: rtl ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  passage.text,
                  style: const TextStyle(color: _ink, fontSize: 25, height: 1.55, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            if (preferences.showTransliteration) ...[
              const SizedBox(height: 8),
              Text(
                passage.transliteration,
                style: const TextStyle(color: _blue, fontStyle: FontStyle.italic),
              ),
            ],
            if (preferences.showPortuguese) ...[
              const Divider(height: 28),
              Text('Literal: ${passage.literalPt}', style: const TextStyle(height: 1.4)),
              const SizedBox(height: 5),
              Text('Natural: ${passage.naturalPt}', style: const TextStyle(fontWeight: FontWeight.w700, height: 1.4)),
            ],
            const SizedBox(height: 14),
            const Text('TOQUE PARA ABRIR O CODEX', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final token in passage.tokens)
                  ActionChip(
                    label: Text(token.surface, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    onPressed: () => onTokenTap(token),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({required this.pattern, required this.preferences});
  final ComparativePattern pattern;
  final BiblicalLearningPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pattern.title, style: const TextStyle(color: _ink, fontWeight: FontWeight.w900)),
            if (preferences.showPortuguese) ...[
              const SizedBox(height: 5),
              Text(pattern.explanationPt, style: const TextStyle(color: Color(0xFF64748B), height: 1.35)),
            ],
            const SizedBox(height: 10),
            for (final line in pattern.lines)
              _LanguageRow(line: line, preferences: preferences),
          ],
        ),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.line, required this.preferences});
  final LanguageLine line;
  final BiblicalLearningPreferences preferences;

  bool get visible {
    if (line.language == BiblicalLanguage.portuguese) return preferences.showPortuguese;
    if (line.language == BiblicalLanguage.esperanto) return preferences.showEsperanto;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    final rtl = line.direction == ScriptDirection.rtl;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 118,
            child: Text(line.label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                  textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
                  child: Align(
                    alignment: rtl ? Alignment.centerRight : Alignment.centerLeft,
                    child: Text(line.text, style: const TextStyle(color: _ink, fontSize: 18, fontWeight: FontWeight.w800)),
                  ),
                ),
                if (preferences.showTransliteration && line.transliteration != null)
                  Text(line.transliteration!, style: const TextStyle(color: _blue, fontSize: 12)),
                if (line.note != null)
                  Text(line.note!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrillDeck extends StatelessWidget {
  const _DrillDeck({
    required this.item,
    required this.preferences,
    required this.current,
    required this.total,
    required this.onPrevious,
    required this.onNext,
  });

  final DrillItem item;
  final BiblicalLearningPreferences preferences;
  final int current;
  final int total;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: _ink, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DRILL $current / $total', style: const TextStyle(color: _gold, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(item.taskPt, style: const TextStyle(color: Colors.white, fontSize: 17, height: 1.4, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: [
                for (final line in item.lines)
                  _LanguageRow(line: line, preferences: preferences),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              OutlinedButton(onPressed: onPrevious, child: const Text('Anterior')),
              const Spacer(),
              FilledButton(onPressed: onNext, child: Text(current == total ? 'Fim dos drills' : 'Próximo')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Challenge extends StatelessWidget {
  const _Challenge({
    required this.lesson,
    required this.showAnswer,
    required this.completed,
    required this.onToggle,
    required this.onComplete,
  });

  final BiblicalLesson lesson;
  final bool showAnswer;
  final bool completed;
  final VoidCallback onToggle;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: _gold, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FINAL QUEST', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4)),
          const SizedBox(height: 10),
          Text(lesson.challenge.promptPt, style: const TextStyle(color: _ink, fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text('Pista: ${lesson.challenge.hintPt}'),
          if (showAnswer) ...[
            const Divider(height: 28, color: _ink),
            Text(lesson.challenge.answer, style: const TextStyle(color: _ink, fontSize: 18, fontWeight: FontWeight.w900)),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilledButton(
                onPressed: onToggle,
                style: FilledButton.styleFrom(backgroundColor: _ink),
                child: Text(showAnswer ? 'Ocultar resposta' : 'Revelar resposta'),
              ),
              if (showAnswer && !completed)
                OutlinedButton.icon(
                  onPressed: onComplete,
                  icon: const Icon(Icons.verified_rounded),
                  label: Text('Concluir Lesson ${lesson.number.toString().padLeft(3, '0')}'),
                ),
              if (completed) const Chip(label: Text('Lesson concluída')),
            ],
          ),
        ],
      ),
    );
  }
}

class _CodexSheet extends StatelessWidget {
  const _CodexSheet({
    required this.passage,
    required this.token,
    required this.showTransliteration,
  });

  final ScripturePassage passage;
  final ScriptureToken token;
  final bool showTransliteration;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .68,
      minChildSize: .42,
      maxChildSize: .92,
      expand: false,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book_rounded, color: _blue),
                const SizedBox(width: 8),
                const Expanded(child: Text('CODEX LINGUÍSTICO', style: TextStyle(color: _blue, fontWeight: FontWeight.w900))),
                Text(passage.reference, style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
            const SizedBox(height: 18),
            Text(token.surface, style: const TextStyle(color: _ink, fontSize: 42, fontWeight: FontWeight.w900)),
            if (showTransliteration)
              Text(token.transliteration, style: const TextStyle(color: _blue, fontSize: 18, fontStyle: FontStyle.italic)),
            const SizedBox(height: 22),
            _CodexField('LEMA', token.lemma),
            _CodexField('GLOSS PT', token.glossPt),
            _CodexField('MORFOLOGIA', token.morphology),
            _CodexField('EDIÇÃO', passage.sourceEdition),
            _CodexField('LICENÇA', passage.sourceLicense),
            _CodexField('ATRIBUIÇÃO', passage.sourceAttribution),
            if (passage.translationNotePt != null)
              _CodexField('NOTA DE TRADUÇÃO', passage.translationNotePt!),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFFFF7DB), borderRadius: BorderRadius.circular(14)),
              child: const Text(
                'Léxico e morfologia descrevem a língua. Interpretação teológica é uma camada posterior e deve ser identificada como tal.',
                style: TextStyle(height: 1.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodexField extends StatelessWidget {
  const _CodexField(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(color: _ink, fontSize: 17, height: 1.4, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
