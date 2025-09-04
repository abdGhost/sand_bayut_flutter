import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'brand.dart';

ThemeData appTheme(Brightness b) {
  final isDark = b == Brightness.dark;
  final scheme = ColorScheme(
    brightness: b,
    primary: Brand.darkTeal,
    onPrimary: Colors.white,
    secondary: Brand.green,
    onSecondary: Colors.white,
    error: const Color(0xFFEF4444),
    onError: Colors.white,
    surface: isDark ? Brand.cardDark : Brand.cardLight,
    onSurface: isDark ? Colors.white : const Color(0xFF111827),
    background: isDark ? Brand.bgDark : Brand.bgLight,
    onBackground: isDark ? Colors.white : const Color(0xFF111827),
  );

  final text = GoogleFonts.interTextTheme(
    isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: text,
    scaffoldBackgroundColor: scheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? Colors.black : Colors.white,
      foregroundColor: isDark ? Colors.white : Colors.black,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Brand.darkTeal, width: 1.3),
        foregroundColor: Brand.darkTeal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Brand.darkTeal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Brand.borderLight),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Brand.borderLight),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Brand.darkTeal, width: 1.6),
      ),
      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
    ),
  );
}
