import 'package:flutter/material.dart';
import 'package:k_corp_elearning/components/button_option.dart';
import 'package:k_corp_elearning/components/shopping_cart_option.dart';
import 'package:k_corp_elearning/util/route_names.dart';

import '../../shared_preferences.dart';


class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              logoutUser(context);
                            },
                            child: Icon(
                              Icons.logout,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              // Profile Information
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Icon(Icons.account_circle, size: 60, color: Colors.blue),
                      SizedBox(height: 10),
                      Text(
                        userName != null ? userName : "Not Loaded",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userRole == "ADMIN" ? "Admin" : "Student",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildAccountOption(context, "My Courses", RouteNames.myCourseList),
                    _buildAccountOption(context, "Wishlist", RouteNames.wishList),
                    userRole == "ADMIN"
                        ? _buildAccountOption(context, "Manage Courses", RouteNames.manageCourse)
                        : SizedBox.shrink(),
                    _buildAccountOption(context, "Settings", RouteNames.settings),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const ShoppingCartOption(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ButtonOption(
         selected : 4,
      ),
    );
  }

  Widget _buildAccountOption(BuildContext context, String title, String routeName) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          switch (routeName){
            case RouteNames.courseHome:
              Navigator.pushReplacementNamed(context, routeName
              );
              break;
            case RouteNames.wishList:
              Navigator.pushReplacementNamed(context, routeName
              );
            break;
            case RouteNames.accountScreen:
              Navigator.pushReplacementNamed(context, routeName
              );
              break;
            case RouteNames.myCourseList:
              Navigator.pushReplacementNamed(context, routeName
              );
              break;
            case RouteNames.manageCourse:
              Navigator.pushReplacementNamed(context, routeName
              );
              break;
          }
        },
      ),
    );
  }

  void logoutUser(BuildContext context) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear(); // or use prefs.remove('username') to remove a specific key
    Navigator.pushReplacementNamed(context, RouteNames.intro);
  }
}
