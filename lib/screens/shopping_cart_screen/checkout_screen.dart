import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/data_provider/my_course_data_provider.dart';
import 'package:k_corp_elearning/data_provider/shopping_cart_data_provider.dart';
import 'package:k_corp_elearning/model/course.dart';
import 'package:k_corp_elearning/screens/shopping_cart_screen/widget/payment_method.dart';
import 'package:k_corp_elearning/util/route_names.dart';
import 'package:k_corp_elearning/util/util.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.courseList, required this.totalPrice});

  final List<Course> courseList;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Checkout"
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Billing Adress",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10,),
              CSCPicker(
                layout: Layout.vertical,
                flagState: CountryFlag.DISABLE,
                onCountryChanged: (value) {
                  
                },
                onStateChanged: (value) {
                  
                },
                onCityChanged: (value) {
                  
                },
              ),
              const SizedBox(height: 20,),
              Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20,),
              const PaymentMethod(),
              const SizedBox(height: 10,),
              const Text(
                "Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              Expanded(child: 
                ListView.builder(
                  itemCount: courseList.length,
                  itemBuilder: (context, i){
                    Course course = courseList[i];
                    return ListTile(
                      leading: Image.asset(
                        course.thumbnailUrl,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        course.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '\$${course.price}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                })
              )
            ],
          ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                    ),
                    onPressed: (){
                      // place order and add courses to my list of courses 
                      // clear cart
                      MyCourseDataProvider.addAllCourses(courseList);
                      ShoppingCartDataProvider.clearCart();

                      Util.showMeassege(context, "Your Order Was Placed Succefully!",null, null);

                      Navigator.pushNamed(context, RouteNames.courseHome);

                  }, child: Text("Place Order",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}