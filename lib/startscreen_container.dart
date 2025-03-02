import 'package:flutter/material.dart';
import 'package:Piratecoin/login_container.dart';


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
              'PIRATECOIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.5,
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
                    builder: (context) => const LoginScreen(),
                  ));
            },
            child: const Text('Start'),
          ),
        ]),
      ), //class
    );
  }
}