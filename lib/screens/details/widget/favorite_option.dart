import 'package:flutter/material.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/course_db.dart';

class FavoriteOption extends StatefulWidget {
  const FavoriteOption({ super.key, required this.course });

  final Course course;



  @override
  _FavoriteOptionState createState() => _FavoriteOptionState();
}

class _FavoriteOptionState extends State<FavoriteOption> {

  bool isFavorite = false;
  final DatabaseHelper dbHelper = DatabaseHelper();


  void dbLoad(Course course) async{
    dbHelper.updateCourse(course);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isFavorite = widget.course.isFavorite;
    dbLoad(widget.course);

  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        setState(() {
          isFavorite = !isFavorite;
          widget.course.isFavorite = isFavorite;
        });
      },
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.pink,),
    );
  }
}