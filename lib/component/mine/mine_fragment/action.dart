import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

enum MineFragmentAction {
  action,
  getUserInfo,
  updateUserInfo,
  showSign,
  getMsgCount,
  updateMsgCount,
  gotoMessage,
}

class MineFragmentActionCreator {
  static Action onAction() {
    return const Action(MineFragmentAction.action);
  }

  static Action getUserInfo() {
    return const Action(MineFragmentAction.getUserInfo);
  }

  static Action updateUserInfo(UserInfo userInfo) {
    return Action(MineFragmentAction.updateUserInfo, payload: userInfo);
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
}
