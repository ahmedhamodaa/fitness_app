// widgets/workout_card.dart
import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  WorkoutCard({required this.workout, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              workout.imageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.fitness_center,
                    size: 50.0,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    workout.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16.0),
                      SizedBox(width: 4.0),
                      Text('${workout.duration} min'),
                      SizedBox(width: 16.0),
                      Icon(Icons.fitness_center, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(workout.difficulty),
                      SizedBox(width: 16.0),
                      Icon(Icons.format_list_numbered, size: 16.0),
                      SizedBox(width: 4.0),
                      Text('${workout.exercises.length} exercises'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
