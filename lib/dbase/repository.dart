import 'package:project2/dbase/dbaseclass.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection databaseConnection;
  Repository() {
    databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await databaseConnection.setDatabase();
      return database;
    }
  }

// Insert student
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

// Read All Data...!
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

// Read Single Record By Id...!
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(
      table,
      where: 'id=?',
      whereArgs: [itemId],
    );
  }

  // Update student..!
  updataData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

// Delete student Detial...!
  deleteDataById(table, itemId) async {
    var connection = await database;
    connection?.delete(table);
    return await connection?.rawDelete('Delete from $table where id=$itemId');
  }
}
