import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'sections/main_section.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: AppTheme.lightTheme,
      home: const MainSection(),
    );
  }
}
