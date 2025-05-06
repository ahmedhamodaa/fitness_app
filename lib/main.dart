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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FitTrackApp());
}

class FitTrackApp extends StatefulWidget {


  @override
  State<FitTrackApp> createState() => _FitTrackAppState();
}

class _FitTrackAppState extends State<FitTrackApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('=================User is currently signed out!');
      } else {
        print('=================User is signed in!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
