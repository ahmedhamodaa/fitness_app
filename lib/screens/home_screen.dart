// screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/workout_card.dart';
import '../widgets/progress_chart.dart';
import '../models/workout.dart';
import '../services/database_service.dart';
import 'workout_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  int _currentIndex = 0;
  List<Workout> _workouts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final workouts = await _databaseService.getWorkouts();
      setState(() {
        _workouts = workouts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load workouts: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitTrack'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _loadWorkouts),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildWorkoutsTab();
      case 2:
        return ProfileScreen();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, User!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                  ProgressChart(),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'Recommended Workouts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8.0),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _workouts.isEmpty
              ? Center(child: Text('No workouts available'))
              : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _workouts.length > 3 ? 3 : _workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutCard(
                    workout: _workouts[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  WorkoutScreen(workout: _workouts[index]),
                        ),
                      );
                    },
                  );
                },
              ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: _workouts.length,
          itemBuilder: (context, index) {
            return WorkoutCard(
              workout: _workouts[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WorkoutScreen(workout: _workouts[index]),
                  ),
                );
              },
            );
          },
        );
  }
}
