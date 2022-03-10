import 'package:estudesemfronteiras/Screen/my_home_page.dart';
import 'package:estudesemfronteiras/Screen/promocaoes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerDashWidget extends StatefulWidget {
  const DrawerDashWidget({Key? key}) : super(key: key);

  @override
  _DrawerDashWidgetState createState() => _DrawerDashWidgetState();
}

class _DrawerDashWidgetState extends State<DrawerDashWidget> {
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
                text: 'Inicio',
                onTap: () => {
                  Navigator.popAndPushNamed(
                            context,
                            '/inicio'
                          )
                    }),

            _createDrawerItem(
                icon: FontAwesomeIcons.book,
                text: 'Meus Cursos',
                onTap: () => {
                  Navigator.popAndPushNamed(
                      context,
                      '/meus_cursos'
                  )
                }),

            _createDrawerItem(
                icon: FontAwesomeIcons.barcode,
                text: 'Boletos',
                onTap: () => Navigator.popAndPushNamed(
                      context,
                      '/boletos',
                    )),

            _createDrawerItem(
                icon: FontAwesomeIcons.addressCard,
                text: 'Documentacao',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/Documentacao',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.mailBulk,
                text: 'falar com tutor',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/falar_com_tutor',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.certificate,
                text: 'Comprar cursos',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/comprar_cursos',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.userFriends,
                text: 'Historicoes de compras',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/historicoes_de_compras',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.percent,
                text: 'Certificados solicitados',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/certificados_solitados',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.percent,
                text: 'Declaracoes',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/declaracoes',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.percent,
                text: 'Duvidas e solicitacoes',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '',
                )),

            _createDrawerItem(
                text: '',
                ),

            _createDrawerItem(
                icon: FontAwesomeIcons.networkWired,
                text: 'Portal ESF',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/portal_esf',
                )),

            _createDrawerItem(
                icon: FontAwesomeIcons.percent,
                text: 'Blog',
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  '/blog',
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

