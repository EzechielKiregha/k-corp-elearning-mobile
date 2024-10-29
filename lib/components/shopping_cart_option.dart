import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/util/util.dart';

class ShoppingCartOption extends StatelessWidget {
  const ShoppingCartOption({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      onPressed: () {
        Util.openShoppingCart(context);
    },
      child: const Icon(
        color: Colors.white,
        Icons.shopping_cart
      ) ,
    
    );
  }
}