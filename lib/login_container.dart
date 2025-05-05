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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _token = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String backgroundImage =
      'https://image.tmdb.org/t/p/original/efz0MgPAxPw11PIeAJNgKKg3Paa.jpg';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _googleLogin() async {
    try {
      await _googleSignIn.signOut();
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        final googleAuth = await user.authentication;
        final idToken = googleAuth.idToken;

        if (idToken != null) {
          final response = await _loginWithGoogle(idToken);
          if (response != null && response['token'] != null) {
            _saveTokenAndNavigate(response['token']);
          } else {
            _showErrorDialog('Login Failed', 'No token returned from backend.');
          }
        } else {
          _showErrorDialog('Error', 'Google ID Token is null.');
        }
      }
    } catch (error) {
      _showErrorDialog('Google Login Error', error.toString());
    }
  }

  Future<void> _manualLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Missing Fields', 'Please enter both email and password.');
      return;
    }

    final url = Uri.parse('${baseurlfinal}/users/login'); // Update if different
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
await SharedPreferences.getInstance()
    .then((prefs) => prefs.setString('sessionKey', data['sessionKey']));
await _saveTokenAndNavigate(data['sessionKey']); // ✅ Navigate to home

      } else {
        _showErrorDialog('Login Failed', 'Invalid email or password.');
      }
    } catch (e) {
      _showErrorDialog('Network Error', 'Could not reach backend.');
    }
  }

  Future<Map<String, dynamic>?> _loginWithGoogle(String idToken) async {
    final url = Uri.parse('${baseurlfinal}/users/login/google');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await SharedPreferences.getInstance()
            .then((prefs) => prefs.setString('sessionKey', data['sessionKey']));
        return data;
      } else {
        _showErrorDialog('Login Failed', 'Google login failed. Try again.');
        return null;
      }
    } catch (e) {
      _showErrorDialog('Network Error', 'Failed to reach backend.');
      return null;
    }
  }

  Future<void> logoutUser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('sessionKey'); // Clear session token

  // Navigate to login screen and clear backstack
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
}

  Future<void> _saveTokenAndNavigate(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionKey', token);
    setState(() {
      _token = token;
    });
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(backgroundImage, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _manualLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _googleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Login with Google',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/third');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
