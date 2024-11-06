import 'package:flutter/material.dart';
import 'package:k_corp_elearning/model/lecture.dart';
import 'package:uuid/uuid.dart';

class LectureScreen extends StatefulWidget {
  final String sectionId;

  const LectureScreen({Key? key, required this.sectionId}) : super(key: key);

  @override
  _LectureScreenState createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  void _saveLecture() {
    final lecture = Lecture(
      id: Uuid().v4(),
      sectionId: widget.sectionId,
      name: _nameController.text,
      duration: _durationController.text,
    );

    Navigator.pop(context, lecture);  // Return lecture to SectionScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Lecture")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Lecture Name"),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: "Duration (e.g., 1h 30m)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLecture,
              child: Text("Save Lecture"),
            ),
          ],
        ),
      ),
    );
  }
}
