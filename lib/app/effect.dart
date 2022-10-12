import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_huoshu_app/app/action.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/protocol_info_util.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/app/state.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/action.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wakelock/wakelock.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

Effect<AppState> buildEffect() {
  return combineEffects(<Object, Effect<AppState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    AppAction.onInitSetting: _onInitSetting,
    AppAction.onInitUserAgent: _onInitUserAgent,
  });
}

void networkListener(Context<AppState> ctx) {
  Connectivity connectivity = new Connectivity();
  (connectivity.checkConnectivity()).then((value) {
    if (value == ConnectivityResult.none) {
      InitInfoUtil.initError(ctx);
      showToast(getText(name: 'textNetworkError'));
    }
  });
  ctx.state.connectivitySubscription =
      connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      if (InitInfoUtil.loadStatus == LoadStatus.error) {
        ctx.dispatch(HomeActionCreator.onInitCheck());
      }
      DownloadTask.getAllDownloadTask().then((gameList) {
        gameList.forEach((game) {
          if (game.status == DownloadStatus.PAUSE ||
              game.status == DownloadStatus.RETRY) if (game.install == 0) {
            FlutterDownloadPlugin.startTask(
                game.gameName + ".apk", game.downUrl, game.gameId);
          }
        });
      });
    }
  });
}

// 更换域名
Future<void> _changUrl() async {
  var sp = await SpUtil.getSP();
  String str = sp.getString(SpUtil.NEED_CHANGE_URL);
  if ("1" == str) {
    AppConfig.baseUrl = sp.getString(SpUtil.BASE_URL);
    AppConfig.rsa_public_key = sp.getString(SpUtil.RSA_KEY);
    AppConfig.appid = sp.getString(SpUtil.APP_ID);
    AppConfig.iosAppid = sp.getString(SpUtil.IOS_APP_ID);
    AppConfig.client_id = sp.getString(SpUtil.CLIENT_ID);
    AppConfig.client_key = sp.getString(SpUtil.CLIENT_KEY);
  }
}

Future<void> _init(Action action, Context<AppState> ctx) {
  HuoLog.d("app page init()");
  InitInfoUtil.loadStatus = LoadStatus.loading;
  if (null != LocaleManager.getLocaleType()) {
    ctx.dispatch(AppActionCreator.onInitUserAgent());
  }
}

void _onInitSetting(Action action, Context<AppState> ctx) async {
  await AppUtil.checkPhonePermission();
  Wakelock.enable(); // 禁止息屏
  await _changUrl(); // 更换域名
  FlutterDownloadPlugin.init(ReceiverListenerImpl(ctx));
  networkListener(ctx);
  //用户渠道认证注册
  FlutterPluginUserAgentAuth.init(UserAgentAuthListenerImpl(ctx)).then((data) {
    FlutterPluginUserAgentAuth.getWebViewUserAgent().then((value) => DeviceInfoUtil.webViewUserAgent = value);
    DeviceInfoUtil.initPlatformState().then((data) {
      //share sdk 初始化数据
      ShareSDKRegister register = ShareSDKRegister();
      InitInfoUtil.getInitInfo().then((initInfo) {
        if (initInfo != null && initInfo.data != null) {
          if (initInfo.data.thirdPartyData != null) {
            if (initInfo.data.thirdPartyData.wx != null) {
  //            print("Shareinfo wx info is ${initInfo.data.thirdPartyData.wx.appKey} and secret ${initInfo.data.thirdPartyData.wx.appKey}");
   //           print("Shareinfo wx local info is ${AppConfig.wx_id} and secret ${AppConfig.wx_key}");
              register.setupWechat(AppConfig.wx_id, AppConfig.wx_key,AppConfig.baseUrl);
            }
            if (initInfo.data.thirdPartyData.qq != null) {
    //          print("Shareinfo qq info is ${initInfo.data.thirdPartyData.wx.appKey} and secret ${initInfo.data.thirdPartyData.wx.appKey}");
    //          print("Shareinfo qq info is ${AppConfig.qq_id} and secret ${AppConfig.qq_key}");
              register.setupQQ(AppConfig.qq_id, AppConfig.qq_key);
            }
            SharesdkPlugin.regist(register);
          }

          // 判断是否显示更新弹窗，否则显示其他弹窗，如优惠券
          if (initInfo.data.upInfo != null && initInfo.data.upInfo.upStatus != 0) {
            ctx.broadcast(HomeActionCreator.onNotifyUpInfo(initInfo.data.upInfo));
          } else {
            ctx.broadcast(HomeActionCreator.startCountDown());
          }
        }
      });
    });
  });
}

void _onInitUserAgent(Action action, Context<AppState> ctx) {
  UserService.init().then((map) async {
    InitInfo data = null;
    try {
      data = InitInfo.fromJson(map);
    } catch (e) {
      HuoLog.d(e);
    }

    if (data == null || data.code != CommonDio.SUCCESS_CODE || data.data == null) {
      InitInfoUtil.initError(ctx);
      return;
    }

    if (data != null && data.code == CommonDio.SUCCESS_CODE && data.data != null) {
      InitInfoUtil.saveData(json.encode(map));

      // 判断是否需要从服务器获取语言包
      HuoLog.d('language url = ${data.data.clientLangUrl}');
      if (!LocaleManager.isSupport && null != data.data.clientLangUrl && data.data.clientLangUrl.isNotEmpty) {
        bool getLanguageJsonResult = await LocaleManager.requestLanguageJson(data.data.clientLangUrl);
        HuoLog.d("从服务器获取语言包成功与否：$getLanguageJsonResult");
        if (getLanguageJsonResult) {
          InitInfoUtil.initOK(ctx, data);
        } else {
          InitInfoUtil.initError(ctx);
        }
      } else {
        InitInfoUtil.initOK(ctx, data);
      }

      // 流程：显示用户协议弹窗 -> 申请权限 -> 显示更新弹窗 -> 显示其他弹窗，如优惠券
      ProtocolInfoUtil.getInitInfo().then((value) {
        if (value == "2") {
          ctx.dispatch(AppActionCreator.onInitSetting());
        } else {
          // 数据返回时，HomePage还没实例化，导致无法调用方法，所以在HomePage再次判断是否需要显示用户协议
          // ctx.broadcast(HomeActionCreator.showProtocol());
        }
      });
    }
  });
}

void _dispose(Action action, Context<AppState> ctx) {
  ctx.state.connectivitySubscription.cancel();
}
