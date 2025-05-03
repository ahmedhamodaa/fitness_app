// screens/exercise_screen.dart
import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseScreen extends StatelessWidget {
  final Exercise exercise;

  ExerciseScreen({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                exercise.imageUrl,
                height: 250.0,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250.0,
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
              exercise.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Chip(
                  label: Text(exercise.muscleGroup),
                  avatar: Icon(Icons.fitness_center),
                ),
                SizedBox(width: 8.0),
                Chip(
                  label: Text(exercise.equipment),
                  avatar: Icon(Icons.sports_gymnastics),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            Text(exercise.description),
            SizedBox(height: 24.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8.0),
                    _buildDetailRow('Sets', '${exercise.sets}'),
                    _buildDetailRow('Reps', '${exercise.reps}'),
                    _buildDetailRow('Rest', '${exercise.restTime} seconds'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            if (exercise.videoUrl.isNotEmpty) ...[
              Text(
                'Video Guide',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.0),
              // Video player would go here, but for simplicity,
              // we're just showing a button that would open the video
              ElevatedButton.icon(
                onPressed: () {
                  // Open video player or web link
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening video guide (not implemented)'),
                    ),
                  );
                },
                icon: Icon(Icons.play_circle),
                label: Text('Watch Video Guide'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
