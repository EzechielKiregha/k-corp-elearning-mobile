import 'package:flutter/material.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/course_category.dart';
import 'package:k_corp_elearning/model/course_db.dart';
import 'package:k_corp_elearning/model/section.dart';
import 'package:k_corp_elearning/model/lecture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  // Text controllers for the main course fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _thumbnailImage;
  final DatabaseHelper dbHelper = DatabaseHelper();
  final uuid = Uuid();

  // Dropdown for category selection
  CourseCategory? _selectedCategory = CourseCategory.all;

  // Lists to hold sections and their text controllers
  List<Section> sections = [];
  List<TextEditingController> sectionControllers = [];

  // Map of lecture controllers (one list per section)
  Map<int, List<TextEditingController>> lectureControllers = {};

  Future<void> _pickThumbnail() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final savePath = '${directory.path}/courses/${basename(pickedFile.path)}';

      await Directory('${directory.path}/courses').create(recursive: true);

      final savedImage = await File(pickedFile.path).copy(savePath);
      setState(() {
        _thumbnailImage = savedImage;
      });
    }
  }

  void _addSection() {
    final sectionId = uuid.v4();
    final sectionController = TextEditingController();

    setState(() {
      sections.add(Section(id: sectionId, courseId: '', name: '', lectures: []));
      sectionControllers.add(sectionController);
      lectureControllers[sections.length - 1] = [];
    });
  }

  void _addLecture(int sectionIndex) {
    final lectureId = uuid.v4();
    final lectureNameController = TextEditingController();
    final lectureDurationController = TextEditingController();

    setState(() {
      sections[sectionIndex].lectures.add(Lecture(id: lectureId, sectionId: '', name: '', duration: '1h'));
      lectureControllers[sectionIndex]!.add(lectureNameController);
      lectureControllers[sectionIndex]!.add(lectureDurationController);
    });
  }

  Future<void> _saveCourse() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    final newCourse = Course(
      id: uuid.v4(),
      title: title,
      thumbnailUrl: _thumbnailImage?.path ?? '',
      description: description,
      createdBy: 'Admin',
      createdDate: DateTime.now().toString(),
      rate: 0.0,
      isFavorite: false,
      price: price,
      courseCategory: _selectedCategory?.title ?? 'Other',
      duration: '0h',
      lessonNo: sections.fold(0, (prev, section) => prev + section.lectures.length),
      sections: sections,
    );

    final courseId = await dbHelper.insertCourse(newCourse);

    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      section.courseId = courseId;
      section.name = sectionControllers[i].text;

      final sectionId = await dbHelper.insertSection(section);

      for (int j = 0; j < section.lectures.length; j++) {
        final lecture = section.lectures[j];
        lecture.sectionId = sectionId;
        lecture.name = lectureControllers[i]![j].text;

        await dbHelper.insertLecture(lecture);
      }
    }

    Navigator.pop(context as BuildContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Course")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: _pickThumbnail,
                child: _thumbnailImage != null
                    ? Image.file(_thumbnailImage!)
                    : Image.asset('/assets/images/course/programming1.png'),
              ),
            ),
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Course Title")),
            TextField(controller: _descriptionController, decoration: InputDecoration(labelText: "Course Description"), maxLines: 2),
            TextField(controller: _priceController, decoration: InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
            DropdownButton<CourseCategory>(
              value: _selectedCategory,
              onChanged: (CourseCategory? newValue) => setState(() => _selectedCategory = newValue),
              items: CourseCategory.values.map<DropdownMenuItem<CourseCategory>>((CourseCategory category) {
                return DropdownMenuItem<CourseCategory>(
                  value: category,
                  child: Text(category.title),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Sections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: TextField(
                      controller: sectionControllers[index],
                      decoration: InputDecoration(labelText: 'Section Name'),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: sections[index].lectures.length,
                        itemBuilder: (context, lectureIndex) {
                          return Column(
                            children: [
                              TextField(
                                controller: lectureControllers[index]![lectureIndex * 2],
                                decoration: InputDecoration(labelText: 'Lecture Name'),
                              ),
                              TextField(
                                controller: lectureControllers[index]![lectureIndex * 2 + 1],
                                decoration: InputDecoration(labelText: 'Duration'),
                              ),
                            ],
                          );
                        },
                      ),
                      TextButton.icon(
                        onPressed: () => _addLecture(index),
                        icon: Icon(Icons.add),
                        label: Text("Add Lecture"),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addSection,
              icon: Icon(Icons.add),
              label: Text("Add Section"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveCourse, child: Text("Save Course")),
          ],
        ),
      ),
    );
  }
}

