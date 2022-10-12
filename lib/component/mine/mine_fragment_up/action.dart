import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';

enum MineFragmentAction {
  action,
  getUserInfo,
  updateUserInfo,
  updateMemberData,
  showSign,
  getMsgCount,
  updateMsgCount,
  gotoMessage,
  gotoMemberCenter,
  getMemInfo
}

class MineFragmentActionCreator {
  static Action onAction() {
    return const Action(MineFragmentAction.action);
  }

  static Action getMemInfo() {
    return const Action(MineFragmentAction.getMemInfo);
  }

  static Action getUserInfo() {
    return const Action(MineFragmentAction.getUserInfo);
  }

  static Action updateUserInfo(UserInfo userInfo) {
    return Action(MineFragmentAction.updateUserInfo, payload: userInfo);
  }

  static Action updateMemberData(MemInfoData memInfo) {
    return Action(MineFragmentAction.updateMemberData, payload: memInfo);
  }

  static Action showSign() {
    return const Action(MineFragmentAction.showSign);
  }

  static Action getMsgCount() {
    return Action(MineFragmentAction.getMsgCount);
  }

  static Action updateMsgCount(int msgCount) {
    return Action(MineFragmentAction.updateMsgCount, payload: msgCount);
  }

  static Action gotoMessage() {
    return Action(MineFragmentAction.gotoMessage);
  }

  static Action gotoMemberCenter() {
    return Action(MineFragmentAction.gotoMemberCenter);
  }
}
