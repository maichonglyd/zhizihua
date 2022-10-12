import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_task_model.dart';

import '../download_sign_manager.dart';

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// 下载签名任务通用接口
///
abstract class DownSignTaskInterface {
  DownSignTaskModel taskModel;
  DownSignModel gameModel;
  DownloadSignListener listener;
  List<DownSignTaskInterface> dependendTasks = [];
  void run();

  bool pause();
}

///
/// * author: 刘红亮
/// * email: 752284118@qq.com
/// * date: 2020/7/20
/// 任务状态枚举类
///
class DownSignTaskStatus {
  static const int initial = 100;
  static const int enqueued = 101;
  static const int wait = 102;
  static const int running = 103;
  static const int pause = 104;
  static const int error = 105;
  static const int success = 106;
  static const int installed = 107;
}
