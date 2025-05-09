// screens/profile_screen.dart
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
  List<Map<String, dynamic>> data = [];  User? _user;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = true;
  bool _isImageLoaded = true;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;


  @override
  void initState() {
    super.initState();
    _loadUserData();
    getData();
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

  getData() async {
    String uid = fb.FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (userSnapshot.exists) {
      setState(() {
        data = [userSnapshot.data() as Map<String, dynamic>];
        _isLoading = false;
      });
    } else {
      print("User data not found");
    }
  }

  double calculateBMI(double weight, double height) {
    double heightInMeters = height / 100;

    return weight / (heightInMeters * heightInMeters);
  }

  Future<String?> uploadImageToCloudinary(File imageFile) async {
    final cloudName = 'dsp9effrj';
    final uploadPreset = 'ml_default';

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final jsonRes = json.decode(resStr);
      return jsonRes['secure_url'];
    } else {
      print('Failed to upload on Cloudinary:${response.statusCode}');
      return null;
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      String? imageUrl = await uploadImageToCloudinary(imageFile);

      if (imageUrl != null) {
        setState(() {
          data[0]['profileImgUrl'] = imageUrl;
          _isImageLoaded = true;
        });

        String uid = fb.FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .update({'profileImgUrl': imageUrl});
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _user == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap:_showImageSourceDialog,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: _isImageLoaded
                                ? NetworkImage(data[0]['profileImgUrl']!)
                                : AssetImage('assets/images/profile_pic.png',) as ImageProvider,
                            onBackgroundImageError: (e, stackTrace) {
                              print('Error loading image: $e');
                              setState(() {
                                _isImageLoaded = false;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(Icons.camera_alt, color: Colors.black87,),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      data[0]['username'],
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      data[0]['email'],
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Personal Information',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 16,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Edit Profile',
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                          SizedBox(height: 16.0),
                                          TextFormField(
                                            initialValue: data[0]['age'],
                                            decoration: InputDecoration(labelText: 'Age'),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                data[0]['age'] = value;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            initialValue: data[0]['height'],
                                            decoration: InputDecoration(labelText: 'Height'),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                data[0]['height'] = value;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            initialValue: data[0]['weight'],
                                            decoration: InputDecoration(labelText: 'Weight'),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                data[0]['weight'] = value;
                                              });
                                            },
                                          ),

                                          DropdownButtonFormField<String>(
                                            value: data[0]['goal'] ?? 'Balanced',
                                            decoration: InputDecoration(labelText: 'Goal'),
                                            items: ['Building Muscle', 'Fat Loss', 'Balanced']
                                                .map((goal) => DropdownMenuItem<String>(
                                              value: goal,
                                              child: Text(goal),
                                            ))
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                data[0]['goal'] = newValue!;
                                              });
                                            },
                                          ),
                                          SizedBox(height: 16.0),
                                          ElevatedButton(
                                            onPressed: () async {
                                              String uid = fb.FirebaseAuth.instance.currentUser!.uid;
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(uid)
                                                  .update({
                                                'age': data[0]['age'],
                                                'height': data[0]['height'],
                                                'weight': data[0]['weight'],
                                                'goal': data[0]['goal'],
                                              });
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Profile updated successfully!')),
                                              );
                                            },
                                            child: Text('Update'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),


                        ],
                      ),
                      SizedBox(height: 8.0),
                      _buildInfoRow('Age', '${data[0]['age']} years'),
                      _buildInfoRow('Height', '${data[0]['height']} cm'),
                      _buildInfoRow('Weight', '${data[0]['weight']} kg'),
                      _buildInfoRow('Goal', data[0]['goal']),
                      _buildInfoRow('BMI', '${calculateBMI(double.parse(data[0]['weight']), double.parse(data[0]['height'])).toStringAsFixed(2)}'),
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
              OutlinedButton(
                onPressed: () async{
                  await fb.FirebaseAuth.instance.signOut();
                  await _googleSignIn.signOut();
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
        ),
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
