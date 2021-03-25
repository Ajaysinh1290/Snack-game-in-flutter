import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:snack_game/database/database_constants.dart';
import 'package:snack_game/database/game_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ScoreDb {

  static Future<int> insert(Map<String, dynamic> row) async {
    Database db = await GameDatabase.instance.database;
    return await db.insert(DataBaseConstants.scoreTable, row);
  }
  static Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await GameDatabase.instance.database;
    return await db.query(DataBaseConstants.scoreTable);
  }

}
