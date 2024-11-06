import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/util/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseManagementScreen extends StatefulWidget {
  const CourseManagementScreen({super.key});

  @override
  State<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {

  List<Course> courses= [];

  @override
  void initState() {
    super.initState();
    _loadCourse();
  }

  void _loadCourse() async {
    List<Course> all = await getCourseList(context);
    setState(() {
      courses = all;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Course"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // _saveCourse;
                print("clear all!");
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.oneCourseDetails);
              },
              icon: Icon(Icons.add),
              label: Text("Create New Course"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return personalizeCourse(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget personalizeCourse(BuildContext context, int i) {
    final DatabaseHelper dbHelper = DatabaseHelper();
    return Card(
      child: ListTile(
        leading: Image.asset(
            courses[i].thumbnailUrl,
          height: 50,
          width: 80,
        ),
        title: Text(
          courses[i].title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "By ${courses[i].createdBy}",
              style: TextStyle(
                  color: kBlueColor,
                  fontSize: 13
              ),
            ),
            Row(
              children: [
                Text(
                  courses[i].duration,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 3,
                  child: Container(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${courses[i].lessonNo} Lessons',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 3,
                  child: Container(),
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        '${courses[i].rate}'
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${courses[i].price}',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: () {
                    dbHelper.deleteCourse(courses[i].id);
                    setState(() {

                    });
                  },
                  child: Icon(
                      Icons.delete
                  ),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: () {

                  },
                  child: Icon(
                      Icons.edit
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<List<Course>> getCourseList(BuildContext context) async {
    // retrieve cached courses
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? coursesJson = prefs.getString('cachedCourses');
    List<Course> allCourses = [];
    if (coursesJson != null) {
      // Decode JSON string back to list of Course objects
      List<dynamic> coursesList = jsonDecode(coursesJson);
      allCourses = coursesList.map((json) => Course.fromMap(json)).toList();
    }
    return allCourses;
  }
}
