import 'package:flutter/material.dart';
import 'package:k_corp_elearning/constants.dart';
import 'package:k_corp_elearning/data_provider/course_data_provider.dart';
import 'package:k_corp_elearning/model/course.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({ super.key });

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {

    List<Course> courseList = getCourseList(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: courseList.length,
      itemBuilder: (context, i){
        Course course = courseList[i];
        return getListItem(course);
      },
      
    );
  }

  List<Course> getCourseList(BuildContext context){
    return CourseDataProvider.courseList.where(
      (course) => course.isFavorite
    ).toList();
  }

  Widget getListItem(Course course){
    return Card(
      child: ListTile(
        leading: Image.asset(
          course.thumbnailUrl,

        ),
        title: Text(
          course.title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "By ${course.createdBy}",
              style: TextStyle(
                color: kBlueColor,
                fontSize: 13
              ),
            ),
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
                  backgroundColor: Colors.grey,
                  radius: 3,
                  child: Container(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${course.lessonNo} Lessons',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 3,
                  child: Container(),
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${course.rate}'
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${course.price}',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: () {
                    setState(() {
                      course.isFavorite = false;
                    });
                  },
                  child: Icon(
                    Icons.delete
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}