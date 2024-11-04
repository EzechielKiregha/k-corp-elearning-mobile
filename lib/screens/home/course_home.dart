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

import '../../shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CourseHome extends StatefulWidget {
  const CourseHome({super.key});

  @override
  State<CourseHome> createState() => _CourseHomeState();
}

class _CourseHomeState extends State<CourseHome> {

  String userName = "USER";
  String userRole = 'ADMIN';
  int userId = 1;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserPreferences prefs = UserPreferences();
    String? name = await prefs.getUsername();
    String? role = await prefs.getUserRole();
    int? id = await prefs.getUserId();
    setState(() {
      userName = name ?? "User";
      userRole = role ?? "ADMIN";
      userId = id ?? 1;
    });
  }

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
                    Header(),
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
      ),
    );
  }
}