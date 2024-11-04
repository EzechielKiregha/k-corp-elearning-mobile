import 'package:k_corp_elearning/model/lecture.dart';
import 'package:k_corp_elearning/model/section.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:k_corp_elearning/model/course_db.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'kc_app.db');
    return await openDatabase(
      path,
      version: 1,
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE courses (
              id TEXT PRIMARY KEY,
              title TEXT,
              thumbnailUrl TEXT,
              description TEXT,
              createdBy TEXT,
              createdDate TEXT,
              rate REAL,
              isFavorite BOOLEAN,
              price REAL,
              courseCategory TEXT,
              duration TEXT,
              lessonNo INTEGER
            )
          ''');
                  db.execute('''
            CREATE TABLE sections (
              id TEXT PRIMARY KEY,
              courseId TEXT,
              name TEXT,
              FOREIGN KEY(courseId) REFERENCES courses(id) ON DELETE CASCADE
            )
          ''');
                  db.execute('''
            CREATE TABLE lectures (
              id TEXT PRIMARY KEY ,
              sectionId TEXT,
              name TEXT,
              duration TEXT,
              FOREIGN KEY(sectionId) REFERENCES sections(id) ON DELETE CASCADE
            )
          ''');

        db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT,
            role TEXT
          )
        ''');
      },
    );
  }

  // Insert a user into the database
  Future<bool> insertUser(String username, String password, String role) async {
    final db = await database;
    try {
      await db.insert(
        'users',
        {'username': username, 'password': password, 'role': role},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true; // Return true on successful insert
    } catch (e) {
      return false; // Return false on failure
    }
  }

   // Function to fetch the username
  Future<String?> getUsername(int userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['username'],
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first['username'] as String;
    }
    return null;
  }

  // Function to fetch the user id
  Future<int> getUserId(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['id'],
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }
    return 0;
  }

  // Function to fetch the user role
  Future<String> getUserRole(int userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['role'],
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first['role'] as String;
    }
    return "null";
  }

  // Validate user login
  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    var dbClient = await database;
    var res = await dbClient.query(
      "users",
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // CRUD Method for inserting a Course
  Future<String> insertCourse(Course course) async {
    final db = await database;
    await db.insert('courses', course.toMap());
    return course.id; // Return the id of the inserted course
  }

  Future<void> updateCourse(Course course) async {
    final db = await database;
    await db.update(
      'courses',
      course.toMap(),
      where: "id = ?",
      whereArgs: [course.id],
    );
  }
  Future<void> deleteCourse(String id) async {
    final db = await database;
    await db.delete(
      'courses',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // CRUD Method for inserting a Section
  Future<String> insertSection(Section section) async {
    final db = await _initDatabase();
    await db.insert('sections', section.toMap());
    return section.id; // Return the id of the inserted section
  }

  // CRUD Method for inserting a Lecture
  Future<String> insertLecture(Lecture lecture) async {
    final db = await _initDatabase();
    await db.insert('lectures', lecture.toMap());
    return lecture.id; // Return the id of the inserted lecture
  }


  Future<Section> getSectionWithLectures(String sectionId) async {
    final db = await database;

    // Retrieve the section
    final sectionMap = await db.query(
      'sections',
      where: 'id = ?',
      whereArgs: [sectionId],
    );

    // Retrieve the lectures for that section
    final lecturesMapList = await db.query(
      'lectures',
      where: 'sectionId = ?',
      whereArgs: [sectionId],
    );

    // Convert each lecture map to a Lecture instance
    List<Lecture> lectures = lecturesMapList.map((map) => Lecture.fromMap(map)).toList();

    // Create and return the Section with its lectures
    return Section.fromMap(sectionMap.first, lectures);
  }

  Future<List<Course>> getCourses() async {
    final db = await database;

    // Step 1: Get all courses
    final List<Map<String, dynamic>> courseMaps = await db.query('courses');

    // Step 2: Create a list of Course objects
    List<Course> courses = [];

    for (var courseMap in courseMaps) {
      final courseId = courseMap['id'];

      // Step 3: Get sections for each course
      final List<Map<String, dynamic>> sectionMaps = await db.query(
        'sections',
        where: 'courseId = ?',
        whereArgs: [courseId],
      );

      // Create a list to hold sections with lectures
      List<Section> sections = [];

      for (var sectionMap in sectionMaps) {
        final sectionId = sectionMap['id'];

        // Step 4: Get lectures for each section
        final List<Map<String, dynamic>> lectureMaps = await db.query(
          'lectures',
          where: 'sectionId = ?',
          whereArgs: [sectionId],
        );

        // Map lectures for this section
        List<Lecture> lectures = lectureMaps.map((lectureMap) => Lecture.fromMap(lectureMap)).toList();

        // Create the section with its lectures and add to sections list
        sections.add(Section.fromMap(sectionMap, lectures));
      }

      // Step 5: Create the course with its sections
      Course course = Course.fromMap(courseMap);
      course.sections = sections;

      // Add the fully populated course to the list
      courses.add(course);
    }

    return courses;
  }


}

