import 'dart:async';
import 'dart:convert';
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:flutter/material.dart';
import 'my_home_page.dart';
import 'package:http/http.dart' as http;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

/*
  late Future<List<Courses>> futureCourses = fetchCourses(1);*/

  @override
  void initState()  {
    super.initState();
    fetchCourses(3);
    /*var url = 'http://192.168.1.123:8765/courses?page=1' ;
    await http.get(Uri.parse(url)).timeout(const Duration(seconds: 2)).then((value){
      print('value status '+value.statusCode.toString());
      */
      /*
      Timer(
          const Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const MyHomePage())));*/
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logos/logotipo_faculdade_metropolitana.png'),
      ),
    );
  }

  Future fetchCourses(id) async {
    print('test');
    var url = 'http://192.168.1.123:8765/courses?page=' + id.toString();
    String body;
    var json;
    var parsed;
    //try {
    await http.get(Uri.parse(url)).timeout(Duration(seconds: 1)).then((value){
      print(value.statusCode);
      print(value.body.toString());
     // print(Stream.value(value).toString());
    });
    /*print('value status ' + response.statusCode.toString());
    body = response.body;
    json = jsonDecode(body);
    parsed = json["courses"].cast<Map<String, dynamic>>();
    print(json);
    return parsed.map<Courses>((json) => Courses.fromMap(json)).toList();
    *//*}catch(e){
      show_Dialog(context, 'erro de conexão', 'você tem erro de acesso à internet', 'Sim', 'splash' );
    }*/
    //return parsed.map<Courses>((json) => Courses.fromMap(json)).toList();
  }
}