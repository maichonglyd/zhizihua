import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/sign/ipa_sign.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/down/flutter_downloader_helper.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/flutter_download_sign_plugin.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/download_file_task.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/ios_cert_task.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../download_sign_manager.dart';
import 'down_sign_task_interface.dart';

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// ios 签名处理任务
///
///
class IosSignTask extends DownSignTaskInterface {
  static const String IOS_SIGN_TASK_ID = "sign";
  var _timer;

  IosSignTask(DownSignModel gameModel, DownSignTaskModel taskModel,
      DownloadSignListener listener) {
    this.gameModel = gameModel;
    this.taskModel = taskModel;
    this.listener = listener;
  }

  @override
  void run() async {
    if (taskModel.status == DownSignTaskStatus.success) {
      listener.onCompleted();
    }
    print("进行签名了");
    if (_timer != null) {
      taskModel.curProgress = 0;
      _timer.cancel();
    }
    taskModel.status = DownSignTaskStatus.running;
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      taskModel.curProgress += 5;
      if (taskModel.curProgress >= 95) {
        _timer.cancel();
      }
      if (listener != null && taskModel.status == DownSignTaskStatus.running) {
        listener.onProgress(taskModel.curProgress, null);
      }
    });
    String taskId = null;
    IpaSignModel ipaSignModel = null;
    for (var value in dependendTasks) {
      if (value is DownloadFileTask) {
        taskId = value.taskModel.ext;
      } else if (value is IosCertTask) {
        ipaSignModel = value.ipaSignModel;
      }
    }

    if (taskId == null ||
        ipaSignModel == null ||
        ipaSignModel.data == null ||
        ipaSignModel.data.pk12_pwd == null ||
        !File(ipaSignModel.data.mobileConfigPath).existsSync() ||
        !File(ipaSignModel.data.p12Path).existsSync()) {
      taskModel.status = DownSignTaskStatus.error;
      taskModel.curProgress = 0;
      _timer.cancel();
      HuoLog.d("签名失败 taskId=${taskId} ipaSignModel=${ipaSignModel}");
      listener.onError();
      return;
    }
    DownloadTask downloadTask =
        await FlutterDownloaderHelper.loadTasksWithRawQuery(taskId);
    File ipaFile = File("${downloadTask.savedDir}/${downloadTask.filename}");
    if (!ipaFile.existsSync()) {
      taskModel.status = DownSignTaskStatus.error;
      taskModel.curProgress = 0;
      _timer.cancel();
      HuoLog.d("签名失败 ipa not exist ${ipaFile.path}");
      listener.onError();
      return;
    }

    int lastIndex = this.gameModel.url.lastIndexOf("/");
    String signIpaName = this.gameModel.url.substring(lastIndex);
    String signIpaPath =
        "${await DownloadSignManager.getDefaultIpaSignPath()}${signIpaName}";

    String infoKeyVlaueJson = json.encode({
      "UDID": DeviceInfoUtil.deviceBean.udid,
      "HuoAgentGame": DeviceInfoUtil.deviceBean.hs_agent
    });

    String command =
        "./zsign -f -k ${ipaSignModel.data.p12Path} -p ${ipaSignModel.data.pk12_pwd} -m ${ipaSignModel.data.mobileConfigPath} -o ${signIpaPath}"
        " -a ${infoKeyVlaueJson} ${ipaFile.path}";

    HuoLog.d("签名的命令：${command}");

    int isOk = await FlutterDownloadSignPlugin.ipaSign(command);
    if (isOk == 2) {
      ipaFile.delete(recursive: true);
      gameModel.installUrl = ipaSignModel.data.plist_url;
      gameModel.filePath = signIpaPath;
      taskModel.status = DownSignTaskStatus.success;
      taskModel.curProgress = 100;
      _timer.cancel();
      listener.onCompleted();
      //调用安装
      DownloadSignManager.launchURL(ipaSignModel.data.plist_url);
    } else {
      taskModel.status = DownSignTaskStatus.error;
      taskModel.curProgress = 0;
      _timer.cancel();
      listener.onError();
    }
  }

  @override
  bool pause() {
    return false;
  }
}
