// widgets/exercise_card.dart
import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  ExerciseCard({required this.exercise, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.network(
            exercise.imageUrl,
            width: 60.0,
            height: 60.0,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60.0,
                height: 60.0,
                color: Colors.grey[300],
                child: Icon(Icons.fitness_center, color: Colors.grey[600]),
              );
            },
          ),
        ),
        title: Text(exercise.name),
        subtitle: Text('${exercise.sets} sets • ${exercise.reps} reps'),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
