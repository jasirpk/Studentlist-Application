import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Data base conection
class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationCacheDirectory();
    var path = join(directory.path, 'dbcrud');
    var database =
        await openDatabase(path, version: 1, onCreate: creatDatabase);
    return database;
  }

  Future<void> creatDatabase(Database database, int version) async {
    String sql =
        "Create Table students(id INTEGER PRIMARY KEY,name TEXT,rollnumber TEXT,age TEXT, phonenumber TEXT,Imagepath TEXT)";
    await database.execute(sql);
  }
}
