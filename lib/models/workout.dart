// models/workout.dart
import 'package:fitness_app/models/exercise.dart';

class Workout {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Exercise> exercises;
  final int duration; // in minutes
  final String difficulty; // 'beginner', 'intermediate', 'advanced'

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.exercises,
    required this.duration,
    required this.difficulty,
  });

  // Factory constructor to create a Workout from a Map
  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      exercises:
          (map['exercises'] as List)
              .map((exerciseMap) => Exercise.fromMap(exerciseMap))
              .toList(),
      duration: map['duration'],
      difficulty: map['difficulty'],
    );
  }

  // Convert a Workout to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
      'duration': duration,
      'difficulty': difficulty,
    };
  }
}
