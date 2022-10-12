import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/share_info.dart';

//TODO replace with your own action
enum InviteAction {
  action,
  update,
  showShare,
  notifyShare,
  gotoReward,
  gotoRule,
}

class InviteActionCreator {
  static Action onAction() {
    return const Action(InviteAction.action);
  }

  static Action update(ShareInfo shareInfo) {
    return Action(InviteAction.update, payload: shareInfo);
  }

  static Action showShare() {
    return Action(InviteAction.showShare);
  }

  static Action notifyShare(String target) {
    return Action(InviteAction.notifyShare, payload: target);
  }

  static Action gotoReward() {
    return Action(InviteAction.gotoReward);
  }

  static Action gotoRule() {
    return Action(InviteAction.gotoRule);
  }
}
