import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors
  static const Color primaryBlue = Color(0xFF4A7FFF);
  static const Color primaryPurple = Color(0xFF9F5FFF);
  static const Color primaryDark = Color(0xFF2D4A9E);
  
  // Accent Colors
  static const Color accentOrange = Color(0xFFFF8A5B);
  static const Color accentGold = Color(0xFFFFB156);
  
  // Success & Savings
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color savingsGreen = Color(0xFF00E676);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [accentOrange, accentGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF1A1A2E);
  
  // Card Colors (Glassmorphism)
  static const Color cardGlass = Color(0x40FFFFFF);
  static const Color cardGlassDark = Color(0x20FFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Semantic Colors
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
}
