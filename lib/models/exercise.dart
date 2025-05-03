// models/exercise.dart
class Exercise {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String muscleGroup;
  final String equipment;
  final int sets;
  final int reps;
  final int restTime; // in seconds

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.muscleGroup,
    required this.equipment,
    required this.sets,
    required this.reps,
    required this.restTime,
  });

  // Factory constructor to create an Exercise from a Map
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
      muscleGroup: map['muscleGroup'],
      equipment: map['equipment'],
      sets: map['sets'],
      reps: map['reps'],
      restTime: map['restTime'],
    );
  }

  // Convert an Exercise to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'muscleGroup': muscleGroup,
      'equipment': equipment,
      'sets': sets,
      'reps': reps,
      'restTime': restTime,
    };
  }
}
