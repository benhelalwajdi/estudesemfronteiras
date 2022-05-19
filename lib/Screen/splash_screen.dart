import 'dart:async';
import 'dart:convert';
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/Service/const.dart';
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

  @override
  void initState() {
    super.initState();
    fetchCourses(1);
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
    var url = 'http://192.168.1.123:8765/courses?page=' + id.toString()+'&limit=10';
    String body;
    var json;
    var parsed;
    try {
      await http.get(Uri.parse(url)).then((value) {
        print(value.statusCode);
        json = jsonDecode(value.body.toString());
        parsed = json["courses"].cast<Map<String, dynamic>>();
        Const.futureCourses = parsed.
        map<Courses>((json) => Courses.fromMap(json)).
        toList();
        print(Const.futureCourses.first.id.toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePage()));
      });
    }catch(e){
      print('taw haka taw :$e');
      show_Dialog(
          context,
          'erro de conexão',
          'você tem erro de acesso à internet',
          'Sim',
          'splash' );

    }
  }
}
