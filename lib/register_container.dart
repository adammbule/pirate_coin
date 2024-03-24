import 'dart:io';
import 'dart:js';
import 'dart:convert';
import 'dart:js_interop_unsafe';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  //const CreateScreen({super.key});

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 129, 129, 129),
      appBar: AppBar(
        title: const Text('Member Sign Up'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              //controller: _emailController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Email',
                focusColor: Colors.white,
              ),
            ),
            TextFormField(
              //controller: _FirstPasswordController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Password',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                //controller: _secoundPasswordController,
                border: UnderlineInputBorder(),
                labelText: 'Repeat Password',
              ),
            ),
            Row(
              children: [
                Checkbox(value: _isChecked, onChanged: (bool? value) {}),
                Text('Accept Our Terms and Conditions.'),
              ],
            ),
            ElevatedButton(
              // Within the SecondScreen widget
              onPressed: () {
                //sendTextToAPI(_emailController.Text);
                // Navigate back to the first screen by popping the current route
                // off the stack.
              },
              child: const Text('Sign Up'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
            Text('Already a member?'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            )
          ],
        ),
      ),
    );
    
  }
}
