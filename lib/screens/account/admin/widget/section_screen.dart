import 'package:flutter/material.dart';
import 'package:k_corp_elearning/db/db_helper.dart';
import 'package:k_corp_elearning/model/lecture.dart';
import 'package:k_corp_elearning/model/section.dart';
import 'package:k_corp_elearning/screens/account/admin/widget/lecture_screen.dart';
import 'package:uuid/uuid.dart';

class SectionScreen extends StatefulWidget {
  final String courseId;  // Pass from CreateCourseScreen
  final Section? section;

  const SectionScreen({Key? key, required this.courseId, this.section}) : super(key: key);

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<Lecture> lectures = [];

  @override
  void initState() {
    super.initState();
    if (widget.section != null) {
      _nameController.text = widget.section!.name;
      lectures = widget.section!.lectures;
    }
  }

  void _addLecture() async {
    final newLecture = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LectureScreen(sectionId: widget.section?.id ?? ''),
      ),
    );

    if (newLecture != null) {
      setState(() {
        lectures.add(newLecture);
      });
    }
  }

  Future<void> _saveSection() async {
    final section = Section(
      id: widget.section?.id ?? Uuid().v4(),
      courseId: widget.courseId,
      name: _nameController.text,
      lectures: lectures,
    );

    // Save the section to database
    final sectionId = await DatabaseHelper().insertSection(section);

    // Save each lecture
    for (final lecture in lectures) {
      lecture.sectionId = sectionId;
      await DatabaseHelper().insertLecture(lecture);
    }

    Navigator.pop(context, section);  // Pass the section back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add/Edit Section")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Section Name"),
            ),
            const SizedBox(height: 16),
            Text("Lectures", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: lectures.length,
              itemBuilder: (context, index) {
                final lecture = lectures[index];
                return ListTile(
                  title: Text(lecture.name),
                  subtitle: Text("Duration: ${lecture.duration}"),
                );
              },
            ),
            ElevatedButton(
              onPressed: _addLecture,
              child: Text("Add Lecture"),
            ),
            ElevatedButton(
              onPressed: _saveSection,
              child: Text("Save Section"),
            ),
          ],
        ),
      ),
    );
  }
}

