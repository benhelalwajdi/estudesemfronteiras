import 'package:estudesemfronteiras/common_widget/AppBarWidget.dart';
import 'package:estudesemfronteiras/common_widget/BottomNavBarWidget.dart';
import 'package:estudesemfronteiras/common_widget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}
int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

class _MyHomePageNewState extends State<MyHomePage> {
  final List<Widget> viewContainer = [
    /*HomeScreen(),
    WishListScreen(),
    ShoppingCartScreen(),
    HomeScreen()*/
  ];

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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppSignIn()),
          );*/
              },
              icon: Icon(FontAwesomeIcons.user),
              color: Color(0xFF323232),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}


/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.blueAccent.withOpacity(0.3),
                    indicatorColor: Colors.blueAccent,
                    labelColor: Colors.blueAccent,
                    tabs: const [
                      Tab(
                        child: Text('Extensão/Aperfeiçoamento'),
                      ),
                      Tab(
                        child: Text('Pós-Graduação'),
                      ),
                      Tab(
                        child: Text('Certificação'),
                      ),
                      Tab(
                        child: Text('Quem somos'),
                      ),
                      Tab(
                        child: Text('Dúvidas'),
                      ),
                      Tab(
                        child: Text('Promoções'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
          ),
          body: TabBarView(
            children: <Widget>[
              ExtensaoPage(),
              PosgraduacaoPage(),
              CertificacaoPage(),
              QuemSomosPage(),
              DuvidasPage(),
              PromocoesPage()
            ],
          )),
    );
  }
  }*/
