import 'package:estudesemfronteiras/common_widget/bezierContainer.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


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

