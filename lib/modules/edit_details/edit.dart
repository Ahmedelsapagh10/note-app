import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/modules/add_details/provider/model.dart';
import 'package:note_pad/modules/home/controller/cubit.dart';
import 'package:note_pad/modules/home/controller/state.dart';
import 'package:note_pad/modules/home/view/home.dart';

class editScreen extends StatelessWidget {
  const editScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Home_Cubit(),
      child: BlocBuilder<Home_Cubit, Home_State>(
        builder: (context, state) {
          Home_Cubit controller = context.read<Home_Cubit>();
          return Scaffold(
            backgroundColor: Color.fromARGB(221, 34, 33, 33),
            appBar: AppBar(
              centerTitle: true,
              foregroundColor: Color.fromARGB(255, 240, 216, 3),
              backgroundColor: Colors.black,
              title: const Text(
                'Edit',
                style: TextStyle(
                    fontSize: 22, color: Color.fromARGB(255, 240, 216, 3)),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      await controller.updateNotes();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => home_screen()));
                    },
                    // ignore: prefer_const_constructors
                    child: Icon(
                      Icons.done,
                      size: 28,
                      color: Color.fromARGB(255, 240, 216, 3),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Color.fromARGB(255, 240, 216, 3),
                    controller: controller.Edit_title,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 240, 216, 3),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(255, 240, 216, 3),
                      hintText: 'title',
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 240, 216, 3),
                        controller: controller.Edit_body,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 240, 216, 3),
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                        textDirection: TextDirection.ltr,
                        autocorrect: true,
                        enableSuggestions: true,
                        maxLines: 5000,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'note',
                          focusColor: Color.fromARGB(255, 240, 216, 3),
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
