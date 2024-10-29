import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:k_corp_elearning/model/course_category.dart';

class CourseCategoryChangeNotifier extends ChangeNotifier {
  CourseCategory _category = CourseCategory.all;

  CourseCategory get Category => _category;

  void ChangeCategory(CourseCategory category) {
    _category = category;
    notifyListeners();
    
  }
  
}