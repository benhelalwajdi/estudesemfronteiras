// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A simple widget that builds different things on different platforms.
class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    Key? key,
    required this.androidBuilder,
    required this.iosBuilder,
  }) : super(key: key);

  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;

  @override
  Widget build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      default:
        assert(false, 'Unexpected platform $defaultTargetPlatform');
        return const SizedBox.shrink();
    }
  }
}

/// A platform-agnostic card with a high elevation that reacts when tapped.
///
/// This is an example of a custom widget that an app developer might create for
/// use on both iOS and Android as part of their brand's unique design.
class PressableCard extends StatefulWidget {
  const PressableCard({
    this.onPressed,
    required this.color,
    required this.flattenAnimation,
    this.child,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color color;
  final Animation<double> flattenAnimation;
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard>
    with SingleTickerProviderStateMixin {
  bool pressed = false;
  late final AnimationController controller;
  late final Animation<double> elevationAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 40),
    );
    elevationAnimation =
        controller.drive(CurveTween(curve: Curves.easeInOutCubic));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double get flatten => 1 - widget.flattenAnimation.value;

  @override
  Widget build(context) {
    return Listener(
      onPointerDown: (details) {
        if (widget.onPressed != null) {
          controller.forward();
        }
      },
      onPointerUp: (details) {
        controller.reverse();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.onPressed?.call();
        },
        // This widget both internally drives an animation when pressed and
        // responds to an external animation to flatten the card when in a
        // hero animation. You likely want to modularize them more in your own
        // app.
        child: AnimatedBuilder(
          animation:
              Listenable.merge([elevationAnimation, widget.flattenAnimation]),
          child: widget.child,
          builder: (context, child) {
            return Transform.scale(
              // This is just a sample. You likely want to keep the math cleaner
              // in your own app.
              scale: 1 - elevationAnimation.value * 0.03,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16) *
                        flatten,
                child: PhysicalModel(
                  elevation:
                      ((1 - elevationAnimation.value) * 10 + 10) * flatten,
                  borderRadius: BorderRadius.circular(12 * flatten),
                  clipBehavior: Clip.antiAlias,
                  color: widget.color,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A platform-agnostic card representing a song which can be in a card state,
/// a flat state or anything in between.
///
/// When it's in a card state, it's pressable.
///
/// This is an example of a custom widget that an app developer might create for
/// use on both iOS and Android as part of their brand's unique design.
class HeroAnimatingCard extends StatelessWidget {
  const HeroAnimatingCard({
    required this.cours,
    required this.color,
    required this.heroAnimation,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Courses cours;
  final Color color;
  final Animation<double> heroAnimation;
  final VoidCallback? onPressed;

  double get playButtonSize => 50 + 50 * heroAnimation.value;

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width * 0.863;
    // This is an inefficient usage of AnimatedBuilder since it's rebuilding
    // the entire subtree instead of passing in a non-changing child and
    // building a transition widget in between.
    //
    // Left simple in this demo because this card doesn't have any real inner
    // content so this just rebuilds everything while animating.
    return Material(
        type: MaterialType.transparency,
        child: AnimatedBuilder(
          animation: heroAnimation,
          builder: (context, child) {
            return PressableCard(
                onPressed: heroAnimation.value == 0 ? onPressed : null,
                color: Colors.transparent,
                flattenAnimation: heroAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imgWid(cours),
                    Container(
                      width: width,
                      height: 62,
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(children: <Widget>[
                          Text(cours.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                        ]),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        boxShadow: [
                          BoxShadow(color: Colors.transparent, blurRadius: 3),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: 200,
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.rocket,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Inicio',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Imediato!',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('|',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.globe,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('100% Online',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const Text('|',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(cours.workload.toString() + ' Horas',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                FontAwesomeIcons.certificate,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Nota Máxima no MEC',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logos/logotipo_faculdade_metropolitana.png",
                                width: 100,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'R\$' +
                                          cours.orig_price.toString() +
                                          '  ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'R\$' + cours.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Button to dispaly more details
                              OutlinedButton.icon(
                                onPressed: () {
                                  /*TODO*/
                                },
                                icon: const Icon(Icons.shopping_cart, size: 18),
                                label: const Text("Saiba mais"),
                              ),
                              // Button to pay
                              OutlinedButton.icon(
                                onPressed: () {
                                  /*TODO*/
                                },
                                icon: const Icon(Icons.shopping_cart, size: 18),
                                label: const Text("Comprar"),
                              )
                            ],
                          ),
                        ]),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.transparent, blurRadius: 3),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        ));
  }
}

class HeroAnimatingCardDash extends StatelessWidget {
  const HeroAnimatingCardDash({
    required this.cours,
    required this.color,
    required this.heroAnimation,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Courses cours;
  final Color color;
  final Animation<double> heroAnimation;
  final VoidCallback? onPressed;

  double get playButtonSize => 50 + 50 * heroAnimation.value;

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width * 0.863;
    // This is an inefficient usage of AnimatedBuilder since it's rebuilding
    // the entire subtree instead of passing in a non-changing child and
    // building a transition widget in between.
    //
    // Left simple in this demo because this card doesn't have any real inner
    // content so this just rebuilds everything while animating.
    return Material(
        type: MaterialType.transparency,
        child: AnimatedBuilder(
          animation: heroAnimation,
          builder: (context, child) {
            return PressableCard(
                onPressed: heroAnimation.value == 0 ? onPressed : null,
                color: Colors.transparent,
                flattenAnimation: heroAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imgWid(cours),
                    Container(
                      width: width,
                      height: 62,
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(children: <Widget>[
                          Text(cours.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                        ]),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        boxShadow: [
                          BoxShadow(color: Colors.transparent, blurRadius: 3),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      height: 200,
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.rocket,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Inicio',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Imediato!',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('|',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.globe,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('100% Online',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const Text('|',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(cours.workload.toString() + ' Horas',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                FontAwesomeIcons.certificate,
                                color: Colors.grey,
                                size: 10.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Nota Máxima no MEC',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logos/logotipo_faculdade_metropolitana.png",
                                width: 100,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'R\$' +
                                          cours.orig_price.toString() +
                                          '  ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'R\$' + cours.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Button to dispaly more details
                              OutlinedButton.icon(
                                onPressed: () {
                                  /*TODO*/
                                },
                                icon: const Icon(Icons.shopping_cart, size: 18),
                                label: const Text("Saiba mais"),
                              ),
                              // Button to pay
                              OutlinedButton.icon(
                                onPressed: () {
                                  /*TODO*/
                                },
                                icon: const Icon(Icons.shopping_cart, size: 18),
                                label: const Text("Comprar"),
                              )
                            ],
                          ),
                        ]),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.transparent, blurRadius: 3),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        ));
  }
}

/// A loading song tile's silhouette.
///
/// This is an example of a custom widget that an app developer might create for
/// use on both iOS and Android as part of their brand's unique design.
class CoursPlaceholderTile extends StatelessWidget {
  const CoursPlaceholderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [],
        ),
      ),
    );
  }
}

Widget imgWid(Courses cours) {
  if (cours.photo == 'null') {
    return Image.asset(
      'assets/images/imgCours.png',
      fit: BoxFit.fill,
    );
  } else {
    return Image.network(
      'https://www.estudesemfronteiras.com/novo/img/upload/${cours.course_id}/${cours.photo}',
      fit: BoxFit.fill,
    );
  }
}

// ===========================================================================
// Non-shared code below because different interfaces are shown to prompt
// for a multiple-choice answer.
//
// This is a design choice and you may want to do something different in your
// app.
// ===========================================================================
/// This uses a platform-appropriate mechanism to show users multiple choices.
///
/// On Android, it uses a dialog with radio buttons. On iOS, it uses a picker.
void showChoices(BuildContext context, List<String> choices) {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      showDialog<void>(
        context: context,
        builder: (context) {
          int? selectedRadio = 1;
          return AlertDialog(
            contentPadding: const EdgeInsets.only(top: 12),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(choices.length, (index) {
                    return RadioListTile<int?>(
                      title: Text(choices[index]),
                      value: index,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() => selectedRadio = value);
                      },
                    );
                  }),
                );
              },
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    case TargetPlatform.iOS:
      showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: CupertinoPicker(
              backgroundColor: Theme.of(context).canvasColor,
              useMagnifier: true,
              magnification: 1.1,
              itemExtent: 40,
              scrollController: FixedExtentScrollController(initialItem: 1),
              children: List<Widget>.generate(choices.length, (index) {
                return Center(
                  child: Text(
                    choices[index],
                    style: const TextStyle(
                      fontSize: 21,
                    ),
                  ),
                );
              }),
              onSelectedItemChanged: (value) {},
            ),
          );
        },
      );
      return;
    default:
      assert(false, 'Unexpected platform $defaultTargetPlatform');
  }
}

void upDateSharedPreferences(context, String token, int id) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  try {
    _prefs.setString('token', token);
    _prefs.setInt('id', id);
    print(_prefs.get('token').toString() + 'the token saved from user ');
    Navigator.popAndPushNamed(
      context,
      '/dashboard'
    );
  } catch (e) {
    print(e);
  }
}

Widget submitButton(context, TextEditingController userController,
    TextEditingController passwordController) {
  print(passwordController.value.text.toString());
  print(userController.value.text.toString());

  return InkWell(
      onTap: () async {
        // test if the password and the email they are not empty or they are not wrong
        if ((passwordController.value.text.toString().isEmpty &&
                userController.value.text.isEmpty) ||
            (userController.value.text.isEmpty) ||
            (passwordController.value.text.toString().isEmpty)) {
          _showDialog(
              context, "Login", "e-mail ou senha estavam vazios", "Confirmar");
        }
        // if the password they are valid send it to the server :
        else {
          var body = jsonEncode({
            "email": userController.text.toString(),
            "password": passwordController.text.toString()
          });
          await http.post(
              Uri.parse('http://192.168.1.123:8765/users/login'),
              headers: {"Content-Type": "application/json"},
              body: body
          ).then((http.Response response) async {
            if (response.body.toString() == '[]') {
              _showDialog(context, "Login", "E-mail ou senha está incorreto", "Confirmar");
              print('is empty');
            } else {
              print('it s ok ${response.body.toString()}');
              var json = jsonDecode(response.body.toString());
              print(json['token']);
              print(json['user']['id']);
              upDateSharedPreferences(
                  context,
                  json['token'].toString(),
                  int.parse(json['user']['id'].toString())
              );
            }
          });
        }
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
          'Acessar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ));
}

void _showDialog(context, titre, content, btnText) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context, titre, content, btnText),
      );
    },
  );
}

Widget dialogContent(BuildContext context, title, descriptions, btnText) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
            left: 16.0, top: 66.0 + 16.0, right: 16.0, bottom: 16.0),
        margin: EdgeInsets.only(top: 66.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              descriptions,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    btnText,
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
      Positioned(
        left: 16.0,
        right: 16.0,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 75.0,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(66.0)),
              child: Image.asset("assets/logos/header-logo_esf.png")),
        ),
      ),
    ],
  );
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
                color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}

Widget entryField(String title, TextEditingController controller,
    {bool isPassword = false}) {
  var hint = title;
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
