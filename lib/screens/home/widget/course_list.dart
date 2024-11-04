import 'package:flutter/material.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/screens/home/widget/course_item.dart';
import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/notifier/course_category_change_notifier.dart';
import 'package:provider/provider.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: getCourseList(context), // Fetch and filter courses by category
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while data is being fetched
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Display error message if something goes wrong
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show a message if no courses are available
          return Center(child: Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children: [
              Image.asset("/assets/images/intro/no-content.png", height: 300, width: 300,),
              Text("No courses available"),
            ],
          ));
        }
        // Display the list of courses in a GridView
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: snapshot.data!.map((course) {
            return CourseItem(course: course);
          }).toList(),
        );
      },
    );
  }

  Future<List<Course>> getCourseList(BuildContext context) async {
    // Retrieve the selected category from the notifier
    var category = Provider.of<CourseCategoryChangeNotifier>(context).Category;

    // Fetch all courses from the database
    List<Course> allCourses = await _dbHelper.getCourses();

    // Apply category filter if a specific category is selected
    if (category != CourseCategory.all) {
      // Filter courses by the selected category
      allCourses = allCourses.where((course) => course.courseCategory == category.title).toList();
    }

    return allCourses;
  }
}