import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/model/section.dart';
import 'package:k_corp_elearning/model/lecture.dart';
import 'package:uuid/uuid.dart';

void populateDatabase() async {
  final dbHelper = DatabaseHelper();
  var uuid = Uuid();

  // Sample Course data
  var course1 = Course(
    id: uuid.v4(),
    title: 'Introduction to AI',
    thumbnailUrl: 'assets/images/course/programming5.png',
    description: 'Learn the basics of Artificial Intelligence.',
    createdBy: 'Dr. Smith',
    createdDate: DateTime.now().toString(),
    rate: 4.5,
    isFavorite: false,
    price: 49.99,
    courseCategory: 'Technology',
    duration: '5h',
    lessonNo: 10,
  );

  // Sample Sections for the course
  var section1 = Section(
    id: uuid.v4(),
    courseId: course1.id,
    name: 'Introduction to AI Concepts', lectures: [],
  );

  var section2 = Section(
    id: uuid.v4(),
    courseId: course1.id,
    name: 'Machine Learning Basics', lectures: [],
  );

  // Sample Lectures for each section
  var lecture1 = Lecture(
    id: uuid.v4(),
    sectionId: section1.id,
    name: 'What is AI?',
    duration: '20m',
  );

  var lecture2 = Lecture(
    id: uuid.v4(),
    sectionId: section1.id,
    name: 'History of AI',
    duration: '25m',
  );

  var lecture3 = Lecture(
    id: uuid.v4(),
    sectionId: section2.id,
    name: 'Introduction to Machine Learning',
    duration: '30m',
  );

  var lecture4 = Lecture(
    id: uuid.v4(),
    sectionId: section2.id,
    name: 'Types of Machine Learning',
    duration: '35m',
  );

  // Insert the Course, Sections, and Lectures
  await dbHelper.insertCourse(course1);
  await dbHelper.insertSection(section1);
  await dbHelper.insertSection(section2);
  await dbHelper.insertLecture(lecture1);
  await dbHelper.insertLecture(lecture2);
  await dbHelper.insertLecture(lecture3);
  await dbHelper.insertLecture(lecture4);

  print('Database populated with sample data');
}
