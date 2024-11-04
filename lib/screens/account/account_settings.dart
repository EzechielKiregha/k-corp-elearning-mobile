import 'package:flutter/material.dart';

import '../../shared_preferences.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  String userName = "USER";
  String userRole = 'ADMIN';
  int userId = 1;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserPreferences prefs = UserPreferences();
    String? name = await prefs.getUsername();
    String? role = await prefs.getUserRole();
    int? id = await prefs.getUserId();
    setState(() {
      userName = name ?? "User";
      userRole = role ?? "ADMIN";
      userId = id ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
