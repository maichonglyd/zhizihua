import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/down_sign_task_interface.dart';
import 'package:http_server/http_server.dart';
import 'package:oktoast/oktoast.dart';

class FlutterDownloaderHelper {
  static List<FlutterDownloaderCallback> listeners = [];
  static const String SP_KEY_DEFAULT_PORT = "sp_key_default_port";
  static int default_port = 8183;

  static void initialize() async {
    print("DownloadSignManager initialize");
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
    _startListener();
    String ipaSignRootPath = await DownloadSignManager.getDefaultIpaSignPath();
    var virDir = new VirtualDirectory(Directory(ipaSignRootPath).parent.path)
      ..allowDirectoryListing = true;

    int sp_default_port = (await SpUtil.getSP()).getInt(SP_KEY_DEFAULT_PORT);
    if (sp_default_port != null) {
      default_port = sp_default_port;
    }
    var server = null;
    while (true) {
      try {
        server = HttpServer.bind(InternetAddress.loopbackIPv4, default_port);
      } catch (e) {
        print(e);
      }
      if (server == null) {
        default_port = default_port + 1;
      } else {
        (await SpUtil.getSP()).setInt(SP_KEY_DEFAULT_PORT, default_port);
        break;
      }
    }
    server.then((server) {
      print("监听地址：${server.address} ${server.port}");
      server.listen((request) async {
        HuoLog.d("当前本地请求地址：${request.uri} ");
        showToast(getText(name: 'toastInstallingInProgress'));
        DownloadSignManager.notifyIosStartInstall(request.uri.toString());
        var result = await virDir.serveRequest(request);
      });
    });
  }

  static Future<DownloadTask> loadTasksWithRawQuery(String taskId) async {
    List<DownloadTask> downloadTaskList =
        await FlutterDownloader.loadTasksWithRawQuery(
            query: "SELECT * FROM task WHERE task_id='${taskId}'");
    if (downloadTaskList != null && downloadTaskList.length > 0) {
      return downloadTaskList[0];
    }
    return null;
  }

  static int convertStatus(DownloadTaskStatus downloadStatus) {
    if (downloadStatus == DownloadTaskStatus.complete) {
      return DownSignTaskStatus.success;
    }
    if (downloadStatus == DownloadTaskStatus.failed) {
      return DownSignTaskStatus.error;
    }
    if (downloadStatus == DownloadTaskStatus.canceled ||
        downloadStatus == DownloadTaskStatus.paused) {
      return DownSignTaskStatus.pause;
    }
    if (downloadStatus == DownloadTaskStatus.enqueued ||
        downloadStatus == DownloadTaskStatus.running) {
      return DownSignTaskStatus.running;
    }
    if (downloadStatus == DownloadTaskStatus.undefined) {
      return DownSignTaskStatus.error;
    }
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, num progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
    HuoLog.d("down_callback ${id} ${status} ${progress}");
  }

  static void _startListener() {
    HuoLog.d("DownloadSignManager _startListener");
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      num progress = data[2];
      if (progress < 0) {
        progress = 0;
      }
      HuoLog.d("_port.listen ${id}");
      for (var value in listeners) {
        HuoLog.d("_port.listen ${value.getTaskId()}");
        if (value.getTaskId() == id) {
          value.onDownloadUpdate(id, status, progress);
        }
      }
    });
    HuoLog.d("注册下载全局监听");
    //添加监听
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void destory() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    listeners = [];
  }

  static void addDownloaderCallback(FlutterDownloaderCallback callback) {
    listeners.add(callback);
  }

  static void removeDownloaderCallback(FlutterDownloaderCallback callback) {
    listeners.remove(callback);
  }
}

abstract class FlutterDownloaderCallback {
  void onDownloadUpdate(String id, DownloadTaskStatus status, num progress);

  String getTaskId();
}
