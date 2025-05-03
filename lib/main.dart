// Project Structure:
// - lib/
//   - main.dart
//   - models/
//     - workout.dart
//     - exercise.dart
//     - user.dart
//   - screens/
//     - home_screen.dart
//     - workout_screen.dart
//     - exercise_screen.dart
//     - profile_screen.dart
//   - widgets/
//     - workout_card.dart
//     - exercise_card.dart
//     - progress_chart.dart
//   - services/
//     - database_service.dart
//   - utils/
//     - constants.dart
//     - theme.dart

// main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(FitTrackApp());
}

class FitTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
