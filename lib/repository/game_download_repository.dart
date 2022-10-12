import 'dart:convert';
import 'dart:core';

import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:sqflite/sqlite_api.dart';

import 'db_helper.dart';

class DownloadTask {
  static const String ID = "id"; //id
  static const String GAME_ID = "gameId"; //游戏id
  static const String GAME_SIZE = "gameSize"; //游戏大小
  static const String URL = "url";
  static const String PATH = "path";
  static const String GAME_NAME = "gameName"; //游戏名字
  static const String GAME_ICON = "gameIcon"; //游戏icon
  static const String PACKAGE_NAME = "packageName"; //包名
  static const String ONLY_WIFI = "onlyWifi"; //下载时的网络类型仅仅是wifi
  static const String USER_PAUSE = "userPause"; //用户暂停
  static const String INSTALLED = "installed"; //用户从这个平台安装过
  static const String GAME_TYPE = "gameType"; //游戏类型标签
  static const String GAME_ONE_WORD = "one_word"; //
  static const String GAME_TAGS = "tags";
  static const String GAME_IS_BT = "is_bt"; //是否BT 2 BT 1 其他
  static const String GAME_DISCOUNT_RATE = "discount_rate";
  static const String GAME_CLIENT_ID = "game_client_id"; //clientID 用来标志是否更新

  int id;
  int gameId;
  String url;
  String path;
  String gameName;
  String gameIcon;
  String gameSize;
  String packageName;
  String gameType;
  String oneWord;
  String tags; //json
  int isBt;
  num rate;
  int clientId;
  int onlyWifi = 1; //默认只使用wifi下载
  int userPause = 0; //是否是用户暂停
  int installed = 0; //是否从这个盒子中安装过

  String downcnt; //游戏下载次数
  int speed;

