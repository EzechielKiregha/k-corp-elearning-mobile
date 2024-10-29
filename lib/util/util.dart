import 'package:flutter/material.dart';

class Util {

  static void showMeassege(
    BuildContext context,
    String message,
    String? actionLabel,
    VoidCallback? onPressed
  ){
    showMeassageWithAction(context, message, null, null );
  }

  static void openShoppingCart(BuildContext context){
    Navigator.pushNamed(context, "/shoppingCart");
  }

  static void showMeassageWithAction(
    BuildContext context,
    String message,
    String? actionLabel,
    VoidCallback? onPressed
  ){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.grey.shade900,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      action: actionLabel != null
        ? SnackBarAction(label: actionLabel, onPressed: onPressed!)
        : null,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ),

    ));
  }
}