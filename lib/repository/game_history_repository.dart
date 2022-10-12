import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as Path;

import 'db_helper.dart';

final String tableGameHistory = 'GameHistory';
final String columnKey = 'key';

class GameHistory {
  String key;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnKey: key,
    };
    return map;
  }

  GameHistory(this.key);

  GameHistory.fromMap(Map<String, dynamic> map) {
    key = map[columnKey];
  }
}

class GameHistoryRepo {
  static Future<GameHistory> insert(GameHistory gameHistory) async {
    await (await DbHelper.openDb())
        .insert(tableGameHistory, gameHistory.toMap());
    return gameHistory;
  }

//
  static Future<List<GameHistory>> getGameHistorys() async {
    List<Map> maps = await (await DbHelper.openDb())
        .rawQuery('''SELECT * FROM $tableGameHistory''');
    if (maps.length > 0) {
      return maps.map((map) {
        print(map);
        return GameHistory.fromMap(map);
      }).toList();
    }
    return List();
  }

//
  static Future delete() async {
    return await (await DbHelper.openDb())
        .execute('''DELETE FROM $tableGameHistory ''');
  }

  static Future close() async => (await DbHelper.openDb()).close();
}
