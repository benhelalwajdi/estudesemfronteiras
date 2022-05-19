import 'dart:async';
import 'dart:convert';

import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/Entity/purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import 'common_widget/drawer_dash_widget.dart';

//http://192.168.1.123:8765/courses/myCourses/14115?sort=id&direction=desc&limit=1
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with SingleTickerProviderStateMixin {
  var _category = [];
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  refreshState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  late Future<List<Purchase>> futureCourses;

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
    futureCourses = fetchCourses(1);
  }

  @override
  void didChangeDependencies() {
    futureCourses = fetchCourses(1);
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
    setState(() {
      futureCourses = fetchCourses(1);
    });
    return Material(
        type: MaterialType.transparency,
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Meu Cursos')),
            actions: [
              IconButton(
                  onPressed: () async {
                    _refreshData();
                  },
                  icon: const Icon(Icons.refresh))
            ],
          ),
          drawer: const DrawerDashWidget(),
          body: FutureBuilder<List<Purchase>>(
            future: futureCourses,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RefreshIndicator(
                        key: _androidRefreshKey,
                        onRefresh: _refreshData,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.88,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) =>
                                  cardElements(snapshot.data, index)),
                        ),
                      ),
                    ]);
              }
              return Container();
            },
          ),
        ));
  }

  Widget cardElements(List<Purchase>? cours, int index) {
    _category = [];
    double cWidth = MediaQuery.of(context).size.width;
    double cHeight = MediaQuery.of(context).size.height;
    var cr = Courses.fromMap(cours![index].course);

    return /*GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      image: Image.asset(
        'lib/assets/cup.jpg',
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      showImage: true,
      title: const GFListTile(
        avatar: GFAvatar(
          backgroundImage: AssetImage('your asset image'),
        ),
        titleText: 'Game Controllers',
        subTitleText: 'PlayStation 4',
      ),
      content: Text(),
      buttonBar: const GFButtonBar(
        children: <Widget>[
          GFAvatar(
            backgroundColor: GFColors.PRIMARY,
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
          GFAvatar(
            backgroundColor: GFColors.SECONDARY,
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          GFAvatar(
            backgroundColor: GFColors.SUCCESS,
            child: Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ); */

      SizedBox(
      width: 500,
      height: cHeight * 0.27,
      child: SafeArea(
        top: false,
        bottom: false,
        right: false,
        left: false,
        child: Center(
          child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image(cr.course_id, cr.photo),
                      ]),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: new Column(
                      children:<Widget> [
                        new Text (cr.name, textAlign: TextAlign.left),
                       ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
    //var parsed = cr.category.cast<Map<String, dynamic>>();
    //var cat = Category.fromMap(parsed);
    //print(cat.title.toString());
    // _category.add(cat);
    //for(int i=0; i)
    //_addTags('cours![index].id.toString()', 'cours[index].name');
/*
    return SizedBox(
        width: cWidth,
        height: cHeight * 0.27,
        child: SafeArea(
            top: false,
            bottom: false,
            right: false,
            left: false,
            child: Center(
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 100,
                            width: 100,
                            image: NetworkImage(
                                'https://www.estudesemfronteiras.com/novo/img/upload/${cr.course_id}/${cr.photo}'),
                          ),
                        ]),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: cWidth * 0.5,
                          height: cHeight * 0.2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: cWidth * 0.5, // Some height
                                    child: Column(
                                      children: [
                                        Text(cr.name),
                                      ],
                                    )),
                              ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _category.isNotEmpty
                                ? Column(children: [
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      children: _category
                                          .map((tagModel) => tagChip(
                                                tagModel: tagModel,
                                                action: 'Remove',
                                              ))
                                          .toSet()
                                          .toList(),
                                    ),
                                  ])
                                : Container(),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                child: const Text('BUY TICKETS'),
                                onPressed: () {
                                  /* ... */
                                },
                  ),

                            ]),
                      ],
                    ),
                  ],
                ),
              ),
            )));*/
  }

  Widget tagChip({
    tagModel,
    action,
  }) {
    return InkWell(
        child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 5.0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Text(
              '${tagModel.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.0,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future<List<Purchase>> fetchCourses(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.get('token');
    var id = _pref.get('id');
    var url = 'http://192.168.1.123:8765/courses/myCourses/' +
        id.toString() +
        '?sort=id&direction=desc';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      _pref.remove('token');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              const LoginPage()));
    }
    var body = response.body;
    var json = jsonDecode(body);
    var parsed = json["courses"].cast<Map<String, dynamic>>();
    //print(parsed);
    var mapParsed =
        parsed.map<Purchase>((json) => Purchase.fromMap(json)).toList();
    //print(mapParsed);
    // print(json["courses"].toString());
    // print(parsed.map<Purchase>((json) => Purchase.fromMap(json)).toList());
    return parsed.map<Purchase>((json) => Purchase.fromMap(json)).toList();
  }

  image(id, photo) {
    if (photo != null) {
      //launch(url);
      return Image.network(
        'https://www.estudesemfronteiras.com/novo/img/upload/${id}/${photo}',
        width: 100,
        height: 100,
        fit: BoxFit.fitWidth,
      );
    } else {
      return Image.asset('assets/images/imgCours.png',width: 100,height: 100,fit:BoxFit.fitWidth);
    }
  }
}
