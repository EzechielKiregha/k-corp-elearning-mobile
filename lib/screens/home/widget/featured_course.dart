import 'package:flutter/material.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/notifier/course_category_change_notifier.dart';
import 'package:k_corp_elearning/screens/home/widget/course_item.dart';
import 'package:provider/provider.dart';

class FeaturedCourse extends StatefulWidget {
  const FeaturedCourse({super.key});

  @override
  State<FeaturedCourse> createState() => _FeaturedCourseState();
}

class _FeaturedCourseState extends State<FeaturedCourse> {

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Featured Courses",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Text(
                "See All",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        SizedBox(
          height: 200,
          child: FutureBuilder<List<Course>>(
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
                return Center(child: Text("No courses available"));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, i){
                  Course course = snapshot.data![i];
                  return CourseItem(course: course);
              });
            }
          ),
        )
      ],
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