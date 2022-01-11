import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBProfile {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'profile.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE profile(id TEXT PRIMARY KEY,username TEXT,cardNumber INTEGER,image TEXT,holderName TEXT,balance INTEGER,income INTEGER)');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBProfile.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBProfile.database();
    return db.query(table);
  }
}
