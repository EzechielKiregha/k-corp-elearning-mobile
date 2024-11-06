import 'package:flutter/material.dart';
import 'package:k_corp_elearning/argument/course_home_argument.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/util/route_names.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    try {
      // Replace with the actual retrieval logic for the user ID
      final int userId = await _dbHelper.getUserId(username, password);
      
      if (userId != 0) {
        String role = await _dbHelper.getUserRole(userId);
        List<Course> courses = await _dbHelper.getCourses();
        // Save user data to SharedPreferences
        UserPreferences prefs = UserPreferences();
        await prefs.saveUserData(userId, username, role);
        await prefs.cacheCourses(courses);

        Navigator.pushReplacementNamed(
          context,
          RouteNames.courseHome,
          arguments: CourseHomeArguments(userId),
        );
        print("Name is : $username");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: Invalid username or password',
            style: TextStyle(
              color: Colors.white,
            )),
          backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error occurred', style: TextStyle(
            color: Colors.white,
        )),
        backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Login")),
      body: Stack(
        children: [
          Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/intro/login.png", height: 300, width: 300,),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        counterStyle: TextStyle(
                          color: kBlueColor
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, RouteNames.signup),
                      child: const Text("Don't have an account? Sign up",
                        style: TextStyle(
                          color: kBlueColor
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                        
                        ),
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ]),
    );
  }

   // Function to save the logged-in user's name
  Future<void> saveUserNameAndRole(String username, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('userRole', role);
    print('Saved Username: $username, Role: $role'); // Debug print
  }
}

