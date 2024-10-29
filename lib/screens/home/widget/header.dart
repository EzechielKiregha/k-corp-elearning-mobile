import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {

  final int id;
  const Header({super.key, required this.id, required this.usernameFuture});
  final Future<String> usernameFuture;
  
  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome $usernameFuture",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Let's learning something today",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: kOptionColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                        const Icon(Icons.notifications, color: Colors.white),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          
                        )
                        ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: kOptionColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: const Icon(Icons.person, color: Colors.white,)
                  )
                ],
              )
            ],
          );
  }
}