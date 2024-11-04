import 'package:flutter/material.dart';
import 'package:k_corp_elearning/components/button_option.dart';
import 'package:k_corp_elearning/components/shopping_cart_option.dart';
import 'package:k_corp_elearning/screens/courses/widget/wishlist.dart';

import '../../shared_preferences.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "WishList",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 10,),

              Wishlist(),
            ],
          ),
        )
      ),

      floatingActionButton: const ShoppingCartOption(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ButtonOption(
         selected : 3,
      ),
    );
  }
}