// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/common_widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Page shown when a card in the songs tab is tapped.
///
/// On Android, this page sits at the top of your app. On iOS, this page is on
/// top of the songs tab's content but is below the tab bar itself.
class CoursDetailTab extends StatelessWidget {
  const CoursDetailTab({
    required this.id,
    required this.cours,
    required this.color,
    Key? key,
  }) : super(key: key);

  final int id;
  final Courses cours;
  final Color color;

  Widget _buildBody() {

    print(cours.methodology);

    return Material(
        type: MaterialType.transparency,
        child: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: id,
                child: HeroAnimatingCard(
                  cours: cours,
                  color: color,
                  heroAnimation: const AlwaysStoppedAnimation(1),
                ),
                // This app uses a flightShuttleBuilder to specify the exact widget
                // to build while the hero transition is mid-flight.
                //
                // It could either be specified here or in SongsTab.
                flightShuttleBuilder: (context, animation, flightDirection,
                    fromHeroContext, toHeroContext) {
                  return HeroAnimatingCard(
                    cours: cours,
                    color: color,
                    heroAnimation: animation,
                  );
                },
              ),
              const Divider(
                height: 0,
                color: Colors.grey,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 16, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sobre o ' + cours.name.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cours.description,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.book,
                                    color: Colors.black87,
                                    size: 20.0,
                                    semanticLabel:
                                        "Conteúdo do curso " + cours.name,
                                  ),
                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(
                                      "Conteúdo do curso " + cours.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                cours.themes,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.tag,
                                    color: Colors.black87,
                                    size: 20.0,
                                    semanticLabel:
                                    "Como funciona o curso " + cours.name,
                                  ),
                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(
                                      "Como funciona o curso " + cours.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                cours.methodology== null? cours.authors:cours.methodology,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.bullseye,
                                    color: Colors.black87,
                                    size: 20.0,
                                    semanticLabel:
                                    "Público-alvo do Curso " + cours.name,
                                  ),
                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: Text("Público-alvo do Curso " + cours.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                cours.target_public,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidFlag,
                                    color: Colors.black87,
                                    size: 20.0,
                                    semanticLabel:
                                    "Objetivo do " + cours.name,
                                  ),
                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: Text("Objetivo do " + cours.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                cours.objectives,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ));
                    }
                    // Just a bunch of boxes that simulates loading song choices.
                    return const CoursPlaceholderTile();
                  },
                ),
              ),
            ],
          ),
        ));
  }

  // ===========================================================================
  // Non-shared code below because we're using different scaffolds.
  // ===========================================================================

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cours.name)),
      body: _buildBody(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(cours.name),
        previousPageTitle: 'Songs',
      ),
      child: _buildBody(),
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
