import 'package:flutter/material.dart';
import 'package:k_corp_elearning/util/route_names.dart';

class CourseManagementScreen extends StatelessWidget {
  const CourseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Courses")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.courseDetails);
              },
              icon: Icon(Icons.add),
              label: Text("Create New Course"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with dynamic data count
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("Course Title $index"),
                      subtitle: Text("Category, Price"),
                      trailing: Icon(Icons.edit),
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.courseDetails);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
