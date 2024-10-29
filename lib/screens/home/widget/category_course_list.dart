import 'package:flutter/material.dart';
import 'package:k_corp_elearning/screens/home/widget/category_list.dart';
import 'package:k_corp_elearning/screens/home/widget/course_list.dart';
import 'package:k_corp_elearning/notifier/course_category_change_notifier.dart';
import 'package:provider/provider.dart';

class CategoryCourseList extends StatelessWidget {
  const CategoryCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseCategoryChangeNotifier(),
      child: Column(
        children: const [
          CategoryList(),
          CourseList(),
        ],
      ),
    );
  }
}