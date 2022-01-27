// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final String cours;
  final Color color;
  final Animation<double> heroAnimation;
  final VoidCallback? onPressed;

  double get playButtonSize => 50 + 50 * heroAnimation.value;

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width * 1;
    double height = MediaQuery.of(context).size.height * 0.08;
    // This is an inefficient usage of AnimatedBuilder since it's rebuilding
    // the entire subtree instead of passing in a non-changing child and
    // building a transition widget in between.
    //
    // Left simple in this demo because this card doesn't have any real inner
    // content so this just rebuilds everything while animating.
    return Material(
        type: MaterialType.transparency,
        child:AnimatedBuilder(
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
                Image.asset(
                  "assets/images/imgCours.png",
                  width: 360,
                  height: 210,
                ),
                Container(
                  width: width,
                  height: 62,
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: new Column(children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Text(cours,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ]),
                  ),
                  decoration: BoxDecoration(
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
                    child: new Column(children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.rocket,
                            color: Colors.grey,
                            size: 10.0,
                          ),
                          SizedBox(width: 5,),
                          Text('Inicio',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(width: 5,),
                          Text('Imediato!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),

                          SizedBox(width: 5,),
                          Text('|',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(width: 5,),
                          Icon(
                            FontAwesomeIcons.globe,
                            color: Colors.grey,
                            size: 10.0,
                          ),
                          SizedBox(width: 5,),
                          Text('100% Online',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                          Text('|',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontFamily: 'Poppins-Regular',
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(width: 5,),
                          Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.grey,
                            size: 10.0,
                          ),
                          SizedBox(width: 5,),
                          Text('80 Horas',
                              style: TextStyle(
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
                        children: [
                          Icon(
                            FontAwesomeIcons.certificate,
                            color: Colors.grey,
                            size: 10.0,
                          ),
                          SizedBox(width: 5,),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(TextSpan(
                            text: '',
                            children: <TextSpan>[
                              new TextSpan(
                                text: '\$8.99',
                                style: new TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 15,
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                              new TextSpan(
                                text: ' \$3.99',
                                style: new TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins-Regular',
                              ),
                              ),
                            ],
                          ),
                          )
                        ],
                      ),
                    ]),
                  ),
                  decoration: BoxDecoration(
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
          children: [

          ],
        ),
      ),
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
