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

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 29, 37),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Hello  World !!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.5,
              ),
            ),
          ),
          ElevatedButton(
            // Within the `FirstScreen` widget
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            child: const Text('Start'),
          ),
        ]),
      ), //class
    );
  }
}