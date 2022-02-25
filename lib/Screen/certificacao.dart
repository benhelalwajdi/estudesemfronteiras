import 'package:estudesemfronteiras/common_widget/drawerWidget.dart';
import 'package:estudesemfronteiras/Screen/main.dart';
import 'package:flutter/material.dart';

class Certificacao extends StatefulWidget{
  @override
  _Certificacao createState()=> _Certificacao();
}

class _Certificacao extends State<Certificacao>{
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