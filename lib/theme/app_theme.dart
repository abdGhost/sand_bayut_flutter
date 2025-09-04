import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'brand.dart';

ThemeData appTheme(Brightness b) {
  final isDark = b == Brightness.dark;

  // Color scheme tuned to your UI
  final scheme = ColorScheme(
    brightness: b,
    primary: Brand.green, // accent fills (chips, focused borders)
    onPrimary: Colors.white,
    secondary: Brand.darkTeal, // CTA buttons
    onSecondary: Colors.white,
    error: const Color(0xFFEF4444),
    onError: Colors.white,
    surface: isDark ? Brand.cardDark : Brand.cardLight,
    onSurface: isDark ? Colors.white : const Color(0xFF111827),
    background: isDark ? Brand.bgDark : Brand.bgLight,
    onBackground: isDark ? Colors.white : const Color(0xFF111827),
  );

  final textTheme = GoogleFonts.interTextTheme(
    isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
  );

  final borderColor = isDark ? Brand.borderDark : Brand.borderLight;

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.background,
    canvasColor: scheme.background,

    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? Brand.cardDark : Colors.white,
      foregroundColor: isDark ? Colors.white : Brand.textDark,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white : Brand.textDark,
      ),
      iconTheme: IconThemeData(color: isDark ? Colors.white : Brand.textDark),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Brand.darkTeal, // CTA like “Done”, “Show…”
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(
          color: borderColor,
          width: 1.2,
        ), // neutral like screenshot
        foregroundColor: Brand.textDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),

    // Inputs (search, filter fields)
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: isDark ? Brand.cardDark : Brand.fieldBg, // soft chip-like bg
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(
          color: Brand.green,
          width: 1.6,
        ), // subtle green focus
      ),
      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
      prefixIconColor: const Color(0xFF6B7280),
    ),

    // Chips (location tag, meta chips)
    chipTheme: ChipThemeData(
      backgroundColor: isDark ? Brand.cardDark : Brand.fieldBg,
      selectedColor: Brand.lightTealBg,
      disabledColor: isDark ? Brand.cardDark : Brand.fieldBg,
      labelStyle: TextStyle(
        color: isDark ? Colors.white : Brand.textDark,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: TextStyle(
        color: isDark ? Colors.white : Brand.textDark,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(color: borderColor, width: 1),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    ),

    // Switch (commute time)
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        (s) => s.contains(MaterialState.selected) ? Brand.green : Colors.white,
      ),
      trackColor: MaterialStateProperty.resolveWith(
        (s) => s.contains(MaterialState.selected)
            ? Brand.green.withOpacity(.35)
            : borderColor,
      ),
    ),

    dividerTheme: DividerThemeData(color: borderColor, thickness: 1, space: 32),

    iconTheme: IconThemeData(color: isDark ? Colors.white : Brand.textDark),

    // Optional: SegmentedButton (if you use Material3 segmented controls anywhere)
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        side: WidgetStateProperty.resolveWith(
          (s) => BorderSide(
            color: s.contains(WidgetState.selected) ? Brand.green : borderColor,
            width: 1,
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? Brand.green
              : (isDark ? Brand.cardDark : Brand.segmentBg),
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? Colors.white
              : (isDark ? Colors.white : Brand.textDark),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
