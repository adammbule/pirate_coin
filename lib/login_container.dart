import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _password = '';
  String _username = '';

  // Controllers for text fields

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    // Don't forget to dispose controllers to prevent memory leaks
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: const Color.fromARGB(30, 30, 30, 30),

      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Your Username'),
            onChanged: (value) {
              setState(() {
                _username = value;
              });}
        ),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your Password',
          ),
      onChanged: (value) {
      setState(() {
      _password = value;
      });}
        ),
        Column(
          children: [
            InkWell(
              onTap: () {
                // Add your action here (e.g., navigate to another screen)
                print("Forgot password tapped!");
              },
              child: Text(
                'Forgot your password?',
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                  decoration: TextDecoration.underline, // Underline to mimic a hyperlink
                ),
              ),
            ),
          ],
              ),
        ElevatedButton(
          onPressed: () {

            print('username: $_username');
            print('password: $_password');
            //sendTextToAPI(_usernameController.text);
            Navigator.pushNamed(context, '/home');
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
                const Color.fromARGB(255, 243, 22, 6)),
          ),
          child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight:FontWeight.bold, )),
        ),
        ElevatedButton(
          onPressed: () {

            Navigator.pushNamed(context, '/third');
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
                const Color.fromARGB(255, 243, 22, 6)),
          ),
          child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }
}
