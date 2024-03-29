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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      appBar: AppBar(
        title: const Text('SignUP'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const TextField(
          //controller: _usernameController,
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Your Email/Username'),
        ),
        TextFormField(
          //controller: _passwordController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your Password',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            //sendTextToAPI(_usernameController.text);
            Navigator.pushNamed(context, '/home');
          },
          child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight:FontWeight.bold, )),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Color.fromARGB(255, 243, 22, 6)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            
            Navigator.pushNamed(context, '/third');
          },
          child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 243, 22, 6)),
          ),
        )
      ]),
    );
  }
}
