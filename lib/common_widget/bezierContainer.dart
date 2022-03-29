import 'dart:math';
import 'package:flutter/material.dart';
import 'clipPainter.dart';

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