import 'package:flutter/material.dart';

import '../content/biblical_library.dart';

const _ink = Color(0xFF0F172A);
const _blue = Color(0xFF0057D8);
const _gold = Color(0xFFFFD166);

class CodexModeScreen extends StatefulWidget {
  const CodexModeScreen({super.key});

  @override
  State<CodexModeScreen> createState() => _CodexModeScreenState();
}

class _CodexModeScreenState extends State<CodexModeScreen> {
  final _controller = TextEditingController();
  late final List<BiblicalCodexEntry> _entries = buildCanonicalCodexIndex();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<BiblicalCodexEntry> get _filtered {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return _entries;
    return _entries.where((entry) => entry.searchableText.contains(query)).toList();
  }

  void _open(BiblicalCodexEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: .72,
        maxChildSize: .92,
        minChildSize: .45,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
          children: [
            Text(
              entry.token.surface,
              style: const TextStyle(
                color: _ink,
                fontSize: 42,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              entry.token.transliteration,
              style: const TextStyle(
                color: _blue,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            _Field('REFERÊNCIA', entry.passage.reference),
            _Field('LEMA', entry.token.lemma),
            _Field('GLOSS PT', entry.token.glossPt),
            _Field('MORFOLOGIA', entry.token.morphology),
            _Field('EDIÇÃO', entry.passage.sourceEdition),
            _Field('LICENÇA', entry.passage.sourceLicense),
            _Field('ATRIBUIÇÃO', entry.passage.sourceAttribution),
            if (entry.passage.translationNotePt != null)
              _Field('NOTA', entry.passage.translationNotePt!),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        title: const Text('CODEX'),
      ),
      body: Column(
        children: [
          Container(
            color: _ink,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LÉXICO · LEMA · MORFOLOGIA · PROVENIÊNCIA',
                  style: TextStyle(
                    color: _gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Busque λόγος, Elohim, luz, Qal, genitivo…',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _controller.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('Nenhuma entrada encontrada.'))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) {
                      final entry = filtered[index];
                      return Card(
                        elevation: 0,
                        child: ListTile(
                          onTap: () => _open(entry),
                          title: Text(
                            entry.token.surface,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: Text(
                            '${entry.token.transliteration} · ${entry.token.glossPt}\n${entry.passage.reference}',
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: _ink,
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
