import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/modules/add_details/provider/model.dart';
import 'package:note_pad/modules/home/controller/cubit.dart';
import 'package:note_pad/modules/home/controller/state.dart';
import 'package:note_pad/modules/home/view/home.dart';

class Add_Details extends StatefulWidget {
  const Add_Details({
    Key? key,
  }) : super(key: key);

  @override
  State<Add_Details> createState() => _Add_DetailsState();
}

class _Add_DetailsState extends State<Add_Details> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Home_Cubit(),
      child: BlocBuilder<Home_Cubit, Home_State>(
        builder: (context, state) {
          Home_Cubit controller = context.read<Home_Cubit>();
          HomeModel m = HomeModel(
              id: controller.newId.toString(),
              title: controller.title.toString(),
              body: controller.body.toString());
          return Scaffold(
            backgroundColor: controller.ScaffoldColor,
            appBar: AppBar(
              elevation: 0,
              foregroundColor: controller.AppBarColor,
              backgroundColor: controller.ScaffoldColor,
              title: Text(
                controller.titleName,
                style: TextStyle(
                  fontFamily: controller.noteFont,
                  fontSize: 22,
                ),
              ),
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back_ios_new,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
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
                        'Save',
                        style: TextStyle(
                          color: controller.AppBarColor,
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () async {
                        await controller.insert_note();
                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => home_screen()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Directionality(
                    textDirection:
                        ((controller.title.toString()).codeUnitAt(0) >= 65 &&
                                (controller.title.toString()).codeUnitAt(0) <=
                                    122)
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    child: TextFormField(
                      cursorColor: controller.AppBarColor,
                      controller: controller.title,
                      textAlign:
                          ((controller.title.toString()).codeUnitAt(0) >= 65 &&
                                  (controller.title.toString()).codeUnitAt(0) <=
                                      122)
                              ? TextAlign.left
                              : TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        color: controller.AppBarColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        fillColor: controller.AppBarColor,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            color: controller.HintColor, fontSize: 24),
                        hoverColor: controller.AppBarColor,
                        focusColor: controller.AppBarColor,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: TextFormField(
                        cursorColor: controller.AppBarColor,
                        controller: controller.body,
                        textDirection:
                            ((controller.body.toString()).codeUnitAt(0) >= 65 &&
                                    (controller.body.toString())
                                            .codeUnitAt(0) <=
                                        122)
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        textAlign:
                            ((controller.body.toString()).codeUnitAt(0) >= 65 &&
                                    (controller.body.toString())
                                            .codeUnitAt(0) <=
                                        122)
                                ? TextAlign.left
                                : TextAlign.right,
                        style: TextStyle(
                          color: controller.AppBarColor,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 5000,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Typing something...',
                          hintStyle: TextStyle(
                              color: controller.HintColor, fontSize: 22),
                          focusColor: controller.AppBarColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
