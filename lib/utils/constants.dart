// utils/constants.dart
import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color secondaryColor = Color(0xFF388E3C);
  static const Color accentColor = Color(0xFF8BC34A);
  static const Color lightGreen = Color(0xFFC8E6C9);
  static const Color darkText = Color(0xFF212121);
  static const Color mediumText = Color(0xFF757575);
  static const Color lightText = Color(0xFFBDBDBD);
  static const Color dividerColor = Color(0xFFDDDDDD);

  // Padding
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Radius
  static const double defaultRadius = 8.0;
  static const double largeRadius = 16.0;

  // Animation
  static const Duration defaultDuration = Duration(milliseconds: 300);

  // Text sizes
  static const double headline1Size = 28.0;
  static const double headline2Size = 24.0;
  static const double headline3Size = 20.0;
  static const double bodySize = 16.0;
  static const double captionSize = 14.0;
  static const double smallSize = 12.0;

  // Button sizes
  static const double buttonHeight = 50.0;
  static const double iconButtonSize = 48.0;

  // Default images
  static const String defaultUserImage = 'assets/images/default_user.png';
  static const String defaultWorkoutImage = 'assets/images/default_workout.png';
  static const String defaultExerciseImage =
      'assets/images/default_exercise.png';
  static const String appLogo = 'assets/images/logo.png';

  // App info
  static const String appName = 'FitTrack';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Your personal fitness companion';
}
