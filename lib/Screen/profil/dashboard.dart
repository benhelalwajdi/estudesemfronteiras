import 'dart:async';
import 'dart:convert';
import 'package:estudesemfronteiras/Entity/purchase.dart';
import 'package:http/http.dart' as http;
import 'package:estudesemfronteiras/common_widget/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_widget/drawer_dash_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with SingleTickerProviderStateMixin {
  final TextEditingController _searchTextEditingController = TextEditingController();
  refreshState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  Future<List<Purchase>> fetchCourses(id) async {
    var url = 'http://192.168.1.123:8765/courses/myCourses/14115';
    SharedPreferences _pref =await SharedPreferences.getInstance();
    var token = _pref.get('token');
    final response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = response.body;
    var json = jsonDecode(body);
    var parsed = json["courses"].cast<Map<String, dynamic>>();
    print(json["courses"].toString());
    print(parsed.map<Purchase>((json) => Purchase.fromMap(json)).toList());
    return parsed.map<Purchase>((json) => Purchase.fromMap(json)).toList();
  }

  late Future<List<Purchase>> futureCourses = fetchCourses(1);
  static const _itemsLength = 3;
  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();
  late List<MaterialColor> colors = [];
  late List<String> coursesNames = [];

  @override
  Widget build(context) {
    return _buildView(context);
  }

  @override
  initState() {
    super.initState();
    _searchTextEditingController.addListener(() => refreshState(() {}));
    futureCourses = fetchCourses(1);
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

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
  }

  Widget _buildView(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Meu cursos"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async =>
                      await _androidRefreshKey.currentState!.show(),
                ),
              ],
            ),
            drawer: const DrawerDashWidget(),
            body: FutureBuilder<List<Purchase>>(
                future: futureCourses,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            child: Center(
                                child: RefreshIndicator(
                          key: _androidRefreshKey,
                          onRefresh: _refreshData,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) =>
                            cardElements(snapshot.data,index),
                          ),
                        ))),
                      ],
                    );
                  }
                  return Container();
                })));
  }

  Widget cardElements(List<Purchase>? cours, int index){
   // _addTags('cours![index].id.toString()', 'cours[index].name');
    return SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                ListTile(
                  //leading: imgWid(cours![index]),
                  title: Text("test"),
                ),
                /*Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _category.length > 0
                              ? Column(children: [
                            Wrap(
                              alignment:
                              WrapAlignment.start,
                              children: _category
                                  .map(
                                      (tagModel) =>
                                      tagChip(
                                        tagModel:
                                        tagModel,
                                        action:
                                        'Remove',
                                      ))
                                  .toSet()
                                  .toList(),
                            ),
                          ])
                              : Container(),
                          //_buildSearchFieldWidget(),
                          //_displayTagWidget(),
                        ],
                      ),
                    ),
                    TextButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('LISTEN'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),*/
              ],
            ),
          ),
        ));
  }
/*
  Widget tagChip({tagModel,action,}) {
    return InkWell(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Text(
                  '${tagModel.title}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ));
  }*/
}


