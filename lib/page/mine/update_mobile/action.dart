import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum UpdateMobileAction {
  action,
  sendSms,
  checkMobile,
  updateDownTime,
  getBindInfo,
}

class UpdateMobileActionCreator {
  static Action onAction() {
    return const Action(UpdateMobileAction.action);
  }

  static Action sendSms() {
    return const Action(UpdateMobileAction.sendSms);
  }

  static Action checkMobile() {
    return const Action(UpdateMobileAction.checkMobile);
  }

  static Action updateDownTime(int count) {
    return Action(UpdateMobileAction.updateDownTime, payload: count);
  }
}
