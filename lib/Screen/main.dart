import 'package:estudesemfronteiras/Screen/about.dart';
import 'package:estudesemfronteiras/Screen/my_home_page.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';


void main() => runApp(const MyApp(
));
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