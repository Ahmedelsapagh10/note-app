import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  late Database db;
  init() async {
    String dbs_path = await getDatabasesPath();
    String mydb = 'note_pad.db';
    String db_path = join(dbs_path, mydb);

    db = await openDatabase(db_path, version: 1, onCreate: (db, version) {
      db.execute('Create table note('
          'id integer primary key autoincrement,'
          'title text,'
          'body text'
          ')');
    });
  }

  Future<List<Map>> read_from_database() async {
    await init();
    return await db.query('note');
  }

  insert_to_database({String title = "title", String body = 'type'}) async {
    await init();
    await db.insert('note', {'title': title, 'body': body});
    await db.close();
  }

  delete_from_database(int id) async {
    await init();
    await db.delete('note', where: 'id=?', whereArgs: [id]);
    await db.close();
  }

  update_to_database(int id, String t, String b) async {
    await init();
    await db.update('note', {'title': t, 'body': b},
        where: 'id=?', whereArgs: [id]);
    await db.close();
  }
}
