import 'package:estudesemfronteiras/common_widget/drawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class About extends StatefulWidget{
  @override
  _About createState()=> _About();
}

class _About extends State<About>{
  final List<Widget> viewContainer = [
  ];
  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    return  WillPopScope(
      onWillPop: () async => false,
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
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        //bottomNavigationBar: BottomNavBarWidget(),
      ),

    );
  }
}