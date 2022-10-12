import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PaySuccessAction { action, gotoMemberCenter }

class PaySuccessActionCreator {
  static Action onAction() {
    return const Action(PaySuccessAction.action);
  }

  static Action gotoMemberCenter() {
    return Action(PaySuccessAction.gotoMemberCenter);
  }
}
