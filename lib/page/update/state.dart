import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

import 'action.dart';

class UpdatePageState implements Cloneable<UpdatePageState> {
  UpInfo upInfo;
  UpdateDownListener updateDownListener;
  int status = DownloadStatus.INITIAL;
  double curProgress = 0;

  @override
  UpdatePageState clone() {
    return UpdatePageState()
      ..upInfo = upInfo
      ..updateDownListener = updateDownListener
      ..status = status
      ..curProgress = curProgress;
  }
}

UpdatePageState initState(Map<String, dynamic> args) {
  return UpdatePageState()..upInfo = args['upInfo'];
}

class UpdateDownListener implements DownloadListener {
  Context<UpdatePageState> ctx;

  UpdateDownListener(this.ctx);

  @override
  void canceled() {
    // TODO: implement canceled
    ctx.dispatch(
        UpdatePageActionCreator.updateStatus(DownloadStatus.INITIAL, 0));
  }

  @override
  void completed() {
    // TODO: implement completed
    ctx.dispatch(
        UpdatePageActionCreator.updateStatus(DownloadStatus.INSTALL, 100));
  }

  @override
  void connected() {
    // TODO: implement connected
    ctx.dispatch(
        UpdatePageActionCreator.updateStatus(DownloadStatus.DOWNLOADING, 0));
  }

  @override
  void error() {
    // TODO: implement error
    ctx.dispatch(UpdatePageActionCreator.updateStatus(DownloadStatus.RETRY, 0));
  }

  @override
  int getGameId() {
    // TODO: implement getGameId
    return int.parse(AppConfig.appid);
  }

  @override
  void progress(currentOffset, totalLength) {
    // TODO: implement progress
    num curProgress = (currentOffset / totalLength) * 100;
    ctx.dispatch(UpdatePageActionCreator.updateStatus(
        DownloadStatus.DOWNLOADING, curProgress));
    print("回调进度：" + curProgress.toString());
  }

  @override
  void retry() {
    // TODO: implement retry
    ctx.dispatch(UpdatePageActionCreator.updateStatus(DownloadStatus.RETRY, 0));
  }

  @override
  void started() {
    // TODO: implement started
    ctx.dispatch(
        UpdatePageActionCreator.updateStatus(DownloadStatus.DOWNLOADING, 0));
  }

  @override
  void update() {
    // TODO: implement update
  }

  @override
  void warn() {
    // TODO: implement warn
  }
}

class UpdateDownloadSign implements DownloadSignListener {
  Context<UpdatePageState> ctx;

  UpdateDownloadSign(this.ctx);

  @override
  void onCompleted() {
    ctx.dispatch(
        UpdatePageActionCreator.updateStatus(DownloadStatus.INSTALL, 100));
  }

  @override
  void onError() {
    ctx.dispatch(UpdatePageActionCreator.updateStatus(DownloadStatus.RETRY, 0));
  }

  @override
  int onGetGameId() {
    return int.parse(AppConfig.iosAppid);
  }

  @override
  void onInstalled() {}

  @override
  void onPause(String msg) {
    ctx.dispatch(UpdatePageActionCreator.updateStatus(DownloadStatus.PAUSE, 0));
  }

  @override
  void onUpdate() {}

  @override
  void onProgress(double progress, String speed) {
    ctx.dispatch(UpdatePageActionCreator.updateStatus(
        DownloadStatus.DOWNLOADING, progress));
  }

  @override
  bool onShowHint(int clickId, Object tag, next) {}
}
