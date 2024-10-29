import 'package:flutter/material.dart';
import 'package:k_corp_elearning/components/button_option.dart';
import 'package:k_corp_elearning/components/shopping_cart_option.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/screens/home/widget/category_course_list.dart';
import 'package:k_corp_elearning/screens/home/widget/course_search.dart';
import 'package:k_corp_elearning/screens/home/widget/featured_course.dart';
import 'package:k_corp_elearning/screens/home/widget/header.dart';
import 'package:k_corp_elearning/screens/home/widget/offers.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CourseHome extends StatelessWidget {
  const CourseHome({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            Container(
              height: 170,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Header(id:  userId, usernameFuture: dbCallUserName()),
                    const SizedBox(
                      height: 10,
                    ),
                    const CourseSearch(),
                  ],
                ),
              )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // our offers done
                    Offers(),
                    // featured courses
                    const FeaturedCourse(),
                    const CategoryCourseList(),
                  ],
                ),
              )
          ],
          ),
        ),
      ),
      floatingActionButton: const ShoppingCartOption(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ButtonOption(
         selected : 1,
         userId : userId,
      ),
    );
  }

  Future<String> dbCallUserName() async{
    final DatabaseHelper db = DatabaseHelper();
      return db.getUsername(userId);
    }
}