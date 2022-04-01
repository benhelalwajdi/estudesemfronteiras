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
var datel;
  var gender = ['macho', 'fêmea', 'outro'];
  String dropdownvalue = 'Onde nos conheceu?';
  String dropdownGendervalue = 'macho';

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
                      titleSignup(),
                      const SizedBox(height: 8),
                      widgetSignup(
                          fullName_Controller,
                          user_Controller,
                          degitalCPF_Controller,
                          degitalPhone_Controller,
                          password_Controller),
                      /*const SizedBox(height: 05),
                      SizedBox(
                          width: 300.0,
                          child:
                          DropdownButton<DateTime>(
                              hint: Text('Escolha uma data'),
                              items: [
                                'abra o calendário'
                              ].map((e) => DropdownMenuItem<DateTime>(child: Text(e))).toList(),
                              onChanged: (value) {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2099));
                                setState(() {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2099))
                                      .then((date) {
                                    setState(() {
                                      print(datel.toString());
                                      datel = date;
                                    });
                                  });
                                });
                              }
                              )
                      ),*/
                      const SizedBox(height: 05,),
                      SizedBox(
                          width: 300.0,
                          child: DropdownButton<String>(
                            value: dropdownGendervalue,
                            items: gender.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownGendervalue = value!;
                              });
                              print(value);
                            },
                          )),
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
                      submitCreationButton(
                          context,
                          user_Controller,
                          password_Controller,
                          dropdownvalue,
                          dropdownGendervalue,
                          fullName_Controller,
                          degitalCPF_Controller,
                          degitalPhone_Controller),
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
