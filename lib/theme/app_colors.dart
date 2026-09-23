import 'package:flutter/material.dart';

class AppColors {
  // Brand Primary & Dark
  static const Color primary = Color(0xFF0B192C); // Deep Midnight Navy
  static const Color primaryLight = Color(0xFF1E3E62); // Slate Navy
  static const Color primaryDark = Color(0xFF070F1E); // Darkest Navy / Footer

  // Brand Secondary & Accent
  static const Color secondary = Color(0xFFFF6500); // Warm Sunset Orange
  static const Color secondaryHover = Color(0xFFE55A00);
  static const Color accent = Color(0xFFFFB703); // Golden Sand
  static const Color accentLight = Color(0xFFFFF3D6);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF7F9FC); // Off-white clean
  static const Color surface = Color(0xFFFFFFFF); // Card white
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF0F1E36);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B); // Slate 800
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color textLightMuted = Color(0xFFCBD5E1);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF1E293B);

  // Status & Badges
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient heroOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xCC070F1E),
      Color(0x800B192C),
      Color(0xE6070F1E),
    ],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFF6500), Color(0xFFFF8E3C)],
  );

  static const LinearGradient navyGradient = LinearGradient(
    colors: [Color(0xFF0B192C), Color(0xFF1E3E62)],
  );

  static const LinearGradient cardImageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xCC070F1E),
    ],
  );
}
