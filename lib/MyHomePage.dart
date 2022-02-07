import 'package:estudesemfronteiras/common_widget/BottomNavBarWidget.dart';
import 'package:estudesemfronteiras/common_widget/DrawerWidget.dart';
import 'package:estudesemfronteiras/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

class _MyHomePageNewState extends State<MyHomePage> {
  final List<Widget> viewContainer = [];

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Image.asset(
            "assets/logos/header-logo_esf.png",
            width: 80,
            height: 40,
          ),
        ),
        drawer: DrawerWidget(),
        body: IndexedStack(index: currentIndex, children: <Widget>[
          Container(
            child: Text('home page')
          ),
        ]),
        //bottomNavigationBar: BottomNavBarWidget(),
      ),
    );

  }
}

