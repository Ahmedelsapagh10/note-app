import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_pad/modules/add_details/view/details.dart';
import 'package:note_pad/modules/add_details/view/details_view.dart';
import 'package:note_pad/modules/home/controller/cubit.dart';
import 'package:note_pad/modules/home/controller/state.dart';

class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Home_Cubit(),
      child: BlocBuilder<Home_Cubit, Home_State>(
        builder: (context, state) {
          Home_Cubit controller = context.read<Home_Cubit>();
          return Scaffold(
              backgroundColor: controller.ScaffoldColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: controller.ScaffoldColor,
                foregroundColor: controller.AppBarColor,
                title: Text(
                  'Note',
                  style: TextStyle(
                    fontFamily: controller.noteFont,
                    fontSize: 28,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.ButtonColor,
                      ),
                      child: TextButton(
                        child: Text(
                          'New',
                          style: TextStyle(
                            color: controller.AppBarColor,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Add_Details(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                elevation: 10,
                backgroundColor: controller.ScaffoldColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration:
                          BoxDecoration(color: controller.ScaffoldColor),
                      accountName: Text(
                        "Ahmed Mohamed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.AppBarColor),
                      ),
                      accountEmail: Text(
                        "AhmedElsapagh@gmail.com",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.AppBarColor),
                      ),
                      currentAccountPicture: FlutterLogo(),
                    ),
                    ListTile(
                      leading: Icon(
                        controller.mode,
                        color: controller.AppBarColor,
                      ),
                      title: Text(
                        'change Mode',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.AppBarColor),
                      ),
                      onTap: () {
                        controller.changeMode();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: controller.AppBarColor,
                      ),
                      title: Text(
                        'Exit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.AppBarColor),
                      ),
                      onTap: () {
                        exit(0);
                      },
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: AnimationLimiter(
                    child: GridView.custom(
                      gridDelegate: SliverStairedGridDelegate(
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 0,
                        startCrossAxisDirectionReversed: true,
                        pattern: [
                          StairedGridTile(0.5, 1),
                          StairedGridTile(0.5, 1),
                          StairedGridTile(1.0, 10 / 4),
                          StairedGridTile(0.5, 3 / 4),
                          StairedGridTile(0.5, 3 / 4),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: controller.noteTitle.length,
                        (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  view_Details(
                                                    model: controller
                                                        .noteTitle[index],
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        margin: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            color: controller.ContainerColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1,
                                                color: controller.HintColor)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller
                                                    .noteTitle[index].title,
                                                softWrap: false,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        controller.titleFont,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        controller.TextColor),
                                              ),
                                              // Text(
                                              //   controller
                                              //       .noteTitle[index].body,
                                              //   maxLines: 1,
                                              //   textAlign: TextAlign.center,
                                              //   overflow: TextOverflow.fade,
                                              //   style: TextStyle(
                                              //       fontSize: 10,
                                              //       fontWeight: FontWeight.bold,
                                              //       color:
                                              //           controller.TextColor),
                                              // ),
                                            ]),
                                      ),
                                    ),
                                  ))));
                        },
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
