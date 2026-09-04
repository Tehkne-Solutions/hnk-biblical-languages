import 'package:flutter/material.dart';

import '../content/biblical_library.dart';
import '../models/biblical_lesson.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _red = Color(0xFFE63946);

class ScriptureModeScreen extends StatelessWidget {
  ScriptureModeScreen({super.key});

  final List<ScripturePassage> _passages = buildCanonicalScriptureLibrary();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('SCRIPTURE'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 40),
        children: [
          const Text(
            'BIBLIOTECA CANÔNICA DO CURSO',
            style: TextStyle(
              color: _blue,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${_passages.length} passagens únicas · textos reutilizados não são duplicados.',
            style: const TextStyle(
              color: _ink,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          for (final passage in _passages)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PassageTile(passage: passage),
            ),
        ],
      ),
    );
  }
}

class _PassageTile extends StatelessWidget {
  const _PassageTile({required this.passage});

  final ScripturePassage passage;

  @override
  Widget build(BuildContext context) {
    final rtl = passage.direction == ScriptDirection.rtl;
    return Card(
      elevation: 0,
      child: ExpansionTile(
        title: Text(
          passage.reference,
          style: const TextStyle(color: _red, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          passage.language == BiblicalLanguage.biblicalHebrew
              ? 'HEBRAICO BÍBLICO'
              : 'GREGO KOINÉ',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
            child: Align(
              alignment: rtl ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                passage.text,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 23,
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            passage.transliteration,
            style: const TextStyle(
              color: _blue,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Divider(height: 28),
          Text('Literal: ${passage.literalPt}'),
          const SizedBox(height: 7),
          Text(
            'Natural: ${passage.naturalPt}',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          Text(
            '${passage.sourceEdition}\n${passage.sourceAttribution}',
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
