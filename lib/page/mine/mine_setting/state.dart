import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_setting_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';

class SettingState implements Cloneable<SettingState> {
  bool is4gDown;
  bool isDeleteApk;
  bool accpetPush;
  bool videoVolumeOpen;
  String cacheSize;
  int clickCount;

  @override
  SettingState clone() {
    return SettingState()
      ..is4gDown = is4gDown
      ..isDeleteApk = isDeleteApk
      ..accpetPush = accpetPush
      ..cacheSize = cacheSize
      ..clickCount = clickCount
      ..videoVolumeOpen = videoVolumeOpen;
  }
}

SettingState initState(Map<String, dynamic> args) {
  return SettingState()
    ..is4gDown = AppSetUtil.getValue(AppSetUtil.KEY_IS_4G_DOWN, true)
    ..isDeleteApk = AppSetUtil.getValue(AppSetUtil.KEY_IS_DELETE_APK, true)
    ..accpetPush = AppSetUtil.getValue(AppSetUtil.KEY_ACCPET_PUSH, true)
    ..videoVolumeOpen = VideoUtil.getOpenVolume()
    ..cacheSize = "0 MB"
    ..clickCount = 0;
}
