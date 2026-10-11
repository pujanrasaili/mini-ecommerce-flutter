import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFAF7F0); // off white
  static const card = Colors.white;
  static const ink = Color(0xFF1B1B1B); // main dark colour
  static const accent = Color(0xFFFFC107); // amber
  static const priceColor = Color(0xFFB8860B);
  static const softText = Color(0xFF6B6B6B);

  // soft shadow used under cards and circles
  static List<BoxShadow> shadow() {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ];
  }
}
