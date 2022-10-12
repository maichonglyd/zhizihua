import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_repository.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/task/download_file_task.dart';
import 'down_sign_task_interface.dart';
import 'ios_cert_task.dart';
import 'ios_sign_task.dart';

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// 主任务，包含多个子任务
///

class MainTask extends DownSignTaskInterface with DownloadSignListener {
  static const String DOWNLOAD_SIGN_TASK_TYPE = "downsign";

  int clickId;
  List<DownSignTaskInterface> itemTaskList = [];

  MainTask(DownSignModel gameModel, clickId) {
    this.gameModel = gameModel;
    this.clickId = clickId;
  }

  @override
  void run() async {
    //构建任务数据
    await _prepareTaskData();

    ///不需要依赖别的任务的子任务，直接运行，顺序按照列表中的顺序
    for (var itemTask in itemTaskList) {
      if (itemTask.dependendTasks == null ||
          itemTask.dependendTasks.length == 0) {
        itemTask.run();
      } else {
        checkDependendTaskRun(itemTask);
      }
    }
  }

  void checkDependendTaskRun(DownSignTaskInterface itemTask) {
    if (itemTask.taskModel.status == DownSignTaskStatus.initial) {
      List<DownSignTaskInterface> dependendTasks = itemTask.dependendTasks;
      bool allDependendTaskOk = true;
      for (var value in dependendTasks) {
        if (value.taskModel.status != DownSignTaskStatus.success) {
          HuoLog.d("还有任务没有完成：${value}");
          allDependendTaskOk = false;
          break;
        }
      }
      if (allDependendTaskOk) {
        HuoLog.d("依赖任务完成了");
        itemTask.run();
      }
    }
  }

  void _prepareTaskData() async {
    //查询出当前appid的子任务
    DownSignTaskModel dbTaskModel =
        await DownloadSignDb.getDownSignTaskByAppidAndTaskType(
            gameModel.appid, DOWNLOAD_SIGN_TASK_TYPE);

    if (dbTaskModel == null) {
      taskModel =
          DownSignTaskModel(0, gameModel.appid, DOWNLOAD_SIGN_TASK_TYPE, 100);
      await DownloadSignDb.insertDownSignTask(taskModel);
    } else {
      taskModel = dbTaskModel;
    }

    if (gameModel.downType == DownTypeEnum.ipa.index) {
      itemTaskList = await _createIpaTask(taskModel.id);
    } else {
      itemTaskList = await _createApkTask(taskModel.id);
    }
  }

  Future<List<DownSignTaskInterface>> _createIpaTask(int pid) async {
    List<DownSignTaskInterface> list = [];
    DownSignTaskModel itemDownTaskModel =
        DownSignTaskModel.asNew(pid, gameModel.appid, 85);
    DownloadFileTask downloadFileTask =
        DownloadFileTask(gameModel, itemDownTaskModel, this);

    DownSignTaskModel certTaskModel =
        DownSignTaskModel.asNew(pid, gameModel.appid, 5);
    IosCertTask iosCertTask = IosCertTask(gameModel, certTaskModel, this);
    List<DownSignTaskInterface> dependendTasks = [
      downloadFileTask,
      iosCertTask
    ];
    DownSignTaskModel iosTaskModel =
        DownSignTaskModel.asNew(pid, gameModel.appid, 10);
    IosSignTask iosSignTask = IosSignTask(gameModel, iosTaskModel, this);
    iosSignTask.dependendTasks = dependendTasks;
    list.add(downloadFileTask);
    list.add(iosCertTask);
    list.add(iosSignTask);
    return list;
  }

  Future<List<DownSignTaskInterface>> _createApkTask(int pid) async {
    List<DownSignTaskInterface> list = [];
    DownSignTaskModel itemDownTaskModel =
        DownSignTaskModel.asNew(pid, gameModel.appid, 100);
    DownloadFileTask downloadFileTask =
        DownloadFileTask(gameModel, itemDownTaskModel, this);
    list.add(downloadFileTask);
    return list;
  }

  //当多个任务同时返回，并且有正确的还有错误的情况的数据同步问题

  @override
  void onCompleted() {
    print("收到完成任务了");
    bool allItemTaskFinish = true;
    for (var itemTask in itemTaskList) {
      if (itemTask.taskModel.status != DownSignTaskStatus.success) {
        allItemTaskFinish = false;
      }
      print("任务状态：${itemTask} ${itemTask.taskModel.status}");
      checkDependendTaskRun(itemTask);
    }
    if (listener != null) {
      if (allItemTaskFinish) {
        this.taskModel.status = DownSignTaskStatus.success;
        this.gameModel.status = DownSignTaskStatus.success;
        DownloadSignDb.updateDownSign(this.gameModel);
        listener.onCompleted();
      }
    }
  }

  @override
  void onError() {
    //有一个错了，其他需要全部暂停
    for (var itemTask in itemTaskList) {
      if (itemTask.taskModel.status != DownSignTaskStatus.error) {
        itemTask.pause();
      }
    }
    if (listener != null) {
      listener.onError();
    }
    this.gameModel.status = DownSignTaskStatus.error;
    this.taskModel.status = DownSignTaskStatus.error;
    DownloadSignDb.updateDownSign(this.gameModel);
  }

  @override
  void onPause(String msg) {
    for (var itemTask in itemTaskList) {
      itemTask.pause();
    }
    if (listener != null) {
      listener.onPause(msg);
    }
    this.gameModel.status = DownSignTaskStatus.pause;
    if (taskModel != null) {
      taskModel.status = DownSignTaskStatus.pause;
    }
    DownloadSignDb.updateDownSign(this.gameModel);
  }

  @override
  void onProgress(double progress, String speed) {
    double itemAllProgress = 0;
    for (var itemTask in itemTaskList) {
      itemAllProgress += itemTask.taskModel.curProgress *
          itemTask.taskModel.taskProgress /
          100;
      checkDependendTaskRun(itemTask);
    }
    if (listener != null) {
      listener.onProgress(itemAllProgress, null);
    }
    this.gameModel.status = DownSignTaskStatus.running;
    this.gameModel.progress = itemAllProgress;
    DownloadSignDb.updateDownSign(this.gameModel);
  }

  @override
  bool pause() {
    //有些任务不能暂停
    for (var itemTask in itemTaskList) {
      if (itemTask.taskModel.status == DownSignTaskStatus.running) {
        bool canPause = itemTask.pause();
        if (!canPause) {
          return false;
        }
      }
    }
    gameModel.status = DownSignTaskStatus.pause;
    taskModel.status = DownSignTaskStatus.pause;
    DownloadSignDb.updateDownSign(this.gameModel);
    return true;
  }

  @override
  int onGetGameId() {
    if (gameModel != null) {
      return gameModel.appid;
    }
    return 0;
  }
}
