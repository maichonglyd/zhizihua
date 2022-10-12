import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum UpdatePasswordAction {
  action,
  updatePwd,
}

class UpdatePasswordActionCreator {
  static Action onAction() {
    return const Action(UpdatePasswordAction.action);
  }

  static Action updatePwd() {
    return const Action(UpdatePasswordAction.updatePwd);
  }
}
