class Lecture {
  final String id;
  late final String sectionId; // Reference to the Section
  late final String name;
  final String duration;

  Lecture({required this.id, required this.sectionId, required this.name, required this.duration});

  // Convert Lecture to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sectionId': sectionId,
      'name': name,
      'duration': duration,
    };
  }

  // Construct Lecture from Map
  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      id: map['id'],
      sectionId: map['sectionId'],
      name: map['name'],
      duration: map['duration'],
    );
  }
}
