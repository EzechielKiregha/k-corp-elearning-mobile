import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/util/route_names.dart';
import 'package:k_corp_elearning/db/db_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'STUDENT';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _signup() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
      return;
    }

    // Call the insertUser function from db_helper.dart
    bool success = await _dbHelper.insertUser(username, password, _role);

    // Show a Scaffold message based on the success result
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User registered successfully!', style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: const Color.fromARGB(255, 32, 133, 35),
          ),
      );
      // Navigate to login or next screen here
      Navigator.pushReplacementNamed(context, RouteNames.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User registration failed. Try again.', style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Signup")),
      body: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/intro/signup.png", height: 400, width: 400,),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: _role,
                    onChanged: (newRole) {
                      setState(() {
                        _role = newRole!;
                      });
                    },
                    items: ['STUDENT', 'ADMIN'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, RouteNames.login),
                    child: Text("have an account? Login here",
                      style: TextStyle(
                        color: kBlueColor
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor
                    ),
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white
                      ),
                      ),
                  ),
                  
                ]
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}