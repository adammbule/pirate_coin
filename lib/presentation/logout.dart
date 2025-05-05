import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logoutUser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('sessionKey'); // Clear session token

  // Navigate to login screen and clear backstack
  Navigator.pushNamedAndRemoveUntil(context, '/second', (route) => false);
}
