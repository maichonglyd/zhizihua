import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/plugin/download_ios_impl.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';

class DownloadIosPlugin {
  static Future<String> click() async {
//    final String start = await _channel.invokeMethod('click');
    return "start";
  }

  //开始一个任务  文件名/url
  static startTask(String fileName, String fileUrl, int gameId) {
    DownloadIosImpl.startTask(fileName, fileUrl, gameId);

//    _channel.invokeMethod('start', {
//      "fileName": fileName,
//      "fileUrl": fileUrl,
//      "gameId": gameId,
//    });
//    updateAll();
  }

  //暂停一个任务
  static pauseTask(String fileName, String fileUrl, int gameId) {
//    _channel.invokeMethod('pause', {
//      "fileName": fileName,
//      "fileUrl": fileUrl,
//      "gameId": gameId,
//    });
//    updateAll();
  }

  //移除一个任务
  static removeTask(String fileName, String fileUrl, int gameId) {
//    _channel.invokeMethod('remove', {
//      "fileName": fileName,
//      "fileUrl": fileUrl,
//      "gameId": gameId,
//    });
//    updateAll();
  }

  //查询状态
  static Future<int> getStatus(
      String fileName, String fileUrl, Game game) async {
    return DownloadIosImpl.getStatus(fileName, fileUrl, game);
  }

  //安装
  static Future install(String fileName, String fileUrl) async {
//    await _channel.invokeMethod('install', {
//      "fileName": fileName,
//      "fileUrl": fileUrl,
//    });
    return;
  }

  static Future open(String packageName) async {
//    bool isOpen = await _channel.invokeMethod('open', {
//      "packageName": packageName,
//    });
    return Future.value(true);
  }

  static void updateAll() {
    for (DownloadListener callback in callbacks) {
      callback.update();
    }
  }

  static void updateGameStatus(int gameId) {
    for (DownloadListener callback in callbacks) {
      if (callback.getGameId() == gameId) {
        callback.update();
      }
    }
  }

  static const platform = const MethodChannel('huosdk/downloader');
  static List<DownloadListener> callbacks = List();
  static ReceiverListener receiverListener;

  static registerCallback(DownloadListener callback) {
    if (callback != null) {
      // remove previous setting
      print("registerCallback:callbacks.lengt:${callbacks.length}");
      print("registerCallback:callbacks:$callbacks");
      if (!callbacks.contains(callback)) {
        callbacks.add(callback);
      }
    }
  }

  static unRegisterCallback(DownloadListener callback) {
    if (callback != null) {
      // remove previous setting
      print("unRegisterCallback:callbacks.lengt:$callbacks");
      callbacks.remove(callback);
    }
  }

  //初始化  加入一个全局监听的
  static init(ReceiverListener listener) {
    initCallBack();
    receiverListener = listener;
  }

  static initCallBack() {
    platform.setMethodCallHandler(null);
    platform.setMethodCallHandler((MethodCall call) {
      if (call.method == "installSuc") {
        var packageName = call.arguments['packageName'];
        receiverListener.installSuc(packageName);
        return null;
      }

      if (call.method == "globalCompleted") {
        print("globalCompleted");
        var packageName = call.arguments['packageName'];
        print("globalCompleted1 packageName:$packageName");
        var gameId = call.arguments['gameId'];
        print("globalCompleted2 gameId:$gameId");
        var path = call.arguments['path'];
        var versionCode = call.arguments['versionCode'];
        print("globalCompleted3：path:$path");
        receiverListener.completed(gameId, packageName, versionCode, path);
        print("globalCompleted4");
        return null;
      }

      for (DownloadListener callback in callbacks) {
        var gameId = call.arguments['gameId'];
        if (gameId == callback.getGameId()) {
          switch (call.method) {
            case "progress":
              var process = call.arguments['progress'];
              var totalLength = call.arguments['totalLength'];
              callback.progress(process, totalLength);
              break;
            case "completed":
              callback.completed();
              break;
            case "error":
              callback.error();
              break;
          }
        }
      }
      return null;
    });
  }
}
