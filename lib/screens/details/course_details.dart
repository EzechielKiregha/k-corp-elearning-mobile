import 'package:flutter/material.dart';
import 'package:k_corp_elearning/argument/checkout_argument.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/data_provider/shopping_cart_data_provider.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/screens/details/widget/favorite_option.dart';
import 'package:k_corp_elearning/model/section.dart';
import 'package:k_corp_elearning/util/route_names.dart';
import 'package:k_corp_elearning/util/util.dart';
import 'package:readmore/readmore.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key, required this.course});

  final Course course;
  @override
  Widget build(BuildContext context) {

    var greyStyle = TextStyle(fontSize: 15, color: Colors.grey.shade600);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Icon(
                                Icons.share,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Util.openShoppingCart(context);
                                },
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                    
                          ],
                        )
                    
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: 
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(course.thumbnailUrl)
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.play_arrow,
                                size: 90,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Preview this course",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              )
                            ],
                          )
                      ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          Text(
                              course.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                        
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: kBlueColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    course.createdBy,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: kBlueColor,
                                    ),
                                  )
                                ],
                              ),
                              // favorite 
                              FavoriteOption(course: course,)
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${course.lessonNo}',
                                    style: greyStyle,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    course.duration,
                                    style: greyStyle,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 25,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${course.rate}',
                                    style: greyStyle,
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          ReadMoreText(course.description,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: "Show more",
                            trimExpandedText: "Show less",
                            moreStyle: const TextStyle(
                              color: kBlueColor,
                              fontWeight: FontWeight.bold,
                            ),
                            lessStyle: const TextStyle(
                              color: kBlueColor,
                              fontWeight: FontWeight.bold,
                            ),
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Course content",
                                style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "(${course.sections.length})",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: course.sections.length,
                            itemBuilder: (context, i) {
                              return buildCourseContent(i);
                            }
                          ),
                        ],
                      )
                    ),
                  ),
                ],
                      ),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${course.price}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              String message = "Course is already added to cart";
                              if(!ShoppingCartDataProvider.shoppingCartCourseList.contains(course)){
                                message = "Course added successfully!";
                                ShoppingCartDataProvider.addCourse(course);
                              }
                              // show message toast
                              Util.showMeassageWithAction(context, message, "View", (){
                                // Open the cart
                                Util.openShoppingCart(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                          child: const Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          )
                          ),
                          const SizedBox(width: 10,),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, RouteNames.checkout,
                                arguments: CheckoutArgument([course], course.price)
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                          child: const Text(
                            "Buy",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          )
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
    );
  }

  // function to build course content 
  Widget buildCourseContent(int i){
    Section section = course.sections[i];
    return ExpansionTile(
      title: Text(
        "Section ${i + 1} - ${section.name}",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: section.lectures.map((lecture){
        return ListTile(
          dense: true,
          onTap: (){

          },
          leading: const SizedBox(),
          title: Text(lecture.name),
          subtitle: Row(
            children: [
              Icon(
                Icons.access_time,
                size: 15,
              ),
              const SizedBox(width: 10,),
              Text(
                lecture.duration,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                ),
              )
            ],
          ),
        );
      }).toList(),

    );
  }
}