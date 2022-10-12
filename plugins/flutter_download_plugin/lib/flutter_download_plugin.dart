import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FlutterDownloadPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_download_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> click() async {
    final String start = await _channel.invokeMethod('click');
    return start;
  }

  //开始一个任务  文件名/url
  static startTask(String fileName, String fileUrl, int gameId) {
    _channel.invokeMethod('start', {
      "fileName": fileName,
      "fileUrl": fileUrl,
      "gameId": gameId,
    });
    updateAll();
  }

  //暂停一个任务
  static pauseTask(String fileName, String fileUrl, int gameId) {
    _channel.invokeMethod('pause', {
      "fileName": fileName,
      "fileUrl": fileUrl,
      "gameId": gameId,
    });
    updateAll();
  }

  //移除一个任务
  static removeTask(String fileName, String fileUrl, int gameId) {
    _channel.invokeMethod('remove', {
      "fileName": fileName,
      "fileUrl": fileUrl,
      "gameId": gameId,
    });
    updateAll();
  }

  //查询状态
  static Future<int> getStatus(String fileName, String fileUrl) async {
    var status = await _channel.invokeMethod('getStatus', {
      "fileName": fileName,
      "fileUrl": fileUrl,
    });
    print("getstatus:" + status.toString());
    return status;
  }

  //安装
  static Future install(String fileName, String fileUrl) async {
    await _channel.invokeMethod('install', {
      "fileName": fileName,
      "fileUrl": fileUrl,
    });
    return;
  }

  static Future open(String packageName) async {
    bool isOpen = await _channel.invokeMethod('open', {
      "packageName": packageName,
    });
    return Future.value(isOpen);
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

class DownloadStatus {
  static const int INITIAL = 100; //初始状态
  static const int WAIT = 101; //等待
  static const int DOWNLOADING = 102; //下载中
  static const int PAUSE = 103; //暂停
  static const int INSTALL = 104; //等待安装,已完成
  static const int OPEN = 105; //已安装，打开
  static const int RETRY = 106; //重试
  static const int UPDATE = 107; //更新

}

abstract class DownloadListener {
  void warn();

  void connected();

  void retry();

  void started();

  void completed();

  void error();

  void canceled();

  void progress(currentOffset, totalLength);

  void update();

  int getGameId();
}

abstract class ReceiverListener {
  void installSuc(String packageName);

  void completed(int gameId, String packageName, int versionCode, String path);
}
