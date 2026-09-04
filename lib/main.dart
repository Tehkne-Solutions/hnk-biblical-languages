import 'package:flutter/material.dart';

import 'biblical_languages/ui/biblical_languages_platform_shell.dart';

void main() {
  runApp(const HnkBiblicalLanguagesApp());
}

class HnkBiblicalLanguagesApp extends StatelessWidget {
  const HnkBiblicalLanguagesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HNK Biblical Languages',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0057D8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const BiblicalLanguagesPlatformShell(),
    );
  }
}
