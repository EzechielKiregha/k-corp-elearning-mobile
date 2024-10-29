import 'package:flutter/material.dart';
import 'package:k_corp_elearning/components/button_option.dart';
import 'package:k_corp_elearning/components/shopping_cart_option.dart';
import 'package:k_corp_elearning/screens/courses/widget/wishlist.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key, required this.userId});
  final int userId; 

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
         userId: userId,
      ),
    );
  }
}