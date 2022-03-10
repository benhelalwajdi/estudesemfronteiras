import 'package:estudesemfronteiras/Screen/about.dart';
import 'package:estudesemfronteiras/Screen/my_home_page.dart';
import 'package:estudesemfronteiras/Screen/profil/dashboard.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'package:dart_ping/dart_ping.dart';

void main() async {
// Create ping object with desired args
  final ping = Ping('http://192.168.1.123:8765', count: 5);
  // Begin ping process and listen for output
  try{
    ping.stream.listen((event) {
      print('Running command: ${ping.command}');
    });
  }catch(e){
    print(e);
  }
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {

const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const MyHomePage(),
        '/about': (context) => About(),
        '/extensao' : (context) => About(),
        '/posGraduacao' : (context) => About(),
        '/certificacao' : (context) => About(),
        '/duvidas': (context) => About(),
        '/promocaoes' : (context) => About(),
        '/login' : (context)=> const LoginPage(),
        '/signup': (context)=> const SignPage(),
        '/dashboard': (context)=> Dashboard(),
      },
      home:const MyHomePage(),
      theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}
int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}
