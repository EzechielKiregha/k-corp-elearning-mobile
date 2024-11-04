import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/model/section.dart';

class Course {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String createdBy;
  final String createdDate;
  final double rate;
  bool isFavorite;
  final double price;
  final String courseCategory;
  final String duration;
  final int lessonNo;
  late final List<Section> sections;

  Course({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
    required this.createdBy,
    required this.createdDate,
    required this.rate,
    required this.isFavorite,
    required this.price,
    required this.courseCategory,
    required this.duration,
    required this.lessonNo,
    required this.sections,
  });

  // Convert Course to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'rate': rate,
      'isFavorite': isFavorite ? true : false,
      'price': price,
      'courseCategory': courseCategory.toString(),
      'duration': duration,
      'lessonNo': lessonNo,
    };
  }

  // Convert Map to Course
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      thumbnailUrl: map['thumbnailUrl'],
      description: map['description'],
      createdBy: map['createdBy'],
      createdDate: map['createdDate'],
      rate: map['rate'],
      isFavorite: map['isFavorite'] == 1,
      price: map['price'],
      courseCategory: map['courseCategory'],
      duration: map['duration'],
      lessonNo: map['lessonNo'],
      sections: [], // Add sections later if needed
    );
  }
}