  String key;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ID: id,
      GAME_ID: gameId,
      GAME_SIZE: gameSize,
      URL: url,
      PATH: path,
      GAME_NAME: gameName,
      GAME_ICON: gameIcon,
      PACKAGE_NAME: packageName,
      ONLY_WIFI: onlyWifi,
      USER_PAUSE: userPause,
      INSTALLED: installed,
      GAME_TYPE: gameType,
      GAME_ONE_WORD: oneWord,
      GAME_TAGS: tags,
      GAME_IS_BT: isBt,
      GAME_DISCOUNT_RATE: rate,
      GAME_CLIENT_ID: clientId,
    };
    return map;
  }

  DownloadTask();

  DownloadTask.fromMap(Map<String, dynamic> map) {
    print("单个下载数据" + map.toString());
    id = map[ID];
    gameId = map[GAME_ID];
    gameSize = map[GAME_SIZE];
    url = map[URL];
    path = map[PATH];
    gameName = map[GAME_NAME];
    gameIcon = map[GAME_ICON];
    packageName = map[PACKAGE_NAME];
    onlyWifi = map[ONLY_WIFI];
    userPause = map[USER_PAUSE];
    installed = map[INSTALLED];
    gameType = map[GAME_TYPE];
    oneWord = map[GAME_ONE_WORD];
    tags = map[GAME_TAGS];
    isBt = map[GAME_IS_BT];
    rate = map[GAME_DISCOUNT_RATE];
    clientId = map[GAME_CLIENT_ID];
  }

  static Future<DownloadTask> insert(DownloadTask downloadTask) async {
    print("插入数据" + downloadTask.packageName + downloadTask.toMap().toString());
    await (await DbHelper.openDb())
        .insert(tableDownLoadGames, downloadTask.toMap());
    return downloadTask;
  }

  static Future<List<Game>> getAllDownloadTask() async {
    List<Map> maps = await (await DbHelper.openDb())
        .rawQuery('''SELECT * FROM $tableDownLoadGames''');
    if (maps.length > 0) {
      return maps
          .map((map) {
            print("下载数据" + map.length.toString() + map.toString());
            return DownloadTask.fromMap(map);
          })
          .toList()
          .map((task) => downloadTaskToGame(task))
          .toList();
    }
    return List();
  }

  static Future deleteTaskByGame(Game game) async {
    return await (await DbHelper.openDb()).rawDelete(
        'DELETE FROM $tableDownLoadGames WHERE id = ?', [game.gameId]);
  }

  static Future deleteTaskByGameId(int gameId) async {
    return await (await DbHelper.openDb())
        .rawDelete('DELETE FROM $tableDownLoadGames WHERE id = ?', [gameId]);
  }

  static Future<List<Game>> getDownLoadTaskById(int gameId) async {
    List<Map> maps = await (await DbHelper.openDb())
        .rawQuery('''SELECT * FROM $tableDownLoadGames WHERE id = $gameId''');
    if (maps.length > 0) {
      return maps
          .map((map) {
            print(map);
            return DownloadTask.fromMap(map);
          })
          .toList()
          .map((task) => downloadTaskToGame(task))
          .toList();
    }
    return List();
  }

  ///查询task状态
  static Future<int> queryStatus(int gameId) async {
    List<Game> games = await DownloadTask.getDownLoadTaskById(gameId);
    if (games.length > 0) {
      if (games[0].install == 1) {
        return DownloadStatus.OPEN;
      }
      return FlutterDownloadPlugin.getStatus(
          games[0].gameName + ".apk", games[0].downUrl, games[0]);
    } else {
      return DownloadStatus.INITIAL;
    }
  }

  static Future<int> updateDownLoadTaskPackageNameAndPath(
      int gameId, String packageName, String path) async {
    return (await DbHelper.openDb()).rawUpdate(
        '''UPDATE $tableDownLoadGames SET packageName = '$packageName',path = '$path' WHERE id = $gameId''');
  }

  static Future<int> updateDownLoadTaskInstall(
      String packageName, int install) async {
    return (await DbHelper.openDb()).rawUpdate(
        '''UPDATE $tableDownLoadGames SET installed = $install WHERE packageName = '$packageName' ''');
  }

  static Future<String> getFilePathByPackageName(String packageName) async {
    List<Map> maps = await (await DbHelper.openDb()).rawQuery(
        '''SELECT path FROM $tableDownLoadGames WHERE packageName = '$packageName' ''');
    if (maps != null && maps.length != 0) {
      return Future.value(maps.elementAt(0)['path']);
    }
    return Future.value("");
  }

  static Future<List<Game>> getDownLoadTaskByPackageName(
      String packageName) async {
    List<Map> maps = await (await DbHelper.openDb()).rawQuery(
        '''SELECT * FROM $tableDownLoadGames WHERE packageName = '$packageName' ''');
    if (maps.length > 0) {
      return maps
          .map((map) {
            print(map);
            return DownloadTask.fromMap(map);
          })
          .toList()
          .map((task) => downloadTaskToGame(task))
          .toList();
    }
    return List();
  }

  static DownloadTask gameToDownloadTask(Game game, String url, String path) {
    DownloadTask downloadTask = DownloadTask();
    downloadTask.id = game.gameId;
    downloadTask.gameId = game.gameId;
    downloadTask.gameSize = game.size;
    downloadTask.url = url;
    downloadTask.path = path;
    downloadTask.gameName = game.gameName;
    downloadTask.packageName = game.packageName;
    downloadTask.gameIcon = game.icon;
    downloadTask.gameType = json.encode(game.type).toString();
    downloadTask.oneWord = game.oneWord;
    downloadTask.tags = json.encode(game.tagsArr).toString();
    downloadTask.isBt = game.isBt;
    downloadTask.rate = game.rate;
    downloadTask.clientId = game.clientId;
    return downloadTask;
  }

  static Game downloadTaskToGame(DownloadTask downloadTask) {
    Game game = new Game();
    game.gameId = downloadTask.gameId;
    game.size = downloadTask.gameSize;
    game.downUrl = downloadTask.url;
    game.gameName = downloadTask.gameName;
    game.packageName = downloadTask.packageName;
    game.icon = downloadTask.gameIcon;
    if (downloadTask.gameType != null) {
      game.type = (json.decode(downloadTask.gameType) as List)
          .map((type) => type as String)
          .toList();
    }
    game.oneWord = downloadTask.oneWord;
    if (downloadTask.tags != null) {
      game.tagsArr = (json.decode(downloadTask.tags) as List)
          .map((type) => type as String)
          .toList();
    }
    game.isBt = downloadTask.isBt;
    game.rate = downloadTask.rate;
    game.clientId = downloadTask.clientId;
    game.install = downloadTask.installed;
    return game;
  }
}
