import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String _email = '';
  String _password = '';
  String _repeatPassword = '';
  bool _isChecked = false;
  String _username = '';

  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    // Don't forget to dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  // Function to send data to the API
  Future<void> createUser() async {
    // The API endpoint
    final url = Uri.parse('http://192.168.0.12:3000/create-user');

    // Create a map of the data you want to send
    Map<String, dynamic> data = {
      'email': _email,
      'username': _username,
      'password': _password,
         };

    // Convert the data to JSON format
    String jsonData = json.encode(data);

    // Send a POST request
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Check if the request was successful
      if (response.statusCode == 201) {
        // Handle success (e.g., navigate to a new screen)
        print('User created successfully');
        // Example: Navigate to another screen
        // Navigator.pushNamed(context, '/nextScreen');
      } else {
        // Handle error
        print('Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        title: const Text('Member Sign Up'),
        backgroundColor: Color.fromARGB(30, 30 , 30, 30),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Email',
                focusColor: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Username',
                focusColor: Colors.white,
              ),
              keyboardType: TextInputType.text,
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
                labelText: 'Enter Your Password',
              ),
              obscureText: true, // Hide password input
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            TextFormField(
              controller: _repeatPasswordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Repeat Password',
              ),
              obscureText: true, // Hide password input
              onChanged: (value) {
                setState(() {
                  _repeatPassword = value;
                });
              },
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const Text('Accept Our Terms and Conditions.'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // You can now use the variables (_email, _password, etc.) to send the data
                // Example: sendTextToAPI(_email);
                print('Email: $_email');
                print('Username: $_username');
                print('Password: $_password');
                print('Repeat Password: $_repeatPassword');
                print('Terms Accepted: $_isChecked');
                // You can also navigate to another screen after sign-up
                //call function for createuser
                createUser();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text('Sign Up'),
            ),
            const Text('Already a member?'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
