import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VIPPrivilegeAction {
  action,
  gotoMyGift,
}

class VIPPrivilegeActionCreator {
  static Action onAction() {
    return const Action(VIPPrivilegeAction.action);
  }
}
