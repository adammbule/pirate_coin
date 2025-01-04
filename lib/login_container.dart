import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';

  // Controllers for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Don't forget to dispose controllers to prevent memory leaks
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle login
  Future<void> loginUser() async {
    final url = Uri.parse('http://192.168.0.12:4000/login'); // Your backend API endpoint

    final data = {
      'username': _username,
      'password': _password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Successful'),
            content: Text(responseBody['message'] ?? 'Login Successful. Redirecting...'),
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
        // If login is successful, navigate to the home page
        //Navigator.pushReplacementNamed(context, '/home');
      } else {
        // If login fails, show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(responseBody['message'] ?? 'An error occurred'),
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
    } catch (error) {
      // Show an error if the API call fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred: $error'),
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
      //Navigator.pushReplacementNamed(context, '/home');
    }
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
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Your Username',
            ),
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Password',
            ),
            obscureText: true, // Hide the password text
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  // Add your action here (e.g., navigate to password reset screen)
                  print("Forgot password tapped!");
                },
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline, // Mimic hyperlink
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Call the login function to validate the user credentials
              loginUser();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 243, 22, 6)),
            ),
            child: const Text(
              'Login',
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
