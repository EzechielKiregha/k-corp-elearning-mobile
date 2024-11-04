import 'package:flutter/material.dart';
import 'package:k_corp_elearning/argument/checkout_argument.dart';
import 'package:k_corp_elearning/argument/course_argument.dart';
import 'package:k_corp_elearning/screens/account/account_screen.dart';
import 'package:k_corp_elearning/screens/account/admin/course_creation_screen.dart';
import 'package:k_corp_elearning/screens/account/admin/course_management_screen.dart';
import 'package:k_corp_elearning/screens/auth/login_screen.dart';
import 'package:k_corp_elearning/screens/auth/signup_screen.dart';
import 'package:k_corp_elearning/screens/courses/wishlist_screen.dart';
import 'package:k_corp_elearning/screens/courses/my_course_list.dart';
import 'package:k_corp_elearning/screens/details/course_details.dart';
import 'package:k_corp_elearning/screens/home/course_home.dart';
import 'package:k_corp_elearning/screens/intro/intro_screen.dart';
import 'package:k_corp_elearning/screens/shopping_cart_screen/checkout_screen.dart';
import 'package:k_corp_elearning/screens/shopping_cart_screen/shopping_cart_screen.dart';
import 'package:k_corp_elearning/util/route_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        RouteNames.intro: (context) => const IntroScreen(),
        RouteNames.shoppingCart: (context) => const ShoppingCartScreen(),
        RouteNames.login: (context) => LoginScreen(),
        RouteNames.signup: (context) => SignupScreen(),
        RouteNames.manageCourse : (context) => CourseManagementScreen(),
        RouteNames.accountScreen : (context) => AccountScreen(),
        RouteNames.courseHome : (context) => CourseHome(),
        RouteNames.wishList : (context) => WishlistScreen(),
        RouteNames.myCourseList : (context) => MyCourseList(),
        RouteNames.oneCourseDetails: (context) => CreateCourseScreen(),
      },

      onGenerateRoute: (settings){
        if ( settings.name == RouteNames.courseDetails){
          final args = settings.arguments as CourseArgument;
          return MaterialPageRoute(builder: (context) => CourseDetails(course: args.course));
        } else if (settings.name == RouteNames.checkout){
          final args = settings.arguments as CheckoutArgument;
          return MaterialPageRoute(builder: (context) => CheckoutScreen(
            courseList: args.courseList,
            totalPrice: args.totalPrice
            ));
        }
        return null;
      });
  }
}

