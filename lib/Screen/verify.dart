import 'dart:async';
import 'dart:convert';

import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);


  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _onEditing = true;
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;
  String _code = '';

  @override
  void initState()  {
    super.initState();
    getVerif();
  }

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(() {
          if (_start == 0) {
            _start = 60;
            _isResendAgain = false;
            timer.cancel();
          } else {
            _start--;
          }
        });
      },
    );
  }

  verify() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var list = _prefs.getStringList('validation');
    if(list![1]== _code){

      print(_code);
      setState(() {
        _isLoading = true;
      });

      const oneSec = const Duration(milliseconds: 1000);
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) {
          setState(() {
            _isLoading = false;
            _isVerified = true;
          });
        },
      );
      print(_prefs.get('token').toString() + 'the token saved from user ');
      Navigator.popAndPushNamed(context, '/dashboard');
    }else {
      setState(() {
        _isLoading = true;
      });

      const oneSec = const Duration(milliseconds: 1000);
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) {
          setState(() {
            _isVerified = false;
          });
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: Transform.rotate(
                  angle: 38,
                  child: Image(
                    image: AssetImage('assets/email.png'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 30,
              ),
              Text(
                "Digite o código de verificação de 4 dígitos enviado para seu e-mail.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.blue),
              ),
              SizedBox(
                height: 30,
              ),
              VerificationCode(
                textStyle: TextStyle(fontSize: 20.0, color: Colors.blue),
                underlineColor: Colors.blueAccent,
                keyboardType: TextInputType.number,
                length: 4,
                onCompleted: (String value) {
                  setState(() {
                    _code = value;
                  });
                },
                onEditing: (bool value) {
                  setState(() {
                    _onEditing = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não recebeu o código de verificação?",
                    style: TextStyle(
                        fontSize: 14, height: 1.5, color: Colors.blue),
                  ),
                  TextButton(
                      onPressed: () {
                        if (_isResendAgain) return;
                        startTimer();
                      },
                      child: Text(
                        _isResendAgain
                            ? 'Tente novamente ' + _start.toString()
                            : "Envie novamente ",
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.blueAccent),
                      )),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                  disabledColor: Colors.blue,
                  height: 50,
                  onPressed: _code.length < 4
                      ? null
                      : () {

                          print('test');
                          verify();
                        },
                  minWidth: 200,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: _isLoading
                      ? Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : _isVerified
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 30,
                            )
                          : Text(
                              'Verificar',
                              style: TextStyle(color: Colors.white),
                            )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getVerif() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String>? verif = _prefs.getStringList("validation");
    _code = verif![1];
  }
}