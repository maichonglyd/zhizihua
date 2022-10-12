import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/down/flutter_downloader_helper.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_repository.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';
import 'package:oktoast/oktoast.dart';
import '../download_sign_manager.dart';
import 'down_sign_task_interface.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

//canceled → const DownloadTaskStatus
//const DownloadTaskStatus(5)
//complete → const DownloadTaskStatus
//const DownloadTaskStatus(3)
//enqueued → const DownloadTaskStatus
//const DownloadTaskStatus(1)
//failed → const DownloadTaskStatus
//const DownloadTaskStatus(4)
//paused → const DownloadTaskStatus
//const DownloadTaskStatus(6)
//running → const DownloadTaskStatus
//const DownloadTaskStatus(2)
//undefined → const DownloadTaskStatus
//const DownloadTaskStatus(0)

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// 下载任务，主要是用于下载任务,下载ipa,下载apk
///
///
///

class DownloadFileTask extends DownSignTaskInterface
    with FlutterDownloaderCallback {
  static const String DOWNLOAD_TASK_TYPE = "down";
  DownloadTaskStatus status;

  DownloadFileTask(DownSignModel gameModel, DownSignTaskModel taskModel,
      DownloadSignListener listener) {
    this.gameModel = gameModel;
    this.taskModel = taskModel;
    this.listener = listener;
  }

  @override
  void run() async {
    await _prepareTaskData();
    if (taskModel.status == DownSignTaskStatus.success) {
      listener.onCompleted();
    }
    if (taskModel.ext != null) {
      print("当前下载状态：${taskModel.status} ${taskModel.ext}");
      if (taskModel.status != DownSignTaskStatus.running &&
          taskModel.status != DownSignTaskStatus.enqueued &&
          taskModel.status != DownSignTaskStatus.success) {
        if (taskModel.status == DownSignTaskStatus.pause) {
          print("游戏恢复下载了:${taskModel.ext}");
          taskModel.ext = await FlutterDownloader.resume(taskId: taskModel.ext);
          print("恢复结果${taskModel.ext}");
          DownloadSignDb.updateDownSignTask(taskModel);
        } else {
          print("游戏重新下载了:${taskModel.ext}");
          String result = await FlutterDownloader.retry(taskId: taskModel.ext);
          print("游戏重新结果${result}");
        }
      }
    } else {
      String downPath = await DownloadSignManager.getDefaultDownPath();
      var downPathDir = Directory("${downPath}/${gameModel.appid}");
      downPathDir.createSync(recursive: true);
      //没下载过
      final taskId = await FlutterDownloader.enqueue(
        url: gameModel.url,
        savedDir: downPathDir.path,
        showNotification: false,
        // show download progress in status bar (for Android)
        openFileFromNotification:
            false, // click on notification to open downloaded file (for Android)
      );
      taskModel.ext = taskId;
    }
    //添加下载监听回调
    FlutterDownloaderHelper.addDownloaderCallback(this);
  }

  ///准备数据，主要是构造出taskModel和已有的下载任务downloadTask
  void _prepareTaskData() async {
    //数据库中查出任务
    var dbTaskModel = await DownloadSignDb.getDownSignTaskByAppidAndTaskType(
        taskModel.appid, DOWNLOAD_TASK_TYPE);

    //当前主任务还没有建立，需要进行创建
    if (dbTaskModel == null) {
      taskModel.taskType = DOWNLOAD_TASK_TYPE;
      taskModel.status = DownSignTaskStatus.enqueued;
      await DownloadSignDb.insertDownSignTask(taskModel);
    } else {
      taskModel = dbTaskModel;
    }
    print("上一次的下载id=${taskModel.ext}");
    DownloadTask downloadTask = null;
    //之前下载过，恢复状态
    if (taskModel.ext != null && taskModel.ext.isNotEmpty) {
      List<DownloadTask> downloadTaskList =
          await FlutterDownloader.loadTasksWithRawQuery(
              query: "SELECT * FROM task WHERE task_id='${taskModel.ext}'");

      if (downloadTaskList != null && downloadTaskList.length > 0) {
        downloadTask = downloadTaskList[0];
        //url改变了，需要删除原来的任务，重新下载
        if (gameModel.url != null && gameModel.url != downloadTask.url) {
          await FlutterDownloader.remove(taskId: downloadTask.taskId);
          downloadTask = null;
          HuoLog.d("下载任务的url不一致了，需要重新下载");
        }
      }
    }
    if (downloadTask != null) {
      File file = File("${downloadTask.savedDir}/${downloadTask.filename}");
      if (file.existsSync()) {
        taskModel.curProgress = downloadTask.progress.toDouble();
        taskModel.status =
            FlutterDownloaderHelper.convertStatus(downloadTask.status);
        HuoLog.d("下载任务存在，并且状态为=${taskModel.status}");
        return;
      }
      HuoLog.d("下载任务存在，但是文件已被删除");
      //下载任务不存在
      taskModel.status = DownSignTaskStatus.enqueued;
      taskModel.curProgress = 0;
      taskModel.ext = null;
    } else {
      //下载任务不存在
      taskModel.status = DownSignTaskStatus.enqueued;
      taskModel.curProgress = 0;
      taskModel.ext = null;
    }
  }

  @override
  bool pause() {
    print("暂停下载了");
    if (taskModel.status == DownSignTaskStatus.success) {
      return false;
    }
    FlutterDownloader.pause(taskId: taskModel.ext);
    return true;
  }

  @override
  void onDownloadUpdate(String id, DownloadTaskStatus status, num progress) {
    HuoLog.d("onDownloadUpdate ${id} ${status} ${progress}");
    //收到更新，修改自己的数据，通知上层更新，保存更新到数据库
    taskModel.status = FlutterDownloaderHelper.convertStatus(status);
    taskModel.curProgress = progress.toDouble();
    HuoLog.d("prepare notify  ${taskModel.appid} ${listener.onGetGameId()}");
    if (listener != null && taskModel.appid == listener.onGetGameId()) {
      switch (taskModel.status) {
        case DownSignTaskStatus.error:
          listener.onError();
          break;
        case DownSignTaskStatus.success:
          listener.onCompleted();
          break;
        case DownSignTaskStatus.running:
          listener.onProgress(taskModel.curProgress, null);
          break;
        case DownSignTaskStatus.pause:
          listener.onPause(null);
          break;
        case DownSignTaskStatus.installed:
          listener.onInstalled();
          break;
        case DownSignTaskStatus.wait:
          listener.onProgress(taskModel.curProgress, null);
          break;
      }
      //更新到数据库中
      DownloadSignDb.updateDownSignTask(taskModel);
    }
  }

  @override
  String getTaskId() {
    if (taskModel != null &&
        taskModel.ext != null &&
        taskModel.ext.isNotEmpty) {
      return taskModel.ext;
    } else {
      return "";
    }
  }
}
