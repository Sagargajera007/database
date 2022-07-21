import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{

  Future<Database> createDatabase()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    print(path);


    Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    'CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT)');
    });

    return database;
  }

}
