import 'dart:async';

import 'package:estudesemfronteiras/common_widget/DrawerWidget.dart';
import 'package:estudesemfronteiras/common_widget/utils.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:estudesemfronteiras/cours_detail_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'main.dart';

class Promocaoes extends StatefulWidget {
  @override
  _Promocaoes createState() => _Promocaoes();
}

class _Promocaoes extends State<Promocaoes> {
  static const _itemsLength = 3;

  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();

  late List<MaterialColor> colors = [];
  late List<String> songNames = [];

  late Timer _timer;
  int _start = 10;
  void startTimer() {
    const oneSec = const Duration(seconds:1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  Widget build(context) {
    return _buildAndroid(context);
  }
  @override
  initState(){
    startTimer();
  }
  void _setData() {
    colors = getRandomColors(_itemsLength);
    songNames = getRandomNames(_itemsLength);
  }
  Future<void> _refreshData() {
    return Future.delayed(
      // This is just an arbitrary delay that simulates some network activity.
      const Duration(seconds: 2),
          () => setState(() => _setData()),
    );
  }
  Widget _buildAndroid(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;


    return
      Material(
        type: MaterialType.transparency,
        child:
        Scaffold(
        appBar: AppBar(
          title: const Text("Promocaoes"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async =>
              await _androidRefreshKey.currentState!.show(),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logos/fire.png",
                  width: 80,
                  height: 40,
                ),
                Text('Promoção',
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Termina em",
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0
                    )
                ),
                SizedBox(width: 10,),
                Icon(
                  FontAwesomeIcons.clock,
                  color: Colors.redAccent,
                  size: 20.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                SizedBox(width: 10,),
                Text(
                    "$_start",
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0
                    )
                ),
              ],
            ),
            Container (
              padding: const EdgeInsets.all(16.0),
              width: c_width,
              child: new Column (
                children: <Widget>[
                  new Text ("Super 24 horas de Promoção!!! Todos os preços caíram!!! CORRA: a promoção termina 18h dessa terça-feira !!! ",
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            Flexible(
                  child:Center(
                      child:RefreshIndicator(
                        key: _androidRefreshKey,
                        onRefresh: _refreshData,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          itemCount: _itemsLength,
                          itemBuilder: _listBuilder,
                        ),
                      )
                    )
                  ),
          ],
        )
    ));
  }
  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return Container();

    // Show a slightly different color palette. Show poppy-ier colors on iOS
    // due to lighter contrasting bars and tone it down on Android.

    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: HeroAnimatingCard(
          cours: "coursNames[index]",
          color: Colors.blueAccent,
          heroAnimation: const AlwaysStoppedAnimation(0),
          onPressed: () =>
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) =>
                      CoursDetailTab(
                        id: index,
                        cours: "coursNames[index]",
                        color: Colors.blueAccent,
                      ),
                ),
              ),
        ),
      ),
    );
  }
  void _togglePlatform() {
    TargetPlatform _getOppositePlatform() {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return TargetPlatform.android;
      } else {
        return TargetPlatform.iOS;
      }
    }

    debugDefaultTargetPlatformOverride = _getOppositePlatform();
    // This rebuilds the application. This should obviously never be
    // done in a real app but it's done here since this app
    // unrealistically toggles the current platform for demonstration
    // purposes.
    WidgetsBinding.instance!.reassembleApplication();
  }
}