import 'package:estudesemfronteiras/about.dart';
import 'package:estudesemfronteiras/common_widget/AppBarWidget.dart';
import 'package:estudesemfronteiras/common_widget/BottomNavBarWidget.dart';
import 'package:estudesemfronteiras/common_widget/DrawerWidget.dart';
import 'package:estudesemfronteiras/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() => runApp(MyApp(
));
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => MyHomePage(),
        '/about': (context) => About(),
        '/extensao' : (context) => About(),
        '/posGraduacao' : (context) => About(),
        '/certificacao' : (context) => About(),
        '/duvidas': (context) => About(),
        '/promocaoes' : (context) => About(),
      },
      home: MyHomePage(),
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