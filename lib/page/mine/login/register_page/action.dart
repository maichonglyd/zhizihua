import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RegisterPageAction {
  action,
  switchRegisterType,
  sendSMS,
  mobileRegister,
  usernameRegister,
  updateDownTime,
  gotoRegisterAgreement,
}

class RegisterPageActionCreator {
  static Action onAction() {
    return const Action(RegisterPageAction.action);
  }

  static Action gotoRegisterAgreement() {
    return const Action(RegisterPageAction.gotoRegisterAgreement);
  }

  static Action switchRegisterType() {
    return const Action(RegisterPageAction.switchRegisterType);
  }

  static Action sendSMS() {
    return const Action(RegisterPageAction.sendSMS);
  }

  static Action mobileRegister() {
    return const Action(RegisterPageAction.mobileRegister);
  }

  static Action usernameRegister() {
    return const Action(RegisterPageAction.usernameRegister);
  }

  static Action updateDownTime(int downTime) {
    return Action(RegisterPageAction.updateDownTime, payload: downTime);
  }
}
