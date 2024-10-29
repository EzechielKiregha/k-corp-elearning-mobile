import 'package:flutter/material.dart';

class CourseSearch extends StatelessWidget {
  const CourseSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for courses...',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(Icons.search, size: 20,),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),     
      ),
    );
  }
}