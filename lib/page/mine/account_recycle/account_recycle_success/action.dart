import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AccountRecycleSuccessAction { action }

class AccountRecycleSuccessActionCreator {
  static Action onAction() {
    return const Action(AccountRecycleSuccessAction.action);
  }
}
