import 'package:flutter/material.dart';
import 'dart:math';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names
  final user_Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final password_Controller = TextEditingController();

  Future<bool> _onWillPop() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * 0.1),
                      title(),
                      const SizedBox(height: 8),
                      emailPasswordWidget(user_Controller, password_Controller),
                      const SizedBox(height: 05),
                      submitButton(
                          context, user_Controller, password_Controller),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              children:[
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 00),
                                  alignment: Alignment.centerRight,
                                  child: const Text('Esqueceu sua senha?',
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w900)
                                  ),
                                ),
                                GestureDetector(
                                  child: const Text('Clique aqui.',
                                      style: TextStyle(
                                          fontSize: 14,fontWeight: FontWeight.w900
                                      )
                                  ),
                                ),
                              ]
                          ),
                          createAccountLabel(context),
                        ],
                      ),
                      //_divider(),
                      //_facebookButton(),
                    ],
                  ),
                ),
              ),
             // Positioned(top: 40, left: 0, child: backButton(context)),
            ],
          ),
        ),
      ),
    );
  }
}
Widget emailPasswordWidget(TextEditingController userController,
    TextEditingController passwordController) {
  return Column(
    children: <Widget>[
      entryField("E-mail", userController),
      entryField("Senha", passwordController, isPassword: true),
    ],
  );
}
Widget title() {
  return
    Center(
          child: Image.asset(
            'assets/logos/header-logo_esf.png',
            width: 130,
            height: 130,
          ),
    );
}

Widget submitButton(context, TextEditingController userController,
    TextEditingController passwordController) {
  return InkWell(
      onTap: () async {
        Navigator.pushNamed(
        context,
        '/signup',
        );},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blueAccent, Colors.grey])),
        child: const Text(
          'Acessar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ));
}
Widget createAccountLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(
        context,
        '/signup',
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 10,
          ),
          Text(
            'Cadastre',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 13,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}
Widget entryField(String title, TextEditingController controller,
    {bool isPassword = false}) {
  var hint = title;
  if (title == "Telephone") {
    hint = "ex: 00 216 208 300 300";
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                fillColor: const Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}
class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height *.5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.indigo,Colors.blueGrey]
              )
          ),
        ),
      ),
    );
  }
}
class ClipPainter extends CustomClipper<Path>{
  @override

  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = Path();

    path.lineTo(0, size.height );
    path.lineTo(size.width , height);
    path.lineTo(size.width , 0);

    /// [Top Left corner]
    var secondControlPoint =  const Offset(0  ,0);
    var secondEndPoint = Offset(width * .2  , height *.3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);



    /// [Left Middle]
    var fifthControlPoint =  Offset(width * .3  ,height * .5);
    var fiftEndPoint = Offset(  width * .23, height *.6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy, fiftEndPoint.dx, fiftEndPoint.dy);


    /// [Bottom Left corner]
    var thirdControlPoint =  Offset(0  ,height);
    var thirdEndPoint = Offset(width , height  );
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);



    path.lineTo(0, size.height  );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }



}