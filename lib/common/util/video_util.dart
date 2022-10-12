import 'package:flutter_huoshu_app/common/util/sp_util.dart';

class VideoUtil {
  static final String KEY_IS_OPEN_VOLUME = "KEY_IS_OPEN_VOLUME"; //视频是否播放声音

  static bool getBoolValue(String key,bool defaultValue) {
    if (SpUtil.prefs != null) {
      return SpUtil.prefs.getBool(key) == null ? defaultValue : SpUtil.prefs.getBool(key);
    } else {
      return defaultValue;
    }
  }

  static void saveBoolValue(String key, bool param) {
    SpUtil.prefs.setBool(key, param);
  }

  static bool getOpenVolume() {
    return getBoolValue(KEY_IS_OPEN_VOLUME, false);
  }

  static void setOpenVolume(bool param) {
    saveBoolValue(KEY_IS_OPEN_VOLUME, param);
  }
}