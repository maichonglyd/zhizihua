import 'dart:convert';

import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/down_sign_task_interface.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// 下载任务数据库模型
///

enum DownTypeEnum { apk, ipa }

class DownSignModel {
  int id;
  int appid;
  String url;
  String version = "1.0";
  int downType;
  DownSignExtData ext;
  bool onlyWifi = false;
  bool finishDel = false;
  String filePath;
  String installUrl;
  //状态
  int status = DownSignTaskStatus.initial;
  double progress = 0;
  bool userPause = false;
  bool isDelete = false;

  DownSignModel(this.appid, this.url, this.downType, this.ext);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ID: id,
      APP_ID: appid,
      URL: url,
      VERSION: version,
      DOWN_TYPE: downType,
      EXT: ext.toJsonString(),
      ONLY_WIFI: onlyWifi ? 1 : 0,
      FINISH_DEL: finishDel ? 1 : 0,
      STATUS: status,
      PROGRESS: "${progress}",
      USER_PAUSE: userPause ? 1 : 0,
      IS_DELETE: isDelete ? 1 : 0,
      FILE_PATH: filePath,
      INSTALL_URL: installUrl,
    };
    return map;
  }

  DownSignModel.fromMap(Map<String, dynamic> map) {
    id = map[ID];
    appid = map[APP_ID];
    url = map[URL];
    version = map[VERSION];
    downType = map[DOWN_TYPE];
    filePath = map[FILE_PATH];
    installUrl = map[INSTALL_URL];
    if (map.containsKey(EXT) && map[EXT] != null) {
      ext = DownSignExtData.fromJson(map[EXT]);
    }

    onlyWifi = map[ONLY_WIFI] == 1;
    finishDel = map[FINISH_DEL] == 1;
    status = map[STATUS];
    progress = double.parse(map[PROGRESS]);
    userPause = map[USER_PAUSE] == 1;
    isDelete = map[IS_DELETE] == 1;
  }

  static String getCretateSql() {
    return '''CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
      `${ID}` INTEGER PRIMARY KEY AUTOINCREMENT, 
      `${APP_ID}` INTEGER UNIQUE, 
      `${URL}` VARCHAR, 
      `${VERSION}` VARCHAR, 
      `${DOWN_TYPE}` INTEGER, 
      `${EXT}` TEXT, 
      `${ONLY_WIFI}` INTEGER, 
      `${FINISH_DEL}` INTEGER, 
      `${STATUS}` INTEGER, 
      `${PROGRESS}` VARCHAR, 
      `${USER_PAUSE}` INTEGER, 
      `${IS_DELETE}` INTEGER,
      `${FILE_PATH}` VARCHAR,
      `${INSTALL_URL}` VARCHAR
    )''';
  }

  static const TABLE_NAME = "tb_down_sign";

  static const String ID = "id"; //id
  static const String APP_ID = "appid"; //游戏id
  static const String VERSION = "version"; //游戏版本
  static const String FILE_PATH = "file_path"; //游戏版本
  static const String INSTALL_URL = "install_url"; //游戏版本
  static const String URL = "url";
  static const String DOWN_TYPE = "down_type";
  static const String EXT = "ext";
  static const String ONLY_WIFI = "only_wifi"; //下载时的网络类型仅仅是wifi
  static const String FINISH_DEL = "finish_del"; //下载时的网络类型仅仅是wifi
  static const String STATUS = "status"; //游戏名字
  static const String PROGRESS = "progress"; //游戏名字
  static const String IS_DELETE = "is_delete"; //游戏icon
  static const String USER_PAUSE = "user_pause"; //用户暂停

}

class DownSignTaskModel {
  int id;
  int pid;
  int appid;
  String taskType;
  List<int> dependendTaskIds = [];
  double curProgress = 0;
  double taskProgress;
  int status = DownSignTaskStatus.initial;
  String ext;

  Map<String, dynamic> toMap() {
    var tempIds;
    if (dependendTaskIds == null || dependendTaskIds.length == 0) {
      tempIds = "";
    } else {
      tempIds = dependendTaskIds.join(",");
    }

    var map = <String, dynamic>{
      ID: id,
      PID: pid,
      APP_ID: appid,
      TASK_TYPE: taskType,
      DEPENDEND_TASK_IDS: tempIds,
      CUR_PROGRESS: "${curProgress}",
      TASK_PROGRESS: "${taskProgress}",
      STATUS: status,
      EXT: ext,
    };
    return map;
  }

