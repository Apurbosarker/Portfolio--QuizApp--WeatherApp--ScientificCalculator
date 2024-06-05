import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required bool isDarkMode});

  // Database variables
  static Database? _database;
  static const String resumeTable = 'resume';
  static const String achievementsTable = 'achievements';

  // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  get _pickResume => null;

  // Initialize the database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'profile_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // Create the database tables
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $resumeTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_path TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $achievementsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_path TEXT
      )
    ''');
  }

  // Function to handle resume/cv upload
  Future<void> _uploadResume(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String filePath = file.path ?? "";
      // Store the file path in the database
      Database db = await database;
      await db.insert(resumeTable, {'file_path': filePath});

      // Display a confirmation message after successful upload
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resume uploaded successfully")),
      );
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected")),
      );
    }
  }

  // Function to handle achievements and certifications upload
  Future<void> _uploadAchievements(BuildContext context) async {
    // Similar to _uploadResume function, implement file uploading logic for achievements and certifications
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/weather/My_Image.png'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Apurbo Sarker',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Manikganj, Dhaka',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  const Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Currently studying at Daffodil International University in the Department of Computer Science and Engineering. I have a strong interest in technology and its applications. My greatest hobby is being with my parents and keeping them happy.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.email, color: Colors.blue),
                    title: Text('Email'),
                    subtitle: Text('apurbo15-14719@diu.edu.bd'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone, color: Colors.blue),
                    title: Text('Phone'),
                    subtitle: Text('+880 1571480762'),
                  ),

                  const SizedBox(height: 20.0),
                  const Divider(),
                  const Text(
                    'Blog',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle writing a new blog post
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Write a Blog Post'),
                  ),

                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Skills',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          ListTile(
                            title: Text(
                                'C, C++, Java, Python, Dart, SQL, Flutter'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Volunteering',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          ListTile(
                            title: Text(
                                'President of DIU Computer and Programming Club'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle edit profile
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Upload Resume/CV Button
                  const Divider(),
                  const SizedBox(height: 20.0),

                  ElevatedButton.icon(
                    onPressed: () {
                      _uploadResume(context); // Call the upload function
                    },
                    icon: const Icon(Icons.file_upload),
                    label: const Text('Upload Resume/CV'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(
                          255, 133, 214, 136), // Adjust colors as needed
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // Upload Achievements and Certifications Button
                  ElevatedButton.icon(
                    onPressed: () {
                      _uploadAchievements(context); // Call the upload function
                    },
                    icon: const Icon(Icons.file_upload),
                    label: const Text('Upload Achievements/Certifications'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(
                          117, 8, 139, 205), // Adjust colors as needed
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10.0),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle logout
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //void _uploadResume(BuildContext context) {}

  //void _uploadAchievements(BuildContext context) {}
}
