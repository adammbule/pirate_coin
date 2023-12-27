import 'package:flutter/material.dart';

void main() {
  //defining the function parameters when defining a function
  runApp(
    MaterialApp(
      initialRoute:'/',
      routes:{        
        '/second':(context) =>  StartScreen(),
        '/third':(context) => LoginScreen(),
      },

      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 29, 37),
        body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            
          },
          child: const Text('Start'),
        
      ),
    ), //class
  ),),); //calling the function arguments when calling a function
}

class StartScreen extends StatelessWidget{

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
          border: OutlineInputBorder(),
          hintText: 'Enter Your Email/Username'
        ),
      ),
        TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter your Password',
            ),
          ),]
        ),
      );
       
      
    
  }
}


class LoginScreen extends StatelessWidget {
  //const secondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Validation'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: const Text('LOGIN'),
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

//Remove comments and run
//const is used to optimize runtime of the application. --best practise
//Class/o bject Instaciation
//position argument
/*void main(){
   // int multi(a, b){
    //return a * b;
}*/
//int result = multi(5, 7);
//print (result);
//}

//widgets are just objects--> core data structure in flutter

//named argument

/*void main(){
    //int multi2({a, b}){
     //   return a * b;
    //}
  //int result = multi2(a:5, b:5);
   // print (result);
}*/