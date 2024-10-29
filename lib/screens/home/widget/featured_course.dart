import 'package:flutter/material.dart';
import 'package:k_corp_elearning/data_provider/course_data_provider.dart';
import 'package:k_corp_elearning/screens/home/widget/course_item.dart';
import 'package:k_corp_elearning/model/course.dart';

class FeaturedCourse extends StatelessWidget {
  const FeaturedCourse({super.key});

  @override
  Widget build(BuildContext context) {

    List<Course> featuredCourseList = [
      CourseDataProvider.courseList[9],
      CourseDataProvider.courseList[0],
      CourseDataProvider.courseList[1],
      CourseDataProvider.courseList[2],
      CourseDataProvider.courseList[10],
      CourseDataProvider.courseList[5],
    ];
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredCourseList.length,
            itemBuilder: (context, i){
              Course course = featuredCourseList[i];
              return CourseItem(course: course);
          }),
        )
      ],
    );
  }
}