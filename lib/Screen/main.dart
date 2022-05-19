import 'package:estudesemfronteiras/Screen/about.dart';
import 'package:estudesemfronteiras/Screen/my_home_page.dart';
import 'package:estudesemfronteiras/Screen/profil/dashboard.dart';
import 'package:estudesemfronteiras/Screen/splash_screen.dart';
import 'package:estudesemfronteiras/Screen/verify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'package:dart_ping/dart_ping.dart';

void main() async {
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
        '/dashboard': (context)=>  const Dashboard(),
        '/verify': (context)=> const VerifyPage()
      },
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        return widget!;
      },
      home: SplashScreen(),
      theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}


class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/images/error_illustration.png'),
            Text(
              kDebugMode
                  ? 'Ops! Algo deu errado!'
                  : 'Ops! Algo deu errado!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: kDebugMode ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            const SizedBox(height: 12),
            const Text(
              kDebugMode
                  ? 'https://www.estudesemfronteiras.com'
                  : "Encontramos um erro e notificamos nossa equipe de engenharia sobre isso. Desculpe pela inconveniência causada.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}
