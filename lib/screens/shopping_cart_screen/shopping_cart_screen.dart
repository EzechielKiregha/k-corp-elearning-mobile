
import 'package:flutter/material.dart';
import 'package:k_corp_elearning/argument/checkout_argument.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/data_provider/shopping_cart_data_provider.dart';
import 'package:k_corp_elearning/model/course.dart';
import 'package:k_corp_elearning/util/route_names.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {

    double totalAmount = calculateTotal();
    List<Course> cartCourseList = ShoppingCartDataProvider.shoppingCartCourseList;

    return Scaffold(
       appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Shopping Cart"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Text(
                      "Total : ",
                      style: TextStyle(
                        fontSize: 20, color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      '\$$totalAmount',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promotion",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 285,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter promo code...",
                            border: OutlineInputBorder(),
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(onPressed: (){
                          // Click to apply the promo code to your purchase

                        },
                        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, foregroundColor: Colors.white),
                        child: const Text(
                          "Apply",
                        )),
                      ),
          
                    ],
                  ),
                  Text(
                    "${cartCourseList.length} Courses in List",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: cartCourseList.length,
                  itemBuilder: (context, i) {
                    return createShoppingCartItem(i);
                },
                )
              ),
            ],
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
            child: ElevatedButton(onPressed: (){
              // checkout is open
              Navigator.pushNamed(context, RouteNames.checkout, arguments: CheckoutArgument(cartCourseList, totalAmount) );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 20,

                ),
              ),
            )),
          )
          ],
        ),
      ),
    );
  }

  // function to calculate the total price
  double calculateTotal(){
    return ShoppingCartDataProvider.shoppingCartCourseList.fold(0, (old, course) => old + course.price);
  }

  // function to create item in cart
  Widget createShoppingCartItem(int i){
    Course course = ShoppingCartDataProvider.shoppingCartCourseList[i];
    return Card(
      child: ListTile(
        leading : Image.asset(course.thumbnailUrl),
        title: Text(
          course.title,
          maxLines: 2,
          style: TextStyle(
            fontSize: 17,
            color:  Colors.grey.shade800,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By ${course.createdBy}',
              style: TextStyle(
                color: kBlueColor, fontSize: 14
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                 Text(
                  course.duration,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                 ),

                 const SizedBox(
                  width: 10,
                 ),
                 CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.grey,
                  child: Container(),
                 ),
                 const SizedBox(
                  width: 10,
                 ),

                Text(
                  "${course.lessonNo} Lessons",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                 ),
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${course.price}'
            ),
            InkWell(
              onTap: (){
                setState(() {
                  ShoppingCartDataProvider.deleteCourse(course);
                });
              },
              child: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}