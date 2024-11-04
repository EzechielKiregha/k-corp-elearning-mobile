import 'package:k_corp_elearning/model/lecture.dart';

class Section {
  final String id;
  late final String courseId; // Reference to the Course
  late final String name;
  final List<Lecture> lectures;

  Section({required this.id, required this.courseId, required this.name, required this.lectures});

  // Convert Section to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
    };
  }

  // Construct Section from Map
  factory Section.fromMap(Map<String, dynamic> map, List<Lecture> lectures) {
    return Section(
      id: map['id'],
      courseId: map['courseId'],
      name: map['name'],
      lectures: lectures,
    );
  }
}
