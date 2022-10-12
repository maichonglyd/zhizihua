import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_setting_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingState>>{
      SettingAction.action: _onAction,
      SettingAction.switchDeleteApk: _switchDeleteApk,
      SettingAction.switchPushMsg: _switchPushMsg,
      SettingAction.switchWifi: _switchWifi,
      SettingAction.updateCacheSize: _updateCacheSize,
      SettingAction.switchVideoVolume: _switchVideoVolume,
    },
  );
}

SettingState _onAction(SettingState state, Action action) {
  final SettingState newState = state.clone();
  return newState;
}

SettingState _updateCacheSize(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.cacheSize = action.payload;
  return newState;
}

SettingState _switchDeleteApk(SettingState state, Action action) {
  AppSetUtil.saveValue(AppSetUtil.KEY_IS_DELETE_APK, !state.isDeleteApk);
  return state.clone()..isDeleteApk = !state.isDeleteApk;
}

SettingState _switchPushMsg(SettingState state, Action action) {
  AppSetUtil.saveValue(AppSetUtil.KEY_ACCPET_PUSH, !state.accpetPush);
  return state.clone()..accpetPush = !state.accpetPush;
}

SettingState _switchWifi(SettingState state, Action action) {
  AppSetUtil.saveValue(AppSetUtil.KEY_IS_4G_DOWN, !state.is4gDown);
  return state.clone()..is4gDown = !state.is4gDown;
}

SettingState _switchVideoVolume(SettingState state, Action action) {
  VideoUtil.setOpenVolume(!state.videoVolumeOpen);
  showToast(getText(name: 'toastResetApp'));
  return state.clone()..videoVolumeOpen = !state.videoVolumeOpen;
}