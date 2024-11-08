import 'package:k_corp_elearning/model/course_db.dart';

class ShoppingCartDataProvider {
  static final List<Course> _shoppingCartCourseList = [];

  static List<Course> get shoppingCartCourseList => _shoppingCartCourseList;

  static void addCourse(Course course){
    _shoppingCartCourseList.add(course);
  }

  static void addAllCourses(List<Course> courses){
    _shoppingCartCourseList.addAll(courses);
  }

  static void deleteCourse(Course course){
    _shoppingCartCourseList.remove(course);
  }

  static void clearCart(){
    _shoppingCartCourseList.clear();
  }
}