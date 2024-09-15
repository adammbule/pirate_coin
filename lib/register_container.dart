import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  //const CreateScreen({super.key});

  final bool _isChecked = false;

  const CreateScreen({super.key});
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
              //controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Email',
                focusColor: Colors.white,
              ),
            ),
            TextFormField(
              //controller: _FirstPasswordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Password',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                //controller: _secoundPasswordController,
                border: UnderlineInputBorder(),
                labelText: 'Repeat Password',
              ),
            ),
            Row(
              children: [
                Checkbox(value: _isChecked, onChanged: (bool? value) {}),
                const Text('Accept Our Terms and Conditions.'),
              ],
            ),
            ElevatedButton(
              // Within the SecondScreen widget
              onPressed: () {
                //sendTextToAPI(_emailController.Text);
                // Navigate back to the first screen by popping the current route
                // off the stack.
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
            )
          ],
        ),
      ),
    );
    
  }
}
