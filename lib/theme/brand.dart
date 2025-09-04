import 'package:flutter/material.dart';

class Brand {
  // Greens (tuned to screenshot)
  static const green = Color(0xFF19A974); // selected fills / accents
  static const darkTeal = Color(0xFF0B6B63); // primary CTA button

  // Surfaces (light & dark)
  static const bgLight = Color(0xFFF7FAFC);
  static const bgDark = Color(0xFF0C1118);
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF131A23);

  // Soft greens / fields
  static const lightTealBg = Color(0xFFEAF6F3); // selected strip / soft chip
  static const segmentBg = Color(0xFFF1F7F5); // segmented background
  static const fieldBg = Color(0xFFF7FAF9); // chip-like textfield bg

  // Borders
  static const borderLight = Color(0xFFDDE8E3); // subtle greenish border
  static const borderDark = Color(0xFF1F2937);

  // Text
  static const textDark = Color(0xFF111827);
  static const textMute = Color(0xFF6B7280);
  static const textOnDark = Color(0xFFF3F4F6);
  static const textOnDarkMute = Color(0xFFCBD5E1);
  static const textOnPrimary = Colors.white;

  // (Optional convenience) same as bgLight for older codepaths
  static const scaffold = cardLight;
}
