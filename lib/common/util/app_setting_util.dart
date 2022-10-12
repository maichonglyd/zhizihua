import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSetUtil {
  static final String KEY_IS_4G_DOWN = "KEY_IS_4G_DOWN"; //非WI-FI下载,4g可下载
  static final String KEY_IS_DELETE_APK = "KEY_IS_DELETE_APK"; // 安装后删除apk
  static final String KEY_ACCPET_PUSH = "KEY_ACCPET_PUSH"; //接受推送
  

  static bool getValue(String key,bool defaultValue) {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getBool(key) == null ? defaultValue : SpUtil.prefs.getBool(key);
    } else {
      return defaultValue;
    }
  }

  static bool saveValue(String key, bool isOpen) {
    SpUtil.prefs.setBool(key, isOpen);
  }

}
