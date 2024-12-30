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

  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    // Don't forget to dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 129, 129, 129),
      appBar: AppBar(
        title: const Text('Member Sign Up'),
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
                print('Password: $_password');
                print('Repeat Password: $_repeatPassword');
                print('Terms Accepted: $_isChecked');
                // You can also navigate to another screen after sign-up
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
