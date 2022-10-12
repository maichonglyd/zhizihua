import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AccountRecycleTipAction { action }

class AccountRecycleTipActionCreator {
  static Action onAction() {
    return const Action(AccountRecycleTipAction.action);
  }
}
