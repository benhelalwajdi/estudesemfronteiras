import 'dart:async';
import 'dart:convert';
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:http/http.dart' as http;
import 'package:estudesemfronteiras/common_widget/DrawerWidget.dart';
import 'package:estudesemfronteiras/common_widget/utils.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:estudesemfronteiras/cours_detail_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Promocaoes extends StatefulWidget {
  @override
  _Promocaoes createState() => _Promocaoes();
}

class _Promocaoes extends State<Promocaoes> {
 Future<List<Courses>> fetchCourses(id) async {
    var url = 'http://192.168.1.123:8765/courses?page='+id.toString();
    var body;
    var json;
    var parsed;
    final response = await http.get(Uri.parse(url));
    body = response.body;

    json = jsonDecode(body);
    //print(json["courses"].toString());
    parsed = json["courses"].cast<Map<String, dynamic>>();
    print(parsed[0].toString());
    return parsed.map<Courses>((json) => Courses.fromMap(json)).toList();
  }

  late Future<List<Courses>> futureCourses = fetchCourses(1);
  static const _itemsLength = 3;

  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();

  late List<MaterialColor> colors = [];
  late List<String> coursesNames = [];

  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
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
    return _buildView(context);
  }

  @override
  initState() {
    super.initState();
    futureCourses = fetchCourses(1);
    startTimer();
  }

  void _setData() {
    colors = getRandomColors(_itemsLength);
    coursesNames = getRandomNames(_itemsLength);
  }

  Future<void> _refreshData() {
    //futureCourses = fetchCourses(2);
    return Future.delayed(
      // This is just an arbitrary delay that simulates some network activity.
      const Duration(seconds: 2), () => setState(() => _setData()),
    );

  }

  Widget _buildView(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return Material(
        type: MaterialType.transparency,
        child: Scaffold(
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
            body: FutureBuilder<List<Courses>>(
                future: futureCourses,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logos/fire.png",
                              width: 80,
                              height: 40,
                            ),
                            const Text('Promoção',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 36.0)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Termina em",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0)),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.redAccent,
                              size: 20.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("$_start",
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          width: c_width,
                          child: Column(
                            children: <Widget>[
                              Text(
                                  "Super 24 horas de Promoção!!! Todos os preços caíram!!! CORRA: a promoção termina 18h dessa terça-feira !!! ",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        Flexible(
                            child: Center(
                                child: RefreshIndicator(
                          key: _androidRefreshKey,
                          onRefresh: _refreshData,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) =>  SafeArea(
                              top: false,
                              bottom: false,
                              child: Hero(
                                tag: index,
                                child:
                                HeroAnimatingCard(
                                  cours: snapshot.data![index],
                                  color: Colors.blueAccent,
                                  heroAnimation: const AlwaysStoppedAnimation(0),
                                  onPressed: () => Navigator.of(context).push<void>(
                                    MaterialPageRoute(
                                      builder: (context) => CoursDetailTab(
                                        id: index,
                                        cours: snapshot.data![index],
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            )
                        ),
                      ],
                    );
                  }
                  return Container();
                }
                )
        )
    );
  }
}

/*
class _ListViewWidget extends StatelessWidget {
  final List<Courses> _data;
  bool _isLoading;

  _ListViewWidget(this._data, this._isLoading);

  late DataState _dataState;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    print(_data);
    _dataState = Provider.of<ListController>(context, listen: false).dataState;
    _buildContext = context;
    return SafeArea(child: _scrollNotificationWidget());
  }

  Widget _scrollNotificationWidget() {
    return Column(
      children: [
        Expanded(
            child: NotificationListener<ScrollNotification>(
                onNotification: _scrollNotification,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _onRefresh();
                  },
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_data[index].id.toString(),
                                    style: const TextStyle(fontSize: 15)),
                              )));
                    },
                  ),
                ))),
        if (_dataState == DataState.More_Fetching)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _isLoading = true;
      Provider.of<ListController>(_buildContext, listen: false).fetchData();
    }
    return true;
  }

  _onRefresh() async {
    if (!_isLoading) {
      _isLoading = true;
      Provider.of<ListController>(_buildContext, listen: false)
          .fetchData(isRefresh: true);
    }
  }
}
*/
