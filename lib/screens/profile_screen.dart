// screens/profile_screen.dart
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import '../models/user.dart' ;
import '../widgets/progress_chart.dart';
import '../services/database_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseService _databaseService = DatabaseService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _databaseService.getCurrentUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load user data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _user == null
        ? Center(child: Text('No user data available'))
        : SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(_user!.profileImageUrl),
                      onBackgroundImageError: (e, stackTrace) {},
                      child:
                          _user!.profileImageUrl.isEmpty
                              ? Icon(
                                Icons.person,
                                size: 60.0,
                                color: Colors.white,
                              )
                              : null,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      _user!.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      _user!.email,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8.0),
                      _buildInfoRow('Age', '${_user!.age} years'),
                      _buildInfoRow('Height', '${_user!.height} cm'),
                      _buildInfoRow('Weight', '${_user!.weight} kg'),
                      _buildInfoRow('Goal', _user!.goal),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Your Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.0),
              ProgressChart(),
              SizedBox(height: 24.0),
              Text(
                'Workout History',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.0),
              _user!.workoutHistory.isEmpty
                  ? Center(child: Text('No workout history available'))
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _user!.workoutHistory.length,
                    itemBuilder: (context, index) {
                      final history = _user!.workoutHistory[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text('Workout #${history.workoutId}'),
                          subtitle: Text('Date: ${_formatDate(history.date)}'),
                          trailing: Text('${history.duration} min'),
                        ),
                      );
                    },
                  ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Edit profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Edit profile (not implemented)')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                ),
                child: Text('EDIT PROFILE'),
              ),
              SizedBox(height: 8.0),
              OutlinedButton(
                onPressed: () async{
                  await fb.FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                ),
                child: Text('LOG OUT'),
              ),
            ],
          ),
        );
  }

  Widget _buildInfoRow(String label, String value) {
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
