// services/database_service.dart
import 'dart:convert';
import 'dart:math';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../models/user.dart';

class DatabaseService {
  // In a real app, this would be a connection to a real database
  // For this example, we're using dummy data

  Future<List<Workout>> getWorkouts() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Return sample workouts
    return [
      Workout(
        id: '1',
        name: 'Full Body Workout',
        description: 'A complete workout targeting all major muscle groups.',
        imageUrl: 'https://via.placeholder.com/500x300',
        exercises: _getExercisesForWorkout('1'),
        duration: 45,
        difficulty: 'Intermediate',
      ),
      Workout(
        id: '2',
        name: 'Upper Body Focus',
        description: 'Target your chest, shoulders, back, and arms.',
        imageUrl: 'https://via.placeholder.com/500x300',
        exercises: _getExercisesForWorkout('2'),
        duration: 30,
        difficulty: 'Beginner',
      ),
      Workout(
        id: '3',
        name: 'Lower Body Power',
        description: 'Build strength in your legs and core.',
        imageUrl: 'https://via.placeholder.com/500x300',
        exercises: _getExercisesForWorkout('3'),
        duration: 35,
        difficulty: 'Advanced',
      ),
      Workout(
        id: '4',
        name: 'Core Challenge',
        description:
            'Intensive core workout to strengthen your abs and lower back.',
        imageUrl: 'https://via.placeholder.com/500x300',
        exercises: _getExercisesForWorkout('4'),
        duration: 20,
        difficulty: 'Intermediate',
      ),
    ];
  }

  List<Exercise> _getExercisesForWorkout(String workoutId) {
    switch (workoutId) {
      case '1':
        return [
          Exercise(
            id: '1',
            name: 'Push-ups',
            description:
                'A classic exercise that works your chest, shoulders, triceps, and core.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/pushups',
            muscleGroup: 'Chest',
            equipment: 'None',
            sets: 3,
            reps: 12,
            restTime: 60,
          ),
          Exercise(
            id: '2',
            name: 'Squats',
            description:
                'A fundamental lower body exercise that targets quads, hamstrings, and glutes.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/squats',
            muscleGroup: 'Legs',
            equipment: 'None',
            sets: 3,
            reps: 15,
            restTime: 60,
          ),
          Exercise(
            id: '3',
            name: 'Plank',
            description:
                'An isometric core exercise that improves stability and strength.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/plank',
            muscleGroup: 'Core',
            equipment: 'None',
            sets: 3,
            reps: 1,
            restTime: 45,
          ),
        ];
      case '2':
        return [
          Exercise(
            id: '4',
            name: 'Dumbbell Bench Press',
            description:
                'A variation of the classic bench press using dumbbells.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/dumbbell-bench-press',
            muscleGroup: 'Chest',
            equipment: 'Dumbbells',
            sets: 4,
            reps: 10,
            restTime: 90,
          ),
          Exercise(
            id: '5',
            name: 'Pull-ups',
            description:
                'An upper body compound exercise that targets the back and biceps.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/pullups',
            muscleGroup: 'Back',
            equipment: 'Pull-up Bar',
            sets: 3,
            reps: 8,
            restTime: 90,
          ),
          Exercise(
            id: '6',
            name: 'Shoulder Press',
            description:
                'An exercise that targets the deltoid muscles in your shoulders.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/shoulder-press',
            muscleGroup: 'Shoulders',
            equipment: 'Dumbbells',
            sets: 3,
            reps: 12,
            restTime: 60,
          ),
        ];
      case '3':
        return [
          Exercise(
            id: '7',
            name: 'Deadlifts',
            description:
                'A compound exercise that works numerous muscles in the lower body.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/deadlifts',
            muscleGroup: 'Legs',
            equipment: 'Barbell',
            sets: 4,
            reps: 8,
            restTime: 120,
          ),
          Exercise(
            id: '8',
            name: 'Lunges',
            description:
                'A unilateral exercise that targets the quads, hamstrings, and glutes.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/lunges',
            muscleGroup: 'Legs',
            equipment: 'None',
            sets: 3,
            reps: 12,
            restTime: 60,
          ),
          Exercise(
            id: '9',
            name: 'Calf Raises',
            description:
                'An exercise that targets the gastrocnemius and soleus muscles.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/calf-raises',
            muscleGroup: 'Calves',
            equipment: 'None',
            sets: 3,
            reps: 15,
            restTime: 45,
          ),
        ];
      case '4':
        return [
          Exercise(
            id: '10',
            name: 'Crunches',
            description:
                'A classic abdominal exercise targeting the rectus abdominis.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/crunches',
            muscleGroup: 'Abs',
            equipment: 'None',
            sets: 3,
            reps: 20,
            restTime: 45,
          ),
          Exercise(
            id: '11',
            name: 'Russian Twists',
            description: 'A rotational exercise targeting the obliques.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/russian-twists',
            muscleGroup: 'Abs',
            equipment: 'Dumbbell',
            sets: 3,
            reps: 16,
            restTime: 45,
          ),
          Exercise(
            id: '12',
            name: 'Leg Raises',
            description: 'An exercise targeting the lower abs and hip flexors.',
            imageUrl: 'https://via.placeholder.com/400x300',
            videoUrl: 'https://example.com/videos/leg-raises',
            muscleGroup: 'Abs',
            equipment: 'None',
            sets: 3,
            reps: 12,
            restTime: 60,
          ),
        ];
      default:
        return [];
    }
  }

  Future<User> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Return sample user
    return User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      profileImageUrl: 'https://via.placeholder.com/150',
      age: 30,
      height: 180,
      weight: 75,
      goal: 'Build Muscle',
      workoutHistory: [
        WorkoutHistory(
          workoutId: '1',
          date: DateTime.now().subtract(Duration(days: 7)),
          duration: 45,
          exerciseLogs: [
            ExerciseLog(
              exerciseId: '1',
              sets: 3,
              reps: [12, 10, 8],
              weights: [0, 0, 0],
            ),
            ExerciseLog(
              exerciseId: '2',
              sets: 3,
              reps: [15, 15, 12],
              weights: [0, 0, 0],
            ),
            ExerciseLog(
              exerciseId: '3',
              sets: 3,
              reps: [1, 1, 1],
              weights: [0, 0, 0],
            ),
          ],
        ),
        WorkoutHistory(
          workoutId: '2',
          date: DateTime.now().subtract(Duration(days: 5)),
          duration: 30,
          exerciseLogs: [
            ExerciseLog(
              exerciseId: '4',
              sets: 4,
              reps: [10, 10, 8, 8],
              weights: [20, 20, 15, 15],
            ),
            ExerciseLog(
              exerciseId: '5',
              sets: 3,
              reps: [8, 6, 6],
              weights: [0, 0, 0],
            ),
            ExerciseLog(
              exerciseId: '6',
              sets: 3,
              reps: [12, 10, 10],
              weights: [15, 15, 12.5],
            ),
          ],
        ),
        WorkoutHistory(
          workoutId: '4',
          date: DateTime.now().subtract(Duration(days: 2)),
          duration: 20,
          exerciseLogs: [
            ExerciseLog(
              exerciseId: '10',
              sets: 3,
              reps: [20, 18, 15],
              weights: [0, 0, 0],
            ),
            ExerciseLog(
              exerciseId: '11',
              sets: 3,
              reps: [16, 14, 12],
              weights: [5, 5, 5],
            ),
            ExerciseLog(
              exerciseId: '12',
              sets: 3,
              reps: [12, 10, 10],
              weights: [0, 0, 0],
            ),
          ],
        ),
      ],
    );
  }

  // In a real app, there would be more methods to save workout history, update user data, etc.
}
