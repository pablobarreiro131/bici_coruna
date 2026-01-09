import 'package:flutter/material.dart';

class AppColors {

  static const Color primary = Color(0xFF0A0E27);
  static const Color primaryLight = Color(0xFF1A1F3A);
  static const Color accent = Color(0xFF64B5F6); // Azul claro
  static const Color accentLight = Color(0xFF90CAF9);

  static const Color backgroundPrimary = Color(0xFF000000); // Negro
  static const Color backgroundSecondary = Color(0xFF0A0E27);
  static const Color surface = Color(0xFF121212);
  static const Color surfaceVariant = Color(0xFF1E1E1E);

  static const Color textPrimary = Color(0xFFE0E0E0);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF757575);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color border = Color(0xFF2A2A2A);
  static const Color borderLight = Color(0xFF1A1A1A);
  static const Color divider = Color(0xFF2A2A2A);

  static const Color success = Color(0xFF66BB6A); // Verde más suave
  static const Color successLight = Color(0xFF1B5E20);
  static const Color error = Color(0xFFEF5350); // Rojo más suave
  static const Color errorLight = Color(0xFF4A1A1A);
  static const Color warning = Color(0xFFFFB74D); // Naranja más suave
  static const Color warningLight = Color(0xFF3A2A1A);
  static const Color info = Color(0xFF64B5F6); // Azul claro (igual que accent)
  static const Color infoLight = Color(0xFF1A2A3A);

  static const Color mechanicalBike = Color(0xFF9E9E9E);
  static const Color mechanicalBikeLight = Color(0xFF2A2A2A);
  static const Color electricBike = Color(0xFF66BB6A);
  static const Color electricBikeLight = Color(0xFF1B5E20);

  static const Color totalDocks = Color(0xFF9575CD); // Morado más suave
  static const Color totalDocksLight = Color(0xFF2A1A3A);
  static const Color availableDocks = Color(0xFF4DD0E1); // Cyan claro
  static const Color availableDocksLight = Color(0xFF1A2A2F);
  static const Color disabledDocks = Color(0xFFEF5350);
  static const Color disabledDocksLight = Color(0xFF4A1A1A);

  // Información temporal
  static const Color infoBackground = Color(0xFF1A1A1A);
  static const Color infoBorder = Color(0xFF2A2A2A);
  static const Color infoIcon = Color(0xFF64B5F6);
  static const Color infoTextPrimary = textPrimary;
  static const Color infoTextSecondary = textSecondary;

  static LinearGradient createMinimalGradient(Color color) {
    return LinearGradient(
      colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.08)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static List<BoxShadow> createMinimalShadow({Color? color}) {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.4),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: (color ?? accent).withValues(alpha: 0.1),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
    ];
  }

  static Border createMinimalBorder({Color? color}) {
    return Border.all(color: color ?? border, width: 1);
  }

  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color searchBarBackground = Color(0xFF1A1A1A);
  static const Color availableBikes = success;
  static const Color totalAvailableText = textPrimary;
  static const Color totalAvailableLabel = textSecondary;
  static const Color disabledBikesText = error;
  static const Color disabledBikesLabel = error;
}
