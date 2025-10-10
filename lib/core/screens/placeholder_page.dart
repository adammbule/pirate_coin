import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: HamburgerMenu(),
      body: const Center(
        child: Text(
          'This Screen is coming soon!',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}
