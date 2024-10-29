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
            isFavorite INTEGER,
            price REAL,
            courseCategory TEXT,
            duration TEXT,
            lessonNo INTEGER
          )
        ''');
        db.execute('''
          CREATE TABLE sections (
            courseId TEXT,
            name TEXT,
            FOREIGN KEY(courseId) REFERENCES courses(id)
          )
        ''');
        db.execute('''
          CREATE TABLE lectures (
            sectionId TEXT,
            name TEXT,
            duration TEXT,
            FOREIGN KEY(sectionId) REFERENCES sections(name)
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
  Future<String> getUsername(int userId) async {
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
    return 'No User';
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

  // CRUD Methods for Courses
  Future<void> insertCourse(Course course) async {
    final db = await database;
    await db.insert('courses', course.toMap());
  }

  Future<List<Course>> getCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('courses');
    return List.generate(maps.length, (i) {
      return Course.fromMap(maps[i]);
    });
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
}

