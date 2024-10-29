import 'package:flutter/material.dart';
import 'package:k_corp_elearning/components/button_option.dart';
import 'package:k_corp_elearning/components/shopping_cart_option.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/data_provider/my_course_data_provider.dart';
import 'package:k_corp_elearning/model/my_course.dart';

class MyCourseList extends StatelessWidget {
  const MyCourseList({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {

    List<MyCourse> myCourseList = MyCourseDataProvider.myCourses;

    if(myCourseList.isNotEmpty){
      myCourseList[1].progress = 60;
      myCourseList[2].progress = 30;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "My Courses",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ),
              ),
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey.shade900)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "All Courses",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey.shade900)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Dowloaded courses",
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey.shade900)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Archived courses",
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey.shade900)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Completed Courses",
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Expanded(child: ListView.builder(
                itemCount: myCourseList.length,
                itemBuilder: (context,i){
                  MyCourse myCourse = myCourseList[i];
                  return getMyCourse(context, myCourse);
              }))
            ],
          ),
        )
      ),
      floatingActionButton: ShoppingCartOption(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ButtonOption(
         selected : 2,
         userId: userId,
      ),
    );
  }
}
Widget getMyCourse(BuildContext context, MyCourse myCourse){
    return Card(
      child: ListTile(
        leading: Image.asset(myCourse.course.thumbnailUrl),
        title: Text(
          myCourse.course.title,
          maxLines: 2,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myCourse.course.createdBy,
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 10,),
            Visibility(
              
              visible: myCourse.progress > 0,
              replacement: const Text(
                "Start Course",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlueColor
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        thumbColor: Colors.transparent,
                        overlayShape: SliderComponentShape.noThumb,
                        thumbShape: SliderComponentShape.noThumb
                      ),
                      child: Slider(
                      min: 0,
                      max: 100,
                      value: myCourse.progress.toDouble(),
                      onChanged: (val){
                        // 
                      }
                      ),
                    )
                  ),
                  const SizedBox(width: 10,),
                  Text('${myCourse.progress} %')
                ],
              )
            ),
            
          ],
        ),
      ),
    );
  }