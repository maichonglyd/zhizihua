import 'dart:io';

import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:oktoast/oktoast.dart';

class CheckAppAvailability {

  static Map<AppPlatform, AppPackageName> _appMap = {
    AppPlatform.WeChat: AppPackageName(getText(name: 'textWx'),"com.tencent.mm", "weixin://"),
    AppPlatform.QQ: AppPackageName(getText(name: 'textQQ'),"com.tencent.mobileqq", "mqq://"),
    AppPlatform.GGC: AppPackageName(getText(name: 'textGGCWallet'),"cn.ggcv.ggcpay", ""),
  };

  static Future checkAvailability(AppPlatform appPlatform, Function function, {String errorMsg}) async {
    if (!_appMap.containsKey(appPlatform)) {
      HuoLog.e("CheckAppAvailability: not App");
      return false;
    }
    HuoLog.d("logcat: line 20");
    bool result = false;
    AppPackageName appPackageName = _appMap[appPlatform];
    if (Platform.isAndroid) {
      if (appPackageName.android.isNotEmpty) {
        var map = await FlutterPluginUserAgentAuth.getAppInstall(appPackageName.android);
        result = null != map && map;
      } else {
        HuoLog.e("CheckAppAvailability: $appPlatform android package name is null");
        result = false;
      }
    } else if (Platform.isIOS) {
      result = true; // ios暂时不做判断
//      if (appPackageName.ios.isNotEmpty) {
//        var map = await FlutterPluginUserAgentAuth.getAppInstall(appPackageName.ios);
//        result = null != map && map;
//      } else {
//        if (AppPlatform.GGC != appPlatform) {
//          HuoLog.e("CheckAppAvailability: $appPlatform ios scheme is null");
//          result = false;
//        } else {
//          HuoLog.e("CheckAppAvailability: 目前不清楚 GGC 的协议是什么，默认返回 true");
//          result = true;
//        }
//      }
    }
    if (result) {
      function();
    } else {
      if (null == errorMsg) {
        showToast(getText(name: 'toastPleaseCheckApp', args: [appPackageName.name]));
      } else {
        showToast(errorMsg);
      }
    }
  }

}

enum AppPlatform {
  WeChat,
  QQ,
  GGC,
}

class AppPackageName {
  String name;
  String android;
  String ios;

  AppPackageName(this.name, this.android, this.ios);
}