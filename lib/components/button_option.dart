import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/util/route_names.dart';

import '../shared_preferences.dart';

class ButtonOption extends StatefulWidget {
  const ButtonOption({super.key, required this.selected});

  final int selected;

  @override
  State<ButtonOption> createState() => _ButtonOptionState();
}

class _ButtonOptionState extends State<ButtonOption> {

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
    return (widget.selected == optionIndex) ? kPrimaryColor : Colors.grey.shade800;
  }

  void openScreen(BuildContext context, int selectedOptionNo){

    String routeName = RouteNames.courseHome;
    switch (selectedOptionNo) {
      case 2:
        routeName = RouteNames.myCourseList;
        Navigator.pushReplacementNamed(context, routeName
        );
        break;
      case 3:
        routeName = RouteNames.wishList;
        Navigator.pushReplacementNamed(context, routeName
        );
        break;
      case 4:
        routeName = RouteNames.accountScreen;
        Navigator.pushReplacementNamed(context, routeName
        );
        break;
    }
    Navigator.pushReplacementNamed(context, routeName
    );
  }
}