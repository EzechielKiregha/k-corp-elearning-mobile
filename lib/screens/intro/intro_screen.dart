import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/util/route_names.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/intro/Welcome.png"),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Grow your skills",
            style: TextStyle(fontSize: 25, color: Colors.grey.shade900),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Join our community and start learning today!",
            style: TextStyle(fontSize: 17, color: Colors.grey.shade900),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
            // getting started button navigate to home
            Navigator.pushNamed(context, RouteNames.login);
          }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child : Text(
                "Getting Started",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              ),
          ),
        ],
      ),
    );
  }
}