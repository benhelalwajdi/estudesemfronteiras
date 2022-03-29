import 'package:estudesemfronteiras/common_widget/bezierContainer.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  // ignore: non_constant_identifier_names
  final fullName_Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final user_Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final degitalCPF_Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final degitalPhone_Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final password_Controller = TextEditingController();

  var items = [
    'Onde nos conheceu?',
    'Indicação',
    'Instagram',
    'Google',
    'Facebook',
    'E-mail',
    'Outro',
  ];

  String dropdownvalue = 'Onde nos conheceu?';

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
                      widget(fullName_Controller, user_Controller, degitalCPF_Controller, degitalPhone_Controller, password_Controller),
                      const SizedBox(height: 05),
                      SizedBox(
                          width: 300.0,
                          child: DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      submitButton(context, user_Controller, password_Controller),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 00),
                              alignment: Alignment.centerRight,
                              child: const Text('Esqueceu sua senha?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900)),
                            ),
                            GestureDetector(
                              child: const Text('Clique aqui.',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ]),
                          createAccountLabel(context),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget widget(
    TextEditingController fullNameController,
    TextEditingController userController,
    TextEditingController degitalCPFController,
    TextEditingController degitalPhoneController,
    TextEditingController passwordController
    ) {
  return Column(
    children: <Widget>[
      entryField("Nome completo", fullNameController),
      entryField("E-mail", userController),
      entryField("Digite seu CPF", degitalCPFController),
      entryField("Digite seu celular", degitalPhoneController),
      entryField("Senha", passwordController, isPassword: true),
    ],
  );
}

Widget title() {
  return Center(
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
          '/dashboard',
        );
      },
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
          'Cadastrar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ));
}

