import 'dart:io';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/main.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/down/flutter_downloader_helper.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/down_sign_task_interface.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/download_file_task.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/main_task.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/download_sign_repository.dart';
import 'model/download_sign_task_model.dart';

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// 下载签名管理器
///
typedef DownSignTaskNext = dynamic Function(DownSignModel model);

class DownloadSignManager {
  ///提供注册任务监听的功能
  static List<DownloadSignListener> listenerList = [];
  static Map<int, MainTask> _mainTaskMap = {};

  static String defaultDownPath = null;
  static String defaultIpaSignPath = null;

  static void init() async {
    if (Platform.isIOS) {
      print("DownloadSignManager init");
      FlutterDownloaderHelper.initialize();
      getDefaultDownPath();
    }
  }

  static Future<String> getDefaultDownPath() async {
    if (defaultDownPath == null) {
      var directory = await getApplicationDocumentsDirectory();
      directory = Directory(directory.path + "/iosdown");
      directory.createSync(recursive: true);
      defaultDownPath = directory.path;
    }
    return defaultDownPath;
  }

  static Future<String> getDefaultIpaSignPath() async {
    if (defaultIpaSignPath == null) {
      var directory = await getApplicationDocumentsDirectory();
      directory = Directory(directory.path + "/ipasign");
      directory.createSync(recursive: true);
      defaultIpaSignPath = directory.path;
    }
    return defaultIpaSignPath;
  }

  /// 添加监听，添加完成后，立马会回调一次状态信息
  static Future<DownSignModel> addListener(
      DownloadSignListener downloadListener) async {
    listenerList.add(downloadListener);
    return queryStatus(downloadListener.onGetGameId());
  }

  static void removeListener(DownloadSignListener downloadListener) {
    listenerList.remove(downloadListener);
  }

