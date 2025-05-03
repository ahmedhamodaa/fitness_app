// models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final int age;
  final double height; // in cm
  final double weight; // in kg
  final String goal; // 'lose weight', 'gain muscle', 'maintain'
  final List<WorkoutHistory> workoutHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.workoutHistory,
  });

  // Factory constructor to create a User from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImageUrl: map['profileImageUrl'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      goal: map['goal'],
      workoutHistory:
          (map['workoutHistory'] as List)
              .map((historyMap) => WorkoutHistory.fromMap(historyMap))
              .toList(),
    );
  }

  // Convert a User to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'age': age,
      'height': height,
      'weight': weight,
      'goal': goal,
      'workoutHistory':
          workoutHistory.map((history) => history.toMap()).toList(),
    };
  }
}

class WorkoutHistory {
  final String workoutId;
  final DateTime date;
  final int duration; // in minutes
  final List<ExerciseLog> exerciseLogs;

  WorkoutHistory({
    required this.workoutId,
    required this.date,
    required this.duration,
    required this.exerciseLogs,
  });

  // Factory constructor to create a WorkoutHistory from a Map
  factory WorkoutHistory.fromMap(Map<String, dynamic> map) {
    return WorkoutHistory(
      workoutId: map['workoutId'],
      date: DateTime.parse(map['date']),
      duration: map['duration'],
      exerciseLogs:
          (map['exerciseLogs'] as List)
              .map((logMap) => ExerciseLog.fromMap(logMap))
              .toList(),
    );
  }

  // Convert a WorkoutHistory to a Map
  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'date': date.toIso8601String(),
      'duration': duration,
      'exerciseLogs': exerciseLogs.map((log) => log.toMap()).toList(),
    };
  }
}

class ExerciseLog {
  final String exerciseId;
  final int sets;
  final List<int> reps;
  final List<double> weights; // in kg

  ExerciseLog({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.weights,
  });

  // Factory constructor to create an ExerciseLog from a Map
  factory ExerciseLog.fromMap(Map<String, dynamic> map) {
    return ExerciseLog(
      exerciseId: map['exerciseId'],
      sets: map['sets'],
      reps: List<int>.from(map['reps']),
      weights: List<double>.from(map['weights']),
    );
  }

  // Convert an ExerciseLog to a Map
  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'sets': sets,
      'reps': reps,
      'weights': weights,
    };
  }
}
