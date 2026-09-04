import 'package:flutter/material.dart';

import '../progress/biblical_progress.dart';
import 'biblical_languages_catalog_screen.dart';
import 'codex_mode_screen.dart';
import 'drill_mode_screen.dart';
import 'quest_mode_screen.dart';
import 'scripture_mode_screen.dart';

class BiblicalLanguagesPlatformShell extends StatefulWidget {
  const BiblicalLanguagesPlatformShell({
    super.key,
    this.progressStore = const SharedPreferencesBiblicalProgressStore(),
  });

  final BiblicalProgressStore progressStore;

  @override
  State<BiblicalLanguagesPlatformShell> createState() =>
      _BiblicalLanguagesPlatformShellState();
}

class _BiblicalLanguagesPlatformShellState
    extends State<BiblicalLanguagesPlatformShell> {
  int _index = 0;

  Widget _screen() {
    return switch (_index) {
      0 => BiblicalLanguagesCatalogScreen(
          key: const ValueKey('academy-mode'),
          progressStore: widget.progressStore,
        ),
      1 => DrillModeScreen(
          key: const ValueKey('drill-mode'),
          progressStore: widget.progressStore,
        ),
      2 => const CodexModeScreen(key: ValueKey('codex-mode')),
      3 => ScriptureModeScreen(key: const ValueKey('scripture-mode')),
      4 => QuestModeScreen(
          key: const ValueKey('quest-mode'),
          progressStore: widget.progressStore,
        ),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school_rounded),
            label: 'Academy',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            selectedIcon: Icon(Icons.bolt_rounded),
            label: 'Drill',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Codex',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories_rounded),
            label: 'Scripture',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            selectedIcon: Icon(Icons.workspace_premium_rounded),
            label: 'Quest',
          ),
        ],
      ),
    );
  }
}
