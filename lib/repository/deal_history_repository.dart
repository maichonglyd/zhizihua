import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as Path;

import 'db_helper.dart';

final String tableDealHistory = 'DealHistory';
final String columnKey = 'key';

class DealHistory {
  String key;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnKey: key,
    };
    return map;
  }

  DealHistory(this.key);

  DealHistory.fromMap(Map<String, dynamic> map) {
    key = map[columnKey];
  }
}

class DealHistoryRepo {
  static Future<DealHistory> insert(DealHistory dealHistory) async {
    await (await DbHelper.openDb())
        .insert(tableDealHistory, dealHistory.toMap());
    return dealHistory;
  }

//
  static Future<List<DealHistory>> getDealHistorys() async {
    List<Map> maps = await (await DbHelper.openDb())
        .rawQuery('''SELECT * FROM $tableDealHistory''');
    if (maps.length > 0) {
      return maps.map((map) {
        print(map);
        return DealHistory.fromMap(map);
      }).toList();
    }
    return List();
  }

//
  static Future delete() async {
    return await (await DbHelper.openDb())
        .execute('''DELETE FROM $tableDealHistory ''');
  }

  static Future close() async => (await DbHelper.openDb()).close();
}
