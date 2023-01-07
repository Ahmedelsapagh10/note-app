import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/modules/add_details/provider/database.dart';
import 'package:note_pad/modules/add_details/provider/model.dart';
import 'package:note_pad/modules/home/controller/state.dart';

class Home_Cubit extends Cubit<Home_State> {
  Home_Cubit() : super(home_mode_1()) {
    read_data();
  }
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController Edit_title = TextEditingController();
  TextEditingController Edit_body = TextEditingController();
  MyDatabase db = MyDatabase();
  List<HomeModel> noteTitle = [];

  read_data() async {
    noteTitle = (await db.read_from_database())
        .map((e) => HomeModel(
            id: e['id'].toString(), title: e['title'], body: e['body']))
        .toList();

    emit(home_mode());
  }

  insert_note() async {
    await db.insert_to_database(title: title.text, body: body.text);
    await read_data();
    emit(home_mode_2());
  }

  deleteFormDB(HomeModel h) async {
    await db.delete_from_database(int.parse(h.id));
    await noteTitle.remove(h);
    emit(home_mode_3());
  }

  String titleName = 'Add';
  bool whatMode = false;
  String newId = '-1';
  Future<void> onTabToEdit(HomeModel h) async {
    Edit_title.text = h.title;
    Edit_body.text = h.body;
    whatMode = true;
    newId = h.id;
    emit(home_mode_4());
  }

  updateNotes() async {
    await db.update_to_database(
        int.parse(newId), Edit_title.text, Edit_body.text);
    await read_data();
    newId = '-1';
    whatMode = false;

    emit(home_mode_4());
  }

  IconData myIcon = Icons.save;

  Color ScaffoldColor = Color.fromARGB(255, 20, 30, 39);
  Color ButtonColor = Color.fromARGB(255, 32, 50, 57);

  Color AppBarColor = Color.fromARGB(255, 238, 237, 222);
  Color HintColor = Color.fromARGB(255, 109, 108, 108);

  Color ContainerColor = Color.fromARGB(255, 226, 220, 200);
  Color TextColor = Color.fromARGB(255, 20, 30, 39);

  String titleFont = "Tajawal-Bold";
  String noteFont = "TitilliumWeb";

  IconData mode = CupertinoIcons.lightbulb;
  bool modeState = true;

  changeMode() {
    // if (modeState == true) {
    //   ScaffoldColor = Color.fromARGB(255, 255, 118, 143);
    //   AppBarColor = Color.fromARGB(255, 5, 153, 133);
    //   ButtonColor = Color.fromARGB(255, 214, 8, 187);
    //   HintColor = Color.fromARGB(255, 78, 8, 241);
    //   ContainerColor = Color.fromARGB(255, 9, 221, 2);
    //   TextColor = Color.fromARGB(255, 1, 121, 51);
    //   mode = CupertinoIcons.moon;
    //   modeState = false;
    //   emit(home_mode_5());
    // } else {
    // ScaffoldColor = Color.fromARGB(255, 37, 37, 37);
    // AppBarColor = Color.fromARGB(255, 255, 255, 255);
    // ButtonColor = Color.fromARGB(255, 59, 59, 59);
    // HintColor = Color.fromARGB(255, 109, 108, 108);
    // ContainerColor = Color.fromARGB(255, 2, 196, 221);
    // TextColor = Color.fromARGB(255, 0, 0, 0);
    // mode = CupertinoIcons.lightbulb;
    // modeState = true;
    // emit(home_mode_6());
    //  }
  }
}
