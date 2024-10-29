import 'package:flutter/material.dart';
import 'package:k_corp_elearning/data_provider/course_data_provider.dart';
import 'package:k_corp_elearning/screens/home/widget/course_item.dart';
import 'package:k_corp_elearning/model/course.dart';
import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/notifier/course_category_change_notifier.dart';
import 'package:provider/provider.dart';

class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: getCourseList(context).map((course) {
        return CourseItem(course: course);
      }).toList(),
    );
  }



  List<Course> getCourseList(BuildContext context){

    var category = Provider.of<CourseCategoryChangeNotifier>(context).Category;

    if(category == CourseCategory.all){
      return CourseDataProvider.courseList;
    }

    return CourseDataProvider.courseList.where((course) => course.courseCategory == category).toList();
  }
}