  DownSignTaskModel(this.pid, this.appid, this.taskType, this.taskProgress) {}

  DownSignTaskModel.asNew(this.pid, this.appid, this.taskProgress) {}

  DownSignTaskModel.fromMap(Map<String, dynamic> map) {
    id = map[ID];
    pid = map[PID];
    appid = map[APP_ID];
    taskType = map[TASK_TYPE];
    String temp = map[DEPENDEND_TASK_IDS];

    print("DownSignTaskModel DEPENDEND_TASK_IDS=${temp}");
    if (temp != null && temp.isNotEmpty) {
      dependendTaskIds = temp.split(",").map((value) {
        return int.parse(value);
      }).toList();
    } else {
      dependendTaskIds = [];
    }
    curProgress = double.parse(map[CUR_PROGRESS]);
    taskProgress = double.parse(map[TASK_PROGRESS]);
    status = map[STATUS];
    ext = map[EXT];
  }

  static String getCretateSql() {
    return '''CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
      `${ID}` INTEGER PRIMARY KEY AUTOINCREMENT, 
      `${PID}` INTEGER, 
      `${APP_ID}` INTEGER, 
      `${TASK_TYPE}` INTEGER, 
      `${DEPENDEND_TASK_IDS}` VARCHAR, 
      `${CUR_PROGRESS}` VARCHAR, 
      `${TASK_PROGRESS}` VARCHAR, 
      `${STATUS}` INTEGER, 
      `${EXT}` TEXT
    )''';
  }

  static const TABLE_NAME = "tb_down_sign_task";

  static const String ID = "id"; //id
  static const String PID = "pid"; //id
  static const String APP_ID = "appid"; //游戏id
  static const String TASK_TYPE = "task_type"; //游戏版本
  static const String DEPENDEND_TASK_IDS = "dependend_task_ids";
  static const String CUR_PROGRESS = "cur_progress";
  static const String TASK_PROGRESS = "task_progress";
  static const String STATUS = "status";
  static const String EXT = "ext";
}

class DownSignExtData {
  int gameId;
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
  String downcnt; //游戏下载次数
  int speed;

  DownSignExtData.fromJson(String data) {
    try {
      var map = json.decode(data);
      gameId = map[GAME_ID];
      gameSize = map[GAME_SIZE];
      gameName = map[GAME_NAME];
      gameIcon = map[GAME_ICON];
      packageName = map[PACKAGE_NAME];
      gameType = map[GAME_TYPE];
      oneWord = map[GAME_ONE_WORD];
      tags = map[GAME_TAGS];
      isBt = map[GAME_IS_BT];
      rate = map[GAME_DISCOUNT_RATE];
      clientId = map[GAME_CLIENT_ID];
    } catch (e, t) {
      print(e);
    }
  }
  DownSignExtData();

  DownSignExtData.fromGame(Game game) {
    DownSignExtData downloadTask = DownSignExtData();
    gameId = game.gameId;
    gameSize = game.size;
    gameName = game.gameName;
    packageName = game.packageName;
    gameIcon = game.icon;
    gameType = json.encode(game.type).toString();
    oneWord = game.oneWord;
    tags = json.encode(game.tagsArr).toString();
    isBt = game.isBt;
    rate = game.rate;
    clientId = game.clientId;
  }

  Game toGame(int installed) {
    Game game = new Game();
    game.gameId = gameId;
    game.size = gameSize;
    game.gameName = gameName;
    game.packageName = packageName;
    game.icon = gameIcon;
    if (gameType != null) {
      game.type = (json.decode(gameType) as List)
          .map((type) => type as String)
          .toList();
    }
    game.oneWord = oneWord;
    if (tags != null) {
      game.tagsArr =
          (json.decode(tags) as List).map((type) => type as String).toList();
    }
    game.isBt = isBt;
    game.rate = rate;
    game.clientId = clientId;
    game.install = installed;
    return game;
  }

  String toJsonString() {
    var map = <String, dynamic>{
      GAME_ID: gameId,
      GAME_SIZE: gameSize,
      GAME_NAME: gameName,
      GAME_ICON: gameIcon,
      PACKAGE_NAME: packageName,
      GAME_TYPE: gameType,
      GAME_ONE_WORD: oneWord,
      GAME_TAGS: tags,
      GAME_IS_BT: isBt,
      GAME_DISCOUNT_RATE: rate,
      GAME_CLIENT_ID: clientId,
    };
    return json.encode(map);
  }

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
}
