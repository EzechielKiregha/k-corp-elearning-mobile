import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/notifier/course_category_change_notifier.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {

    var category = Provider.of<CourseCategoryChangeNotifier>(context).Category;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 35,
          child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: CourseCategory.values.length,
              itemBuilder: (context, i) {
                CourseCategory courseCategory = CourseCategory.values[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Provider.of<CourseCategoryChangeNotifier>(context, 
                      listen: false
                      ).ChangeCategory(courseCategory);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: category == courseCategory ? kPrimaryColor : Colors.white,
                        border: Border.all(color : Colors.grey.shade900),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          courseCategory.title,
                          style: TextStyle(
                            fontSize: 20,
                            color: category == courseCategory? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            )
        )
      ],
    );
  }
}