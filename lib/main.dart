import 'package:flutter/material.dart';
import 'package:k_corp_elearning/argument/account_arguments.dart';
import 'package:k_corp_elearning/argument/checkout_argument.dart';
import 'package:k_corp_elearning/argument/course_argument.dart';
import 'package:k_corp_elearning/argument/course_home_argument.dart';
import 'package:k_corp_elearning/argument/my_course_list_args.dart';
import 'package:k_corp_elearning/argument/wish_list_arguments.dart';
import 'package:k_corp_elearning/screens/account/account_screen.dart';
import 'package:k_corp_elearning/screens/account/course_management_screen.dart';
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
        } else if (settings.name == RouteNames.courseHome){
          final args = settings.arguments as CourseHomeArguments;
          return MaterialPageRoute(
            builder: (context) => CourseHome(
              userId: args.userId,
            )
          );
        } else if (settings.name == RouteNames.accountScreen){
          final args = settings.arguments as AccountArguments;
          return MaterialPageRoute(
            builder: (context) => AccountScreen(
              userId: args.userId,
            )
          );
        } else if (settings.name == RouteNames.wishList){
          final args = settings.arguments as WishListArguments;
          return MaterialPageRoute(
            builder: (context) => WishlistScreen(
              userId: args.userId,
            )
          );
        } else if (settings.name == RouteNames.myCourseList){
          final args = settings.arguments as MyCourseListArgs;
          return MaterialPageRoute(
            builder: (context) => MyCourseList(
              userId: args.userId,
            )
          );
        } else if (settings.name == RouteNames.accountScreen){
          final args = settings.arguments as AccountArguments;
          return MaterialPageRoute(
            builder: (context) => AccountScreen(
              userId: args.userId,
            )
          );
        } 
        return null;
      });
  }
}

