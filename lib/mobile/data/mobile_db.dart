import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseMobile {
  static Future<Database> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("DROP TABLE IF EXISTS Configuration");
      // When creating the db, create the table
      await db.execute(
        "CREATE TABLE Configuration (id INTEGER PRIMARY KEY, configName TEXT, configValue TEXT)",
      );
    });

    return database;
  }

  static Future<void> save(String stringJsonValue, String key) async {
    var db = await open();
    await db.delete('Configuration',
        where: 'configName =?', whereArgs: [key.toLowerCase()]);

    await db.insert(
      'Configuration',
      {'configName': key.toLowerCase(), 'configValue': stringJsonValue},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<dynamic>? getByKey(String key) async {
    var db = await open();
    var list = await db.rawQuery(
        'SELECT configValue FROM Configuration WHERE configName = ?',
        [key.toLowerCase()]);

    return list.isEmpty ? null : list.first.values.last;
  }

  static Future<void> delete(String key) async {
    final Database db = await open();
    await db.delete('Configuration',
        where: 'configName =?', whereArgs: [key.toLowerCase()]);
    // return true;
  }

  static Future<void> deleteLike(String key) async {
    final Database db = await open();
    await db.delete('Configuration',
        where: "configName LIKE ?", whereArgs: ['%${key.toLowerCase()}']);
    //   return true;
  }

  static Future<void> deleteAll() async {
    final Database db = await open();
    await db.delete('Configuration');
//    return true;
  }

  static Future<void> hasCacheExpired() async {
    var cacheTime = await getByKey('cache');
    DateTime currentTime = DateTime.now().add(const Duration(hours: -1));

    if (cacheTime != null) {
      DateTime currentCacheTime = DateTime.parse(cacheTime);
      if (currentTime.isBefore(currentCacheTime)) {
        await deleteLike('classifications');
        await deleteLike('matches');
        await deleteLike('red');
        await deleteLike('yellow');
        await deleteLike('topscorers');

        await save(currentTime.toIso8601String(), 'cache');
      }
    } else {
      await save(currentTime.toIso8601String(), 'cache');
    }
  }
}
