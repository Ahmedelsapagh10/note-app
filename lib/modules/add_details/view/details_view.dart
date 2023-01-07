import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/modules/add_details/provider/model.dart';

import 'package:note_pad/modules/home/controller/cubit.dart';
import 'package:note_pad/modules/home/controller/state.dart';
import 'package:note_pad/modules/home/view/home.dart';

class view_Details extends StatelessWidget {
  const view_Details({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Home_Cubit(),
      child: BlocBuilder<Home_Cubit, Home_State>(
        builder: (context, state) {
          Home_Cubit x = context.read<Home_Cubit>();
          return Scaffold(
              backgroundColor: x.ScaffoldColor,
              appBar: AppBar(
                backgroundColor: x.ScaffoldColor,
                foregroundColor: x.AppBarColor,
                title: Text(
                  'notes',
                  style: TextStyle(
                    fontFamily: x.noteFont,
                    fontSize: 22,
                    color: x.AppBarColor,
                  ),
                ),
                leading: InkWell(
                  child: Icon(Icons.arrow_back_ios_new),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        await x.deleteFormDB(model);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => home_screen())));
                      },
                      // ignore: prefer_const_constructors
                      child: Icon(
                        size: 28,
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async => await x.onTabToEdit(model),
                      color: x.AppBarColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: myWidget(x, model, context),

                //       child: Column(
                //         children: [
                //       Expanded(
                //   flex: 1,
                //   child: Text(
                //     model.title,
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 240, 216, 3),
                //       fontSize: 28,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     margin: EdgeInsets.only(left: 5),
                //     child: Text(
                //       model.body,
                //       style: const TextStyle(
                //         color: Color.fromARGB(255, 240, 216, 3),
                //         fontSize: 22,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //   ),
                // ),
                //           TextFormField(
                //             cursorColor: Color.fromARGB(255, 240, 216, 3),
                //             controller: con.Edit_title,
                //             maxLines: 1,
                //             style: const TextStyle(
                //               color: Color.fromARGB(255, 240, 216, 3),
                //               fontSize: 22,
                //               fontWeight: FontWeight.bold,
                //             ),
                //             textDirection: TextDirection.ltr,
                //             decoration: const InputDecoration(
                //               fillColor: Color.fromARGB(255, 240, 216, 3),
                //               hintText: 'title',
                //             ),
                //           ),
                //           Flexible(
                //             child: Container(
                //               margin: EdgeInsets.only(left: 5),
                //               child: TextFormField(
                //                 cursorColor: Color.fromARGB(255, 240, 216, 3),
                //                 controller: con.Edit_body,
                //                 style: const TextStyle(
                //                   color: Color.fromARGB(255, 240, 216, 3),
                //                   fontSize: 22,
                //                   fontWeight: FontWeight.normal,
                //                 ),
                //                 textDirection: TextDirection.ltr,
                //                 autocorrect: true,
                //                 enableSuggestions: true,
                //                 maxLines: 5000,
                //                 decoration: const InputDecoration(
                //                   border: InputBorder.none,
                //                   hintText: 'note',
                //                   focusColor: Color.fromARGB(255, 240, 216, 3),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   Expanded(
                //     flex: 1,
                //     child: Center(
                //       child: IconButton(
                //           onPressed: () async {
                //             await con.updateNotes();
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => home_screen()));
                //           },
                //           icon: Icon(Icons.done)),
                //     ),
                //   )
                // ]),
              ));
        },
      ),
    );
  }
}

Widget myWidget(Home_Cubit x, HomeModel model, BuildContext context) {
  if (x.whatMode == false) {
    return ListView(children: [
      Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              model.title,
              // textAlign: (model.title.codeUnitAt(0) >= 65 &&
              //         model.title.codeUnitAt(0) <= 122)
              //     ? TextAlign.left
              //     : TextAlign.right,
              // textDirection: ((model.title.toString()).codeUnitAt(1) >= 65 &&
              //         (model.title.toString()).codeUnitAt(1) <= 122)
              //     ? TextDirection.ltr
              //     : TextDirection.rtl,
              style: TextStyle(
                color: x.AppBarColor,
                fontSize: 28,
                fontFamily: x.titleFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 5),
            child: Text(
              model.body,
              // textAlign: (model.body.codeUnitAt(0) >= 65 &&
              //         model.body.codeUnitAt(0) <= 122)
              //     ? TextAlign.left
              //     : TextAlign.right,
              // textDirection: ((model.body.toString()).codeUnitAt(1) >= 65 &&
              //         (model.body.toString()).codeUnitAt(1) <= 122)
              //     ? TextDirection.ltr
              //     : TextDirection.rtl,
              style: TextStyle(
                color: x.AppBarColor,
                fontFamily: x.noteFont,
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    ]);
  } else {
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        // child: Directionality(
        //   textDirection: ((x.Edit_title.toString()).codeUnitAt(0) >= 65 &&
        //           (x.Edit_title.toString()).codeUnitAt(0) <= 122)
        //       ? TextDirection.ltr
        //       : TextDirection.rtl,
        child: Container(
          width: double.infinity,
          child: TextFormField(
            cursorColor: x.AppBarColor,
            controller: x.Edit_title,
            textAlign: ((x.Edit_title.toString()).codeUnitAt(0) >= 65 &&
                    (x.Edit_title.toString()).codeUnitAt(0) <= 122)
                ? TextAlign.left
                : TextAlign.right,
            maxLines: 1,
            style: TextStyle(
              color: x.AppBarColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              fillColor: x.AppBarColor,
              hintText: 'title',
            ),
            //   ),
          ),
        ),
      ),
      Flexible(
        // child:
        //  Directionality(
        //   textDirection: ((x.Edit_body.toString()).codeUnitAt(0) >= 65 &&
        //           (x.Edit_body.toString()).codeUnitAt(0) <= 122)
        //       ? TextDirection.ltr
        //       : TextDirection.rtl,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 5),
          child: TextFormField(
            cursorColor: x.AppBarColor,
            controller: x.Edit_body,
            textAlign: ((x.Edit_body.toString()).codeUnitAt(0) >= 65 &&
                    (x.Edit_body.toString()).codeUnitAt(0) <= 122)
                ? TextAlign.left
                : TextAlign.right,
            style: TextStyle(
              color: x.AppBarColor,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
            textDirection: TextDirection.ltr,
            autocorrect: true,
            enableSuggestions: true,
            maxLines: 5000,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'note',
              focusColor: x.AppBarColor,
            ),
          ),
        ),
      ),
      //  ),
      FloatingActionButton.extended(
        label: Text(
          'Save',
          style: TextStyle(
            fontFamily: x.noteFont,
            fontWeight: FontWeight.bold,
            color: x.AppBarColor,
            fontSize: 22,
          ),
        ),
        tooltip: 'Save Editing',
        hoverColor: Colors.yellow,
        backgroundColor: x.ButtonColor,
        icon: const Icon(Icons.done),
        onPressed: () async {
          await x.updateNotes();
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => home_screen()));
        },
      )
    ]);
  }
}
