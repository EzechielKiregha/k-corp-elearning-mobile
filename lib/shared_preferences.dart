import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Function to save user data
  Future<void> saveUserData(int userId, String username, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('username', username);
    await prefs.setString('userRole', role);
  }

  // Function to retrieve userId
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  // Function to retrieve username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // Function to retrieve user role
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }

  // Function to clear user data on logout
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('userRole');
  }
}
