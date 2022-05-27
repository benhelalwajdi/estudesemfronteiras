import 'dart:async';
import 'dart:convert';

import 'package:estudesemfronteiras/Entity/category.dart';
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
                              itemBuilder: (_, index) => cardElements(snapshot.data, index)),
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

    try {
    _category = [];
    double cWidth = MediaQuery.of(context).size.width;
    double cHeight = MediaQuery.of(context).size.height;
    var cr = Courses.fromMap(cours![index].course);

    //var category = Category.fromMap(cr.category);
    if(cr.photo == null){
      return Container();
    }else{
        print(cr.category["name"].toString());
        return GFCard(
          image: image(cr.course_id, cr.photo),
          showImage: true,
          boxFit: BoxFit.cover,
          titlePosition: GFPosition.end,
          title: GFListTile(
            titleText: cr.name,
          ),
          content: Row(
            children: [
              cr.category == null ? Container() : GFBadge(
          size: 50, child:   Text( cr.category["name"].toString()),textStyle: TextStyle(fontSize: 10),),
              GFButtonBadge(
                onPressed: () {},
                color: Colors.blueGrey,
                text: "cff",
              ),
            ],
          ),
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
        );
      }
      }catch(e){
      return Container();
    }
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
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset('assets/images/imgCours.png',
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          fit:BoxFit.cover);
    }
  }
}
