import 'package:flutter/material.dart';

void main() {
  //defining the function parameters when defining a function
  runApp(
     MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 29, 37),
        body: Container(
          //decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 238, 239, 240)])),
           child: const Center(
            child: Text('Hello  World !!', style: TextStyle(
              color: Colors.white,
              fontSize: 28.5,),
          ),
           ),
        ),
      ),
    ), //class
  ); //calling the function arguments when calling a function
}

//Remove comments and run
//const is used to optimize runtime of the application. --best practise
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