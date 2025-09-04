import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'navigation/bottom_nav.dart';

void main() => runApp(const SandsBaytApp());

class SandsBaytApp extends StatelessWidget {
  const SandsBaytApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sands Bayt',
      themeMode: ThemeMode.light,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      home: const BottomNav(), // or navigate here after onboarding
    );
  }
}
