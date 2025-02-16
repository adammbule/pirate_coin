import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _token = ''; // Variable to store the token
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    super.dispose();
  }

  // Function to handle Google login
  Future<void> _googleLogin() async {
    try {
      // Sign out any previous session before trying again
      await _googleSignIn.signOut();

      // Sign in with Google
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        // Get the authentication token from Google
        final GoogleSignInAuthentication googleAuth = await user.authentication;
        final idToken = googleAuth.idToken;
        final accessToken = googleAuth.accessToken;

        // Ensure both tokens are not null
        if (idToken != null) {
          // Send the token to your backend for verification
          final response = await _loginWithGoogle(idToken);

          if (response != null && response['token'] != null) {
            setState(() {
              _token = response['token'];
            });

            // Store the token persistently using shared_preferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', _token);

            // Navigate to the home screen
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _showErrorDialog('Login Failed', 'No token returned from backend.');
          }
        } else {
          _showErrorDialog('Error', 'Google ID Token is null.');
        }
      }
    } catch (error) {
      // Show detailed error message if something goes wrong
      _showErrorDialog('Google Login Error', error.toString());
    }
  }

  // Function to send the Google token to your backend for verification
  Future<Map<String, dynamic>?> _loginWithGoogle(String idToken) async {
    final url = Uri.parse('http://192.168.0.12:4000/users/login/google'); // Your backend API endpoint
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        _showErrorDialog('Login Failed', 'Google login failed. Please try again.');
        return null;
      }
    } catch (e) {
      _showErrorDialog('Network Error', 'Failed to reach the backend.');
      return null;
    }
  }

  // Function to display error dialogs
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: const Color.fromARGB(30, 30, 30, 30),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Google Login Button
          ElevatedButton(
            onPressed: _googleLogin,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 243, 22, 6)),
            ),
            child: const Text(
              'Login with Google',
              style: TextStyle(
                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/third');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 243, 22, 6)),
            ),
            child: const Text(
              'Register',
              style: TextStyle(
                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
