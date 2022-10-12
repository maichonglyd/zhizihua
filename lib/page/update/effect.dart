import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<UpdatePageState> buildEffect() {
  return combineEffects(<Object, Effect<UpdatePageState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    UpdatePageAction.onClick: _onClick,
    UpdatePageAction.clickCancel: _clickCancel,
  });
}

void _onAction(Action action, Context<UpdatePageState> ctx) {}

void _initState(Action action, Context<UpdatePageState> ctx) {
  if (Platform.isAndroid) {
    ctx.state.updateDownListener = new UpdateDownListener(ctx);
    FlutterDownloadPlugin.registerCallback(ctx.state.updateDownListener);
  } else {
    DownloadSignManager.addListener(new UpdateDownloadSign(ctx));
  }
}

_launchURL(String url) async {
//    url="itms-services://?action=download-manifest&url=https://dios.tstjgame.com/sdkgame/jzfhlios_6109/jzfhlios_6109.plist";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}

void _onClick(Action action, Context<UpdatePageState> ctx) {
  if (Platform.isIOS) {
    Game game = Game();
//    game.gameId = int.parse(AppConfig.iosAppid);
//    DownloadSignManager.click(game, 0);
    _launchURL(ctx.state.upInfo.url);
    return;
  }

  switch (ctx.state.status) {
    case DownloadStatus.PAUSE:
      FlutterDownloadPlugin.startTask(
          "app.apk", ctx.state.upInfo.url, int.parse(AppConfig.appid));
      break;
    case DownloadStatus.INITIAL:
      FlutterDownloadPlugin.startTask(
          "app.apk", ctx.state.upInfo.url, int.parse(AppConfig.appid));
      break;
    case DownloadStatus.DOWNLOADING: //暂停
      FlutterDownloadPlugin.pauseTask(
          "app.apk", ctx.state.upInfo.url, int.parse(AppConfig.appid));
      ctx.dispatch(UpdatePageActionCreator.updateStatus(
          DownloadStatus.PAUSE, ctx.state.curProgress));
      break;

    case DownloadStatus.OPEN: //打开
      break;
    case DownloadStatus.INSTALL: //安装
      FlutterDownloadPlugin.install("app.apk", ctx.state.upInfo.url);
      break;
  }
}

void _dispose(Action action, Context<UpdatePageState> ctx) {
  if (Platform.isAndroid) {
    FlutterDownloadPlugin.unRegisterCallback(ctx.state.updateDownListener);
  }
}

void _clickCancel(Action action, Context<UpdatePageState> ctx) {
  ctx.broadcast(HomeActionCreator.startCountDown());
}
