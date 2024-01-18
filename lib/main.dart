
import 'dart:js';
import 'dart:convert';
import 'package:provider/provider.dart';
//import 'package:http/shujaanet.com/coin.dart' as http;

import 'package:flutter/material.dart';

void main() {
  //defining the function parameters when defining a function
  runApp(
     MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/second': (context) => const LoginScreen(),
        '/third': (context) => CreateScreen(),
        '/home': (context) => const HomeScreen(),
        'third': (context) => const TrendingMovieScreen(),
        'fourth': (context) => const MovieOverviewScreen(),
        '/fifth': (context) => const MyAccountScreen(),
        '/sixth': (context) => const PirateXchangeScreen(),
        '/seven':(context) => const MyWatchlistScreen(),
      },
    ),
  ); //calling the function arguments when calling a function
}

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
//change to statefull widgets
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'HOME';

    return MaterialApp(
      title: title,
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 15, 15, 15),
          appBar: AppBar(
            title: const Text(title),
          ),
          body: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            /*Container(
            child: GestureDetector(
              onTap: () => '/fourth',
            ),
          
          ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const MovieOverviewScreen())));
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset('images/madmax.jpg'),
                  ),
                  Text('Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),)
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SeriesOverviewScreen()));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset('images/hotd.jpg'),
                    ),
                    Text('Series',
                    style: TextStyle(color: Colors.white, fontSize: 25,))
                  ],
                )),
          ])),
    );
  }
}

class TrendingMovieScreen extends StatelessWidget {
  const TrendingMovieScreen({super.key});
  static const title = 'Trending Movies';
  @override
  Widget build(context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            20,
            (index) {
              return Center(
                child: Text(
                  'Mad Max: Fury Road',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//create class fot textbox
class TextboxContainer extends StatelessWidget {
  const TextboxContainer({super.key});
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 19, 20, 20),
          Color.fromARGB(255, 10, 10, 10),
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

//pick custom font for everything
class MovieOverviewScreen extends StatelessWidget {
  const MovieOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Image.asset(//place images in placeholders eventually
            'Images/madmax.jpg',
            height: 300,
            width: 800,
            //fit:BoxFit.fitWidth,
            
          ),
          Text(
            'Mad Max:Fury Road',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/sixth');
              //notifyListeners();
            },
            child: const Text('Play'), //insert clickable icon.
          ),
          Text('Mad Max',
          style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
          Text('Sand, Dystopia, Wild cars, Action!!!', 
          style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
          
          
        ],
      ),
    );
  }
}

class SeriesOverviewScreen extends StatelessWidget {
  const SeriesOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Text(
            'House of The Dragon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/fifth');
            },
            child: const Text('Play'), //insert clickable icon.
          ),
          Image.asset(
            'Images/hotd.jpg',
            height: 452,
            width: 600,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: const Text(
        'My Account',
        style: TextStyle(color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold),
        ),);
  }
}

class MyWatchlistScreen extends StatelessWidget {
 const MyWatchlistScreen ({super.key});
 @override
 Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.black,
  );
 }
}

class PirateXchangeScreen extends StatelessWidget {
  const PirateXchangeScreen ({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 13, 13),
      body: const Column(
        children: [
          Text('PirateXchange',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ), 
       ),
        ],
      ),
    );
  }
}

/*Intro to State
State is whatever tools/data you need to rebuild the UI at any moment in time.
Ephemeral- local state -e.g an index being reset to zero once user restarts application.-setState()
App State- State that you want shared between user sessions- login, shopping cart, notifications, user preferences, unread sms
Keep the state above the widgets that use it.
To change the UI, you have to rebuild it
Do not fight the framework
Everything is a widget in Flutter
Provider-ChangeNotifier, ChangeNotifierProvider & Consumer
ChangeNotifier --> You need to call the notifyListeners() anytime the UI changes.
ChangeNotifierProvider provides an instance of changeNotifier to its descendants. Place above the widgets that access it.
*/