  static launchURL(String url) async {
    print("准备打开的游戏地址为：" + url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  /// 提供点击事件处理的功能
  static void click(Game game, int clickId) async {
    MainTask mainTask = null;
    if (_mainTaskMap.containsKey(game.gameId)) {
      mainTask = _mainTaskMap[game.gameId];
    }
    if (mainTask != null &&
        mainTask.gameModel.status != DownSignTaskStatus.error) {
      if (mainTask.listener == null) {
        mainTask.listener = MainTaskListener(game.gameId);
      }
      HuoLog.d("下载过，并且状态为${mainTask.gameModel.status}");
      _nextStep(mainTask, game, clickId);
      return;
    }

    //任务还不存在，需要从数据库中恢复
    //任务处于错误状态，可能需要更新url
    //重新联网，查看下载地址是否有改动，
    GameService.getDownUrl(game.gameId,
            udid: DeviceInfoUtil.deviceBean.udid,
            isShowToast: false,
            local_sign: true)
        .then((data) async {
      if (data["data"]["down_url"] == null ||
          data["data"]["down_url"].isEmpty) {
        showToast(getText(name: 'toastDownloadAddressNotNull'));
        return;
      }

      HuoLog.d("游戏下载地址为${data["data"]["down_url"]}");
      if (data["data"]["is_web"] != null &&
          data["data"]["is_web"].toString() == "2") {
        try {
          String downUrl = data["data"]["down_url"];
          HuoLog.d("downUrl = $downUrl");
          launch(downUrl);
        } catch (e) {
          print(e);
        }
        return;
      }

      DownSignModel downSignModel = DownSignModel(
          game.gameId,
          data["data"]["down_url"],
          Platform.isIOS ? DownTypeEnum.ipa.index : DownTypeEnum.apk.index,
          DownSignExtData.fromGame(game));

      //获取状态，根据状态进行相应处理
      DownSignModel dbDownSignModel =
          await DownloadSignDb.getDownSignByAppid(game.gameId);
      //没有下载过,进行下载
      if (dbDownSignModel == null) {
        await _startDownSignTask(downSignModel, clickId);
      } else {
        //重新添加到记录中
        dbDownSignModel.url = downSignModel.url;
        MainTask mainTask = MainTask(dbDownSignModel, clickId);
        _mainTaskMap[game.gameId] = mainTask;
      }
      if (_mainTaskMap.containsKey(game.gameId)) {
        if (_mainTaskMap[game.gameId].listener == null) {
          _mainTaskMap[game.gameId].listener = MainTaskListener(game.gameId);
        }
        _nextStep(_mainTaskMap[game.gameId], game, clickId);
      }
    });
  }

  static void notifyIosStartInstall(String uri) {
    if (uri != null) {
      var appid = null;
      _mainTaskMap.forEach((key, value) {
        if (value.gameModel.filePath.endsWith(uri)) {
          value.gameModel.status = DownSignTaskStatus.installed;
          _notifyStatus(value.gameModel.appid);
          appid = value.gameModel.appid;
        }
      });
      if (appid != null) {
        DownloadSignDb.getDownSignByAppid(appid).then((value) {
          if (value != null) {
            value.status = DownSignTaskStatus.installed;
            DownloadSignDb.updateDownSign(value);
          }
        });
      }
    }
  }

  ///删除任务，需要暂停并且删除数据
  static Future<bool> deleteDownSignTaskByAppid(int appid) async {
    if (_mainTaskMap.containsKey(appid)) {
      _mainTaskMap[appid].pause();
      _mainTaskMap.remove(appid);
    }
    DownSignTaskModel taskModel =
        await DownloadSignDb.getDownSignTaskByAppidAndTaskType(
            appid, DownloadFileTask.DOWNLOAD_TASK_TYPE);
    if (taskModel != null && taskModel.ext != null) {
      FlutterDownloader.remove(taskId: taskModel.ext);
    }
    DownSignModel downSignModel =
        await DownloadSignDb.getDownSignByAppid(appid);
    if (downSignModel != null && downSignModel.filePath != null) {
      File(downSignModel.filePath).delete();
    }
    await DownloadSignDb.deleteDownSignTaskByAppid(appid);
    await DownloadSignDb.deleteDownSignModelByAppid(appid);
    _notifyStatus(appid);
    return Future.value(true);
  }

  static void _nextStep(MainTask mainTask, Game game, int clickId) {
    //进行状态判断
    var status = mainTask.gameModel.status;
    switch (status) {
      case DownSignTaskStatus.running:
      case DownSignTaskStatus.enqueued:
      case DownSignTaskStatus.wait:
        mainTask.pause();
        break;
      case DownSignTaskStatus.pause:
      case DownSignTaskStatus.error:
      case DownSignTaskStatus.initial:
        mainTask.run();
        break;
      case DownSignTaskStatus.success:
        //安装，判断是否可以安装，如果不可以安装，则重新下载

        if (Platform.isAndroid) {
          //todo by liuhongliang 判断是否已经安装在手机上了，安装了，则状态该为打开

        }

        File installFile = File(mainTask.gameModel.filePath);
        if (!installFile.existsSync()) {
          deleteDownSignTaskByAppid(game.gameId);
          showToast(getText(name: 'toastPleaseInstallAgain'));
          return;
        }
        print("进来了：准备安装");
        if (Platform.isIOS) {
//          deleteDownSignTaskByAppid(game.gameId);
//          showToast("调试，请重新下载");
//          return;
          DownloadSignManager.launchURL(mainTask.gameModel.installUrl);
        } else {
          //todo 安卓安装apk
        }
        break;
      case DownSignTaskStatus.installed:
        //打开，判断是否已经安装，已经安装的打开，否则，重新下载
        if (Platform.isIOS) {
          //ios 只能重新下载
          deleteDownSignTaskByAppid(game.gameId);
          click(game, clickId);
        }
        break;
    }
    if (mainTask.gameModel != null) {
      _notifyStatus(mainTask.gameModel.appid);
    }
  }

  ///通知状态
  static void _notifyStatus(int appid) {
    for (var value in listenerList) {
      if (value.onGetGameId() == appid) {
        switch (_mainTaskMap[appid].gameModel.status) {
          case DownSignTaskStatus.error:
            value.onError();
            break;
          case DownSignTaskStatus.success:
            value.onCompleted();
            break;
          case DownSignTaskStatus.wait:
          case DownSignTaskStatus.running:
            value.onProgress(_mainTaskMap[appid].gameModel.progress, null);
            break;
          case DownSignTaskStatus.pause:
            value.onPause(null);
            break;
          case DownSignTaskStatus.installed:
            value.onInstalled();
            break;
        }
      }
    }
  }

  ///启动下载签名任务
  static void _startDownSignTask(DownSignModel gameModel, int clickId) async {
    //开启一个异步线程开始做任务
    //插入数据库
    try {
      gameModel = await DownloadSignDb.insertDownSign(gameModel);
      if (gameModel.id != null) {
        MainTask mainTask = MainTask(gameModel, clickId);
        _mainTaskMap[gameModel.appid] = mainTask;
        return;
      }
    } catch (e) {
      print(e);
    }
    //失败了
    if (gameModel.id == null) {
      for (var value in listenerList) {
        if (value.onGetGameId() == gameModel.appid) {
          value.onError();
        }
      }
    }
  }

  ///提供获取下载的任务功能
  static bool getDownSignTaskList() {}

  ///提供根据appid查询状态的功能

  static Future<DownSignModel> queryStatus(int appid) async {
    //下载框架在应用被杀死后还是下载中状态，需要进行判断改为暂停
    DownSignModel downSignModel =
        await DownloadSignDb.getDownSignByAppid(appid);
    if (downSignModel == null) {
      return Future.value(null);
    }
    if (!_mainTaskMap.containsKey(appid)) {
      downSignModel.status = DownSignTaskStatus.pause;
      DownloadSignDb.getDownSignTaskByAppidAndTaskType(
              appid, DownloadFileTask.DOWNLOAD_TASK_TYPE)
          .then((taskModel) {
        if (taskModel != null && taskModel.ext != null) {
          FlutterDownloader.pause(taskId: taskModel.ext);
        }
      });
      DownloadSignDb.updateDownSign(downSignModel);
    }
    return Future.value(downSignModel);
  }

  static Future<bool> deleteDownSignTask(int appid) async {
    return Future.value(true);
  }
}

///全局主任务监听
class MainTaskListener extends DownloadSignListener {
  int gameId;

  MainTaskListener(this.gameId);

  @override
  int onGetGameId() {
    throw gameId;
  }

  ///暂停状态,可能是等待连接wifi后下载，可能是玩家暂停了
  void onPause(String msg) {
    List<DownloadSignListener> list = DownloadSignManager.listenerList;
    for (var value in list) {
      if (value.onGetGameId() == gameId) {
        value.onPause(msg);
      }
    }
  }

  //完成
  void onCompleted() {
    List<DownloadSignListener> list = DownloadSignManager.listenerList;
    for (var value in list) {
      if (value.onGetGameId() == gameId) {
        value.onCompleted();
      }
    }
  }

  ///安装完成，显示打开，ios 显示下载  点击时再次下载
  ///ios 安装完成可以通过，内置下载监听安装是否完成
  void onInstalled() {
    List<DownloadSignListener> list = DownloadSignManager.listenerList;
    for (var value in list) {
      if (value.onGetGameId() == gameId) {
        value.onInstalled();
      }
    }
  }

  ///重试
  void onError() {
    List<DownloadSignListener> list = DownloadSignManager.listenerList;
    for (var value in list) {
      if (value.onGetGameId() == gameId) {
        value.onError();
      }
    }
  }

  ///进度
  void onProgress(double progress, String speed) {
    List<DownloadSignListener> list = DownloadSignManager.listenerList;
    for (var value in list) {
      if (value.onGetGameId() == gameId) {
        value.onProgress(progress, speed);
      }
    }
  }

  /// 更新
  void onUpdate() {}

  ///显示提示，可能是点击后，发现不能正常流程，比如4g不能下载，需要提示,提示完进行下一步
  ///返回 true表示已经处理完成，不再往下分发
  bool onShowHint(int clickId, Object tag, DownSignTaskNext next) {}
}

///通用下载签名任务监听
abstract class DownloadSignListener {
  ///暂停状态,可能是等待连接wifi后下载，可能是玩家暂停了
  void onPause(String msg) {}

  //完成
  void onCompleted() {}

  ///安装完成，显示打开，ios 显示下载  点击时再次下载
  ///ios 安装完成可以通过，内置下载监听安装是否完成
  void onInstalled() {}

  ///重试
  void onError() {}

  ///进度
  void onProgress(double progress, String speed) {}

  /// 更新
  void onUpdate() {}

  ///显示提示，可能是点击后，发现不能正常流程，比如4g不能下载，需要提示,提示完进行下一步
  ///返回 true表示已经处理完成，不再往下分发
  bool onShowHint(int clickId, Object tag, DownSignTaskNext next) {}

  int onGetGameId();
}
