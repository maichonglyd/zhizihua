import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FindPasswordAction {
  action,
  commitData,
  getBindInfo,
  sendSms,
  passwordVerify,
  passwordReset,
  nextStep,
  updateDownTime,
  gotoServer,
}

class FindPasswordActionCreator {
  static Action onAction() {
    return const Action(FindPasswordAction.action);
  }

  static Action getBindInfo() {
    return const Action(FindPasswordAction.getBindInfo);
  }

  static Action sendSms() {
    return const Action(FindPasswordAction.sendSms);
  }

  static Action passwordVerify() {
    return const Action(FindPasswordAction.passwordVerify);
  }

  static Action passwordReset() {
    return const Action(FindPasswordAction.passwordReset);
  }

  static Action nextStep(data) {
    return Action(FindPasswordAction.nextStep, payload: data);
  }

  static Action updateDownTime(int count) {
    return Action(FindPasswordAction.updateDownTime, payload: count);
  }

  static Action commitData() {
    return Action(FindPasswordAction.commitData);
  }

  static Action gotoServer() {
    return Action(FindPasswordAction.gotoServer);
  }
}
