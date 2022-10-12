import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/sign/ipa_sign.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/down/flutter_downloader_helper.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_repository.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';

import '../download_sign_manager.dart';
import 'down_sign_task_interface.dart';

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// ios 证书处理任务
///
///
class IosCertTask extends DownSignTaskInterface {
  static const String IOS_CERT_TASK_TYPE = "cert";
  IpaSignModel ipaSignModel;
  var _timer;
  bool isPause = false;

  IosCertTask(DownSignModel gameModel, DownSignTaskModel taskModel,
      DownloadSignListener listener) {
    this.gameModel = gameModel;
    this.taskModel = taskModel;
    this.listener = listener;
  }

  @override
  void run() async {
    isPause = false;
    if (taskModel.status == DownSignTaskStatus.success) {
      if (ipaSignModel != null &&
          ipaSignModel.data != null &&
          ipaSignModel.data.pk12_pwd != null &&
          File(ipaSignModel.data.mobileConfigPath).existsSync() &&
          File(ipaSignModel.data.p12Path).existsSync()) {
        listener.onCompleted();
        return;
      }
    }
    if (ipaSignModel == null) {
      if (_timer != null) {
        taskModel.curProgress = 0;
        _timer.cancel();
      }
      taskModel.status = DownSignTaskStatus.running;
      _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        taskModel.curProgress += 1;
        if (taskModel.curProgress >= 95) {
          _timer.cancel();
        }
        if (listener != null &&
            taskModel.status == DownSignTaskStatus.running) {
          listener.onProgress(taskModel.curProgress, null);
        }
      });
      ipaSignModel = await GameService.getIOSSignUrl(gameModel.appid,
          udid: DeviceInfoUtil.deviceBean.udid,
          port: FlutterDownloaderHelper.default_port,
          isShowToast: true);
    }
    if (ipaSignModel != null &&
        ipaSignModel.data != null &&
        ipaSignModel.data.pk12_pwd != null) {
      HuoLog.d("获取到的install plist url：${ipaSignModel.data.plist_url}");

      //下载p12文件和mobileconfig文件
      Dio dio = new Dio();
      String downPath = await DownloadSignManager.getDefaultDownPath();
      var downPathDir = Directory("${downPath}/${gameModel.appid}");
      downPathDir.createSync(recursive: true);

      var mobileconfigFile = File(downPathDir.path +
          "/${gameModel.appid}_${DateTime.now().millisecondsSinceEpoch}.mobileconfig");
      await dio.download(ipaSignModel.data.mobile_url, mobileconfigFile.path);

      var p12File = File(downPathDir.path +
          "/${gameModel.appid}_${DateTime.now().millisecondsSinceEpoch}.p12");
      await dio.download(ipaSignModel.data.p12_url, p12File.path);

      if (!mobileconfigFile.existsSync() || !p12File.existsSync()) {
        taskModel.status = DownSignTaskStatus.error;
        taskModel.curProgress = 0;
        listener.onError();
        return;
      }
      ipaSignModel.data.mobileConfigPath = mobileconfigFile.path;
      ipaSignModel.data.p12Path = p12File.path;
      taskModel.status = DownSignTaskStatus.success;
      taskModel.curProgress = 100;
    } else {
      taskModel.status = DownSignTaskStatus.error;
      taskModel.curProgress = 0;
    }
    if (_timer != null) {
      _timer.cancel();
    }
    if (listener != null && !isPause) {
      if (taskModel.status == DownSignTaskStatus.success) {
        listener.onCompleted();
      } else {
        listener.onError();
      }
    }
  }

  ///准备数据，主要是构造出taskModel和已有的下载任务downloadTask
  void _prepareTaskData() async {
    //数据库中查出任务
    var dbTaskModel = await DownloadSignDb.getDownSignTaskByAppidAndTaskType(
        taskModel.appid, IOS_CERT_TASK_TYPE);

    //当前主任务还没有建立，需要进行创建
    if (dbTaskModel == null) {
      taskModel.taskType = IOS_CERT_TASK_TYPE;
      taskModel.status = DownSignTaskStatus.enqueued;
      await DownloadSignDb.insertDownSignTask(taskModel);
    } else {
      taskModel = dbTaskModel;
    }
  }

  @override
  bool pause() {
    isPause = true;
    if (_timer != null) {
      _timer.cancel();
    }
    return true;
  }
}
