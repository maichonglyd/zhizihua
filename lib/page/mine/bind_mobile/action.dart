import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum BindMobileAction {
  action,
  bindMobile,
  sendSms,
  updateDownTime,
}

class BindMobileActionCreator {
  static Action onAction() {
    return const Action(BindMobileAction.action);
  }

  static Action sendSms() {
    return const Action(BindMobileAction.sendSms);
  }

  static Action bindMobile() {
    return const Action(BindMobileAction.bindMobile);
  }

  static Action updateDownTime(int count) {
    return Action(BindMobileAction.updateDownTime, payload: count);
  }
}
