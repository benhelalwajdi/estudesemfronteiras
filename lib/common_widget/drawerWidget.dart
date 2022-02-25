import 'package:estudesemfronteiras/Screen/my_home_page.dart';
import 'package:estudesemfronteiras/Screen/promocaoes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),
            _createDrawerItem(
                icon: FontAwesomeIcons.home,
                text: 'Pagina Inicial',
                onTap: () => {Navigator.popAndPushNamed(
                            context,
                            '/home'
                          )
                    }),
            _createDrawerItem(
                icon: FontAwesomeIcons.chartLine,
                text: 'Extensão/Aperfeiçoamento',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    )),
            _createDrawerItem(
                icon: FontAwesomeIcons.addressCard,
                text: 'Quem somos',
                onTap: () => Navigator.popAndPushNamed(
                      context,
                      '/about',
                    )),
            _createDrawerItem(
                icon: FontAwesomeIcons.userGraduate,
                text: 'Pós-Graduação',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    )),
            _createDrawerItem(
                icon: FontAwesomeIcons.certificate,
                text: 'Certificação',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    )),
            _createDrawerItem(
                icon: FontAwesomeIcons.userFriends,
                text: 'Dúvidas',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    )),
            _createDrawerItem(
                icon: FontAwesomeIcons.percent,
                text: 'Promoções',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Promocaoes()),
                    )),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Image.asset(
              'assets/logos/header-logo_esf.png',
              width: 130,
              height: 130,
            ),
          ),
        ),

      ]));
}

Widget _createDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Color(0xFF808080),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text!,
            style: TextStyle(color: Color(0xFF484848)),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
