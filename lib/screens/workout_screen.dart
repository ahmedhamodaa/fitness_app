// screens/workout_screen.dart
import 'package:fitness_app/screens/exercises_screen.dart';
import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../widgets/exercise_card.dart';

class WorkoutScreen extends StatelessWidget {
  final Workout workout;

  WorkoutScreen({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(workout.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                workout.imageUrl,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.fitness_center,
                      size: 80.0,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              workout.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Chip(
                  label: Text('${workout.duration} min'),
                  avatar: Icon(Icons.timer),
                ),
                SizedBox(width: 8.0),
                Chip(
                  label: Text(workout.difficulty),
                  avatar: Icon(Icons.fitness_center),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            Text(workout.description),
            SizedBox(height: 24.0),
            Text('Exercises', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: workout.exercises.length,
              itemBuilder: (context, index) {
                return ExerciseCard(
                  exercise: workout.exercises[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ExerciseScreen(
                              exercise: workout.exercises[index],
                            ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Starting workout: ${workout.name}')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.0),
              ),
              child: Text('START WORKOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
