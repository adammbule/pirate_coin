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
        '/home':(context) => const HomeScreen(),
        'third':(context) => TrendingMovieScreen(),
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
      backgroundColor: Colors.blueGrey,
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
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Login'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),),
        ),
          
          ElevatedButton(onPressed: (){
            Navigator.pushNamed (context, '/third');
          },
          child: const Text('Register'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),),
        )]),
          
          
          
        );
      
       
      
    
  }
}


class CreateScreen extends StatelessWidget {
  //const secondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),),
        ),
            
            Text('Already a member?'),
            ElevatedButton(                         
              onPressed: (){
                Navigator.pushNamed(context, '/second');
            }, 
            child: Text('Login'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),),
        )],
        ),
      ),
    );
  }
}




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    const title = 'HOME';

    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 4 widgets that display their index in the List.
          children: 
                    List.generate(1, (index) {
            return Center(
              child: Text(
                'Movies',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }),),),);
          }
       
    

  }

class TrendingMovieScreen extends StatelessWidget {
  //const MovieScreen({super.key});
  static const title = 'Trending Movies';

  Widget build(context){
    return MaterialApp(
      title: title,
      home: Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(title),
      ),
      body: GridView.count(crossAxisCount: 2,
      children: List.generate(20, (index){
        return Center(
          child: Text('Mad Max: Fury Road',
          style: Theme.of(context).textTheme.headlineSmall,),
          );
      },)
    )),);
    
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

