import 'package:flutter/material.dart';
import 'package:k_corp_elearning/argument/account_arguments.dart';
import 'package:k_corp_elearning/argument/course_home_argument.dart';
import 'package:k_corp_elearning/argument/my_course_list_args.dart';
import 'package:k_corp_elearning/argument/wish_list_arguments.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/util/route_names.dart';

class ButtonOption extends StatelessWidget {
  const ButtonOption({super.key, required this.selected, required this.userId});

  final int selected;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // onclick of this button I must open the respective screen
                openScreen(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      color: getSelectedColor(1),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Home", style: TextStyle(
                      fontSize: 13,
                      color : getSelectedColor(1)
                    ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // onclick of this button I must open the respective screen
                openScreen(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      color: getSelectedColor(2),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Courses", style: TextStyle(
                      fontSize: 13,
                      color : getSelectedColor(2)
              
                    ),),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // onclick of this button I must open the respective screen
                openScreen(context, 3);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: getSelectedColor(3),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Wishlist", style: TextStyle(
                      fontSize: 13,
                      color : getSelectedColor(3)
              
                    ),),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // onclick of this button I must open the respective screen
                openScreen(context, 4);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people,
                      color: getSelectedColor(4),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Account", style: TextStyle(
                      fontSize: 13,
                      color : getSelectedColor(4)
              
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getSelectedColor(int optionIndex){
    return (selected == optionIndex) ? kPrimaryColor : Colors.grey.shade800;
  }
  void openScreen(BuildContext context, int selectedOptionNo){

    String routeName = RouteNames.courseHome;
    switch (selectedOptionNo) {
      case 2:
        routeName = RouteNames.myCourseList;
        Navigator.pushReplacementNamed(context, routeName,
          arguments: MyCourseListArgs(userId),
        );
        break;
      case 3:
        routeName = RouteNames.wishList;
        Navigator.pushReplacementNamed(context, routeName,
          arguments: WishListArguments(userId),
        );
        break;
      case 4:
        routeName = RouteNames.accountScreen;
        Navigator.pushReplacementNamed(context, routeName,
          arguments: AccountArguments(userId),
        );
        break;
    }
    Navigator.pushReplacementNamed(context, routeName,
      arguments: CourseHomeArguments(userId),
    );
  }

}