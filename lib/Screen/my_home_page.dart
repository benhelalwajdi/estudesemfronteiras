import 'dart:async';
import 'dart:convert';
import 'package:estudesemfronteiras/Screen/promocaoes.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:estudesemfronteiras/common_widget/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;
import '../Entity/courses.dart';
import '../common_widget/widgets.dart';
import 'cours_detail_tab.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

class _MyHomePageNewState extends State<MyHomePage> {
  late Future<List<Courses>> futureCourses = fetchCourses(1);
  final List<Widget> viewContainer = [];
  final int _start = 10;

  @override
  void initState() {
    super.initState();
    futureCourses = fetchCourses(3);
    startTimer();
  }



  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
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
            actions: [
              GestureDetector(
                    onTap: () {
                      print("click on profile icon ");
                      Navigator.pushNamed(
                          context,
                          '/login'
                      );
                    },
                    child: const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                      size: 20.0,
                      semanticLabel: 'profil',
                    ),
                  ),
                ],
          ),
          drawer: DrawerWidget(),
          body: FutureBuilder<List<Courses>>(
              future: futureCourses,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(children: <Widget>[
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 310),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: ShaderMask(
                                    child: Image.network(
                                        'https://www.estudesemfronteiras.com/novo/img/Fl6hiFj.jpg'),
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Colors.transparent
                                        ],
                                        stops: [
                                          0.10,
                                          0.5,
                                        ],
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.srcATop,
                                  )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                    ' Cursos Online de Extensão,\n Aperfeiçoamento e Pós-Graduação com',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0)),
                                Text(' Certificado MEC',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0)),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                    '  A Faculdade Metropolitana é Nota Máxima no MEC - Conceito Institucional 5',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9.0)),
                              ],
                            ),
                          ]),
                          rowStatic(),
                          const SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('Categorias de Cursos'),
                              Divider(
                                height: 20,
                                thickness: 2,
                                indent: 120,
                                endIndent: 120,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              height: 200,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.graduationCap,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos de Pos-Graduacao',
                                            ),
                                            Text(
                                              'Cursos\nde\nPos-Graduacao',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons
                                                  .chalkboardTeacher,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos para Professores',
                                            ),
                                            Text(
                                              'Cursos\npara\nProfessores',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.handsHelping,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nLibras',
                                            ),
                                            Text(
                                              'Cursos\nde\nLibras',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.handsHelping,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nExtensao',
                                            ),
                                            Text(
                                              'Cursos\nde\nExtensao',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.medal,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nAperfeicoamento',
                                            ),
                                            Text(
                                              'Cursos\nde\nAperfeicoamento',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.laptopCode,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nTecnologia',
                                            ),
                                            Text(
                                              'Cursos\nde\nTecnologia',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.balanceScale,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nDireito',
                                            ),
                                            Text(
                                              'Cursos\nde\nDireito',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.bookMedical,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nSaúde',
                                            ),
                                            Text(
                                              'Cursos\nde\nSaúde',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      color: Colors.blueGrey[500],
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.language,
                                              color: Colors.black,
                                              size: 20.0,
                                              semanticLabel:
                                                  'Cursos\nde\nIdiomas',
                                            ),
                                            Text(
                                              'Cursos\nde\nIdiomas',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                  ])),
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
                            width: cWidth,
                            child: Column(
                              children: const <Widget>[
                                Text(
                                    "Super 24 horas de Promoção!!! Todos os preços caíram!!! CORRA: a promoção termina 18h dessa terça-feira !!! ",
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 600,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => SafeArea(
                                top: false,
                                bottom: false,
                                child: Hero(
                                  tag: index,
                                  child: HeroAnimatingCard(
                                    cours: snapshot.data![index],
                                    color: Colors.blueAccent,
                                    heroAnimation:
                                        const AlwaysStoppedAnimation(0),
                                    onPressed: () =>
                                        Navigator.of(context).push<void>(
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
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Promocaoes()),
                              );
                            },
                            icon: const Icon(FontAwesomeIcons.book, size: 18),
                            label: const Text("Veja todas as promocoes !"),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("you click on picture 1");
                            },
                            child: Image.asset("assets/images/1.png"),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("you click on picture 2");
                            },
                            child: Image.asset("assets/images/2.png"),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: const <Widget>[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("Por que nos escolher ?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins-bold',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20.0)),
                                ]),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const <Widget>[
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                        child: Text(
                                            "O Estude Sem Fronteiras é o único Portal de Cursos de Extensão, "
                                            "Aperfeiçoamento e Pós-Graduação 100% online cujo certificado é "
                                            "emitido por Instituição de Ensino Superior credenciada pelo MEC "
                                            "com Nota Máxima!",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontFamily: 'Poppins-Regular',
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15.0)))
                                  ],
                                ),/*
                                const Text("Po",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20.0)),*/
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: _launchURL,
                                  child:ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 300),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                        ),
                                        child: Image.asset(
                                          "assets/images/bate-papo-antonio.jpg",
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )),
                                  ),
                                ),
                              ]),
                        ]),
                  );
                }
                return Container();
              }),
        ));
  }

  void startTimer() {
  }

  // statistic information
  Widget rowStatic() {
    return Container(
        //degradation to make the text more clear
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.blueGrey,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('17',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
                Text('Áreas de Conhecimento',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('1320',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
                Text('Cursos',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('26400',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
                Text('Videos',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('263852',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
                Text('Alunos',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0)),
              ],
            ),
          ],
        ));
  }

  void _launchURL() async {
    if (!await launch('https://www.youtube.com/v/yvYkSsy-zRY'))
      throw 'Could not launch https://www.youtube.com/v/yvYkSsy-zRY';
  }

  Future<List<Courses>> fetchCourses(id) async {
    var url = 'http://192.168.1.123:8765/courses?page=' + id.toString();
    String body;
    var json;
    var parsed;
    final response = await http.get(Uri.parse(url)/*, {
      'Authorization': 'Bearer ${token}',
    }*/);
    body = response.body;
    json = jsonDecode(body);
    parsed = json["courses"].cast<Map<String, dynamic>>();
    print(json);
    return parsed.map<Courses>((json) => Courses.fromMap(json)).toList();
  }
}
