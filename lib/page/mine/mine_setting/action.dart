import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

//TODO replace with your own action
enum SettingAction {
  action,
  gotoFeedback,
  gotoAccountManage,
  switchWifi,
  switchPushMsg,
  switchDeleteApk,
  logout,
  clearCache,
  updateCacheSize,
  onNotifyUpInfo,
  changUrl,
  switchVideoVolume,
}

class SettingActionCreator {
  static Action onAction() {
    return const Action(SettingAction.action);
  }

  static Action clearCache() {
    return Action(SettingAction.clearCache);
  }

  static Action updateCacheSize(String size) {
    return Action(SettingAction.updateCacheSize, payload: size);
  }

  static Action gotoFeedback() {
    return const Action(SettingAction.gotoFeedback);
  }

  static Action gotoAccountManage() {
    return const Action(SettingAction.gotoAccountManage);
  }

  static Action switchWifi() {
    return const Action(SettingAction.switchWifi);
  }

  static Action switchPushMsg() {
    return const Action(SettingAction.switchPushMsg);
  }

  static Action switchDeleteApk() {
    return const Action(SettingAction.switchDeleteApk);
  }

  static Action logout() {
    return const Action(SettingAction.logout);
  }

  static Action onNotifyUpInfo() {
    return Action(SettingAction.onNotifyUpInfo);
  }

  static Action changeUrl() {
    return Action(SettingAction.changUrl);
  }

  static Action switchVideoVolume() {
    return const Action(SettingAction.switchVideoVolume);
  }
}
