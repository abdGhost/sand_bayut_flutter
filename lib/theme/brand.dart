import 'package:flutter/material.dart';

class Brand {
  // Brand colors
  static const green = Color(0xFF10B981); // progress/selection highlight
  static const darkTeal = Color(0xFF0B6B63); // primary filled button
  static const lightTealBg = Color(0xFFE6F4F1); // selected chip/bg

  // Surfaces
  static const bgLight = Color(0xFFF7FAFC);
  static const bgDark = Color(0xFF0C1118);
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF131A23);
  static const borderLight = Color(0xFFE5E7EB);
  static const borderDark = Color(0xFF1F2937);

  // ── Text (light surfaces) ──────────────────────────────────────────────
  static const textDark = Color(
    0xFF111827,
  ); // primary text on light (slate-900)
  static const textMute = Color(
    0xFF6B7280,
  ); // secondary text/hint on light (slate-500)
  static const textTertiary = Color(
    0xFF9CA3AF,
  ); // tertiary/help on light (slate-400)

  // ── Text (dark surfaces) ───────────────────────────────────────────────
  static const textOnDark = Color(
    0xFFF3F4F6,
  ); // primary text on dark (slate-100)
  static const textOnDarkMute = Color(
    0xFFCBD5E1,
  ); // secondary on dark (slate-300)
  static const textOnDarkTertiary = Color(
    0xFF94A3B8,
  ); // tertiary on dark (slate-400)

  // ── Text on brand / accents ────────────────────────────────────────────
  static const textOnPrimary = Colors.white; // on buttons, chips, etc.

  // ── Optional links (keep brand-friendly) ───────────────────────────────
  static const link = Color(0xFF0EA5E9); // sky-500
  static const linkHover = Color(0xFF0284C7); // sky-600
}
