import 'dart:js';

import 'package:flutter/material.dart';

void main() {
  //defining the function parameters when defining a function
  runApp(
    MaterialApp(
      initialRoute:'/',
      routes:{     
         '/':(context) => StartScreen(),
        '/second':(context) =>  LoginScreen(),
        '/third':(context) => CreateScreen(),
      },
      ),
  ); //calling the function arguments when calling a function
}

class StartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 29, 37),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
          'Hello  World !!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.5,
                  ),),
        ),
              ElevatedButton(
          // Within the `FirstScreen` widget
            onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.push(context,
      MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
          child: const Text('Start'),
        
      ),
    ]),
    ), //class
  );
  }
}

class LoginScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (
        title: const Text('SignUP'),
      ),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ const TextField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter Your Email/Username'
        ),
      ),
        TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter your Password',
            ),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Login'),
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed (context, '/third');
          },
          child: const Text('Register')),
          
          ]
        ),
      );
       
      
    
  }
}


class CreateScreen extends StatelessWidget {
  //const secondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Login'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Email',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Password',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Repeat Password',
              ),
            ),
            ElevatedButton(
              // Within the SecondScreen widget
              onPressed: () {
                // Navigate back to the first screen by popping the current route
                // off the stack.
                
                     },
              child: const Text('Sign Up'),
            ),
            Text('Already a member?'),
            ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/second');
            }, child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}

//create class fot textbox
class TextboxContainer extends StatelessWidget {
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 31, 70, 109),
          Color.fromARGB(255, 14, 30, 83),
        ]),
      ),
      child: const Center(
        child: Text(
          'Hello  World !!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.5,
                  ),
        ),
      ),
    );
  } //build should return a widget

  //class fot the member validation screen
} 
