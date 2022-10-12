import 'dart:convert';
import 'dart:core';

import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/down_sign_task_interface.dart';
import 'package:flutter_huoshu_app/repository/db_helper.dart';

class DownloadSignDb {
  static Future<DownSignModel> insertDownSign(
      DownSignModel downSignModel) async {
    downSignModel.id = await (await DbHelper.openDb())
        .insert(DownSignModel.TABLE_NAME, downSignModel.toMap());
    return downSignModel;
  }

  static Future<int> updateDownSign(DownSignModel downSignModel) async {
    return (await DbHelper.openDb()).update(
        DownSignModel.TABLE_NAME, downSignModel.toMap(),
        where: '"id" = ?', whereArgs: [downSignModel.id]);
  }

  static Future<bool> deleteDownSignModelByAppid(int appid) async {
    await (await DbHelper.openDb()).delete(DownSignModel.TABLE_NAME,
        where: '"appid" = ?', whereArgs: [appid]);
    return Future.value(true);
  }

  ///
  /// 获取所有的下载过的游戏
  static Future<List<Game>> getAllDownloadTaskToGameList() async {
    List<Map> maps = await (await DbHelper.openDb()).query(
        DownSignModel.TABLE_NAME,
        columns: [DownSignModel.EXT, DownSignModel.STATUS]);
    if (maps != null && maps.length > 0) {
      List<Game> gameList = maps.map((data) {
        var ext = data[DownSignModel.EXT];
        if (ext != null) {
          int status = data[DownSignModel.STATUS];
          DownSignExtData downSignExtData = DownSignExtData.fromJson(ext);
          return downSignExtData
              .toGame(status == DownSignTaskStatus.installed ? 1 : 0);
        } else {
          return null;
        }
      }).toList();
      gameList.removeWhere((element) => element == null);
      return Future.value(gameList);
    }
    return Future.value(List());
  }

  static Future<DownSignModel> getDownSignByAppid(int appid) async {
    List<Map> maps = await (await DbHelper.openDb()).query(
        DownSignModel.TABLE_NAME,
        columns: null,
        where: '"appid" = ?',
        whereArgs: [appid],
        limit: 1);
    if (maps != null && maps.length > 0) {
      return DownSignModel.fromMap(maps[0]);
    }
    return null;
  }

  static Future<DownSignTaskModel> insertDownSignTask(
      DownSignTaskModel downSignTaskModel) async {
    downSignTaskModel.id = await (await DbHelper.openDb())
        .insert(DownSignTaskModel.TABLE_NAME, downSignTaskModel.toMap());
    return downSignTaskModel;
  }

  static Future<int> updateDownSignTask(
      DownSignTaskModel downSignTaskModel) async {
    return (await DbHelper.openDb()).update(
        DownSignTaskModel.TABLE_NAME, downSignTaskModel.toMap(),
        where: '"id" = ?', whereArgs: [downSignTaskModel.id]);
  }

  static Future<List<DownSignTaskModel>> getDownSignTaskByAppid(
      int appid) async {
    List<Map> maps = await (await DbHelper.openDb()).query(
        DownSignTaskModel.TABLE_NAME,
        columns: null,
        where: '"appid" = ?',
        whereArgs: [appid]);
    if (maps.length > 0) {
      return maps.map((map) {
        return DownSignTaskModel.fromMap(map);
      }).toList();
    }
    return List();
  }

  static Future<DownSignTaskModel> getDownSignTaskByAppidAndTaskType(
      int appid, String taskType) async {
    List<Map> maps = await (await DbHelper.openDb()).query(
        DownSignTaskModel.TABLE_NAME,
        columns: null,
        where: '"appid" = ? and task_type=?',
        whereArgs: [appid, taskType],
        limit: 1);
    if (maps != null && maps.length > 0) {
      return DownSignTaskModel.fromMap(maps[0]);
    }
    return null;
  }

  static void deleteDownSignTaskByAppid(int appid) async {
    await (await DbHelper.openDb()).delete(DownSignTaskModel.TABLE_NAME,
        where: '"appid" = ?', whereArgs: [appid]);
  }
}
