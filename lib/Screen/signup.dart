import 'dart:core';

import 'package:estudesemfronteiras/common_widget/bezierContainer.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  final password_Controller2 = TextEditingController();

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

  bool _validateCpf = false;
  bool _validateSenha = false;
  bool _validateSenhaConf = false;

  bool _validate = false;
  String zip_code =' ';
  String city=' ';
  String adress=' ';
  String state=' ';

  Future<bool> _onWillPop() async {
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   determinePosition().then((value) {
      print('the value $value');
      getPlace(value);
    });

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
                          password_Controller,
                          password_Controller2),
                      const SizedBox(
                        height: 05,
                      ),
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
                          degitalPhone_Controller,
                          zip_code,
                          city,
                          adress,
                          state,
                      ),
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

  Widget entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    var hint = title;
    if (title == 'Digite seu CPF') {
      print('it CPF');
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
                onTap: () {
                  controller.text = controller.text.replaceAll('-', '');
                  if (controller.text.length <= 15) {
                    setState(() {
                      _validateCpf = true;
                    });
                  } else {
                    setState(() {
                      _validateCpf = false;
                    });
                  }
                },
                onEditingComplete: () {
                  var cpf = '';
                  print(controller.text);
                  //if(controller.text)
                  for (int i = 0; i < controller.text.length; i++) {
                    cpf = cpf + controller.text[i];
                    print(controller.text[i]);
                    if ((i == 2) && (controller.text[i] != '-')) {
                      cpf = cpf + '-';
                    } else if (i == 5 && (controller.text[i] != '-')) {
                      cpf = cpf + '-';
                    } else if (i == 8 && (controller.text[i] != '-')) {
                      cpf = cpf + '-';
                    } else if (i == 10 && (controller.text[i] != '-')) {
                      controller.text = cpf;
                    }
                  }
                },
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                    hintText: hint,
                    errorText: _validateCpf
                        ? null
                        : 'O CPF não pode ser menor que 11 números',
                    border: InputBorder.none,
                    fillColor: const Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      );
    } else if (title == 'Senha') {
      String msg = '';
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
                onEditingComplete: () {
                  print(controller.text);
                  if (controller.text.length >= 8) {
                    setState(() {
                      _validateSenha = true;
                    });
                  } else {
                    setState(() {
                      _validateSenha = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    errorText: _validateSenha
                        ? null
                        : 'A senha deve ter 8 caracteres ou mais',
                    fillColor: const Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      );
    } else if (title == 'Confirme a Senha') {
      String msg = '';
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
                onEditingComplete: () {
                  print(controller.text);
                  if (password_Controller2.text
                          .compareTo(password_Controller.text) ==
                      0) {
                    print('i check' +
                        password_Controller2.text
                            .compareTo(password_Controller.text)
                            .toString());
                    setState(() {
                      _validateSenhaConf = true;
                    });
                  } else {
                    setState(() {
                      _validateSenhaConf = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    errorText:
                        _validateSenhaConf ? 'null' : 'A confirmação inválida',
                    fillColor: const Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      );
    } else if (title == 'E-mail') {
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
                onEditingComplete: () {
                  print(EmailValidator.validate(controller.text));
                  setState(() {
                    _validate = EmailValidator.validate(controller.text);
                  });
                },
                decoration: InputDecoration(
                    hintText: hint,
                    errorText: _validate ? null : "E-mail inválido",
                    border: InputBorder.none,
                    fillColor: const Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      );
    } else if (title == 'Digite seu celular') {
      //21 3333 3333
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
                onEditingComplete: () {
                  if (controller.text.length == 8) {
                    print(controller.text);
                    var state = controller.text[0] + controller.text[1];

                    if(int.parse(state) ==99)
                    {
                      print(state);
                    }/*
                      &&
                       int.parse(state) <= 11 &&
                        controller.text[1]!= 0
                    ){
                      print('phone done');
                    }else{
                      print('error');
                    }*/
                  }else{
                    print('error');
                  }
                },
                decoration: InputDecoration(
                    hintText: hint,
                    errorText: _validate ? null : "número de telefone inválido",
                    border: InputBorder.none,
                    fillColor: const Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      );
    } else {
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
  }

  Widget widgetSignup(
      TextEditingController fullNameController,
      TextEditingController userController,
      TextEditingController degitalCPFController,
      TextEditingController degitalPhoneController,
      TextEditingController passwordController,
      TextEditingController password2Controller) {
    return Column(
      children: <Widget>[
        entryField("E-mail", userController),
        entryField("Senha", passwordController, isPassword: true),
        entryField("Confirme a Senha", password2Controller, isPassword: true),
        entryField("Nome completo", fullNameController),
        entryField("Digite seu CPF", degitalCPFController),
        entryField("Digite seu celular", degitalPhoneController),
      ],
    );
  }


  String _address = ""; // create this variable

  getPlace(_position) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(_position.latitude, _position.longitude).timeout(Duration(seconds: 2));

    // this is all you need
    Placemark placeMark  = newPlace[0];
    this.adress = placeMark.name!;
    adress = adress+ ' ' + placeMark.subLocality!;
    this.city  = placeMark.subAdministrativeArea!;
    this.state = placeMark.administrativeArea!;
    this.zip_code = placeMark.postalCode!;
    String? country = placeMark.country;
    String address = "${adress}, ${this.city}, ${this.zip_code} ${state}, ${country}";

    print(address);
    return placeMark;
  }
}
