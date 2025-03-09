import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocdef.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _token = ''; // Variable to store the token
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String backgroundImage = 'https://image.tmdb.org/t/p/original/efz0MgPAxPw11PIeAJNgKKg3Paa.jpg'; // Change to your image URL

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

  Future<Map<String, dynamic>?> _loginWithGoogle(String idToken) async {
    final url = Uri.parse('${baseurlfinal}/users/login/google'); // Your backend API endpoint
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Assuming the response contains the session key (token)
        String sessionKey = responseData['sessionKey'];

        // Store the session key in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionKey', sessionKey); // Save the session key

        // Return the response data (you can include the session key if needed)
        return responseData;
      } else {
        _showErrorDialog('Login Failed', 'Google login failed. Please try again.');
        return null;
      }
    } catch (e) {
      _showErrorDialog('Network Error', 'Failed to reach the backend.');
      return null;
    }
  }

// Function to retrieve the session key for subsequent API calls
  Future<String?> getSessionKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('sessionKey'); // Retrieve the session key
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
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay to darken the background
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Login Form Centered on the Screen
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Title or Logo (optional)
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Google Login Button
                  ElevatedButton(
                    onPressed: _googleLogin,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 11, 129, 191)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
                    ),
                    child: const Text(
                      'Login with Google',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Register Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/third');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 11, 129, 191)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
