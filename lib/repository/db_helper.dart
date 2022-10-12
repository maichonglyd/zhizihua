import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import 'game_download_repository.dart';

final String tableDealHistory = 'DealHistory';
final String tableGameHistory = 'GameHistory';
final String tableDownLoadGames = 'DownLoadGames';

final String columnKey = 'key';

class DbHelper {
  static Database db;

  static Future<Database> openDb() async {
    if (db != null) {
      return Future.value(db);
    }
    var databasesPath = await getDatabasesPath();
    String path = Path.join(databasesPath, 'huo_bt_app.db');
    print("db:" + path);
    db = await openDatabase(path, version: 11,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS $tableDealHistory ( $columnKey text not null,UNIQUE ($columnKey))''');
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS $tableGameHistory ( $columnKey text not null,UNIQUE ($columnKey))''');
      await db.execute("CREATE TABLE IF NOT EXISTS " +
          tableDownLoadGames +
          "(" +
          "${DownloadTask.ID}  INTEGER PRIMARY KEY, " // id, download id
          +
          "${DownloadTask.URL} VARCHAR, " // url
          +
          "${DownloadTask.PATH} VARCHAR, " // path
          +
          "${DownloadTask.GAME_ID} INTEGER UNIQUE, " // gameId
          +
          "${DownloadTask.GAME_NAME} VARCHAR, " // gameName
          +
          "${DownloadTask.GAME_ICON} VARCHAR, " // gameIcon
          +
          "${DownloadTask.GAME_SIZE} VARCHAR, " // gameSize
          +
          "${DownloadTask.PACKAGE_NAME} VARCHAR ," // packageName
          +
          "${DownloadTask.ONLY_WIFI} INTEGER ," // onlyWifi
          +
          "${DownloadTask.USER_PAUSE} INTEGER ," // userPause
          +
          "${DownloadTask.INSTALLED} INTEGER ," // installed
          +
          "${DownloadTask.GAME_TYPE} VARCHAR ," // gameType
          +
          "${DownloadTask.GAME_ONE_WORD} VARCHAR ," //GAME_ONE_WORD
          +
          "${DownloadTask.GAME_TAGS} VARCHAR ," //TAGS
          +
          "${DownloadTask.GAME_IS_BT} INTEGER ," //isbt
          +
          "${DownloadTask.GAME_DISCOUNT_RATE} FLOAT ," //RATE
          +
          "${DownloadTask.GAME_CLIENT_ID} INTEGER" //clientId
          +
          ")");
      await db.execute(DownSignModel.getCretateSql());
      await db.execute(DownSignTaskModel.getCretateSql());
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //创建下载用的数据库
      await db.execute(DownSignModel.getCretateSql());
      await db.execute(DownSignTaskModel.getCretateSql());
      print("执行了创建数据库");
    });
    print("db init success! path=:$db");
    return Future.value(db);
  }
}
