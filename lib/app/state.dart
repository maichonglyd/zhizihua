import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/app_setting_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/action.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/global_store/store.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/repository/db_helper.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';

class AppState with GlobalBaseState<AppState> {
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  ConnectivityResult netConnectStatus = ConnectivityResult.none;

  @override
  AppState clone() {
    return AppState()..copyGlobalFrom(this);
  }
}

AppState initState(Map<String, dynamic> args) {
  SpUtil.init();
  DbHelper.openDb();
  DownloadSignManager.init();
  AppState appState = AppState();
  return appState;
}

Object globalConn(Object pagestate, GlobalState appState) {
  final GlobalBaseState p = pagestate;
  if (p.locale == appState.locale) {
    return pagestate;
  } else {
    if (pagestate is Cloneable) {
      final Object copy = pagestate.clone();
      final GlobalBaseState newState = copy;
      newState.locale = appState.locale;
      return newState;
    }
  }
}

class ReceiverListenerImpl implements ReceiverListener {
  Context<AppState> ctx;

  ReceiverListenerImpl(this.ctx);

  @override
  void installSuc(String packageName) {
    // TODO: implement installSuc
    // 查询数据库查看是否是本app,更新
    print("ReceiverListenerImpl installSuc: packName:$packageName");
    DownloadTask.updateDownLoadTaskInstall(packageName, 1);
    DownloadTask.getDownLoadTaskByPackageName(packageName).then((gameList) {
      gameList?.forEach((game) {
        FlutterDownloadPlugin.updateGameStatus(game.gameId);
      });
    });
    ctx.broadcast(DownLoadGameListActionCreator.onGetGameList());
    bool isDeleteApk = AppSetUtil.getValue(AppSetUtil.KEY_IS_DELETE_APK, true);
    if (isDeleteApk) {
      DownloadTask.getFilePathByPackageName(packageName).then((path) {
        File file = new File(path);
        file.exists().then((exist) {
          if (exist) {
            file.deleteSync();
          }
        });
      });
    }
  }

  @override
  void completed(int gameId, String packageName, int versionCode, String path) {
    //全局的下载完成
    //查询数据库  更新项目路径 /包名 /状态
    print(
        "ReceiverListenerImpl completed: gameId:$gameId,packName:$packageName,path:$path");
    DownloadTask.updateDownLoadTaskPackageNameAndPath(
        gameId, packageName, path);
    FlutterDownloadPlugin.updateAll();
    //更新渠道信息，供sdk安装后使用
    FlutterPluginUserAgentAuth.addOrUpdateAgent(
        packageName,
        versionCode == null ? "1_0" : versionCode.toString() + "_0",
        DeviceInfoUtil.getHuoInitInfo().hs_agent);
  }
}

class UserAgentAuthListenerImpl implements UserAgentAuthListener {
  Context<AppState> ctx;

  UserAgentAuthListenerImpl(this.ctx);

  @override
  void initDeviceInfo(DeviceBean deviceInfo) {
    if (deviceInfo != null) {
      DeviceInfoUtil.deviceBean = deviceInfo;
    }
  }

  @override
  void nativeInitFail(HuoInitInfo huoInitInfo) {
    print("初始化失败了");
  }

  @override
  void nativeInitOK(HuoInitInfo huoInitInfo) {
    print("初始化成功了：" + huoInitInfo.hs_agent);
    //修改baseUrl
    DeviceInfoUtil.huoInitInfo = huoInitInfo;

//    CommonDio.mDio.options.baseUrl = huoInitInfo.base_url;
  }
}
