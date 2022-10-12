import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AccountRecyclePaybackAction { action, switchPay, pay }

class AccountRecyclePaybackActionCreator {
  static Action onAction() {
    return const Action(AccountRecyclePaybackAction.action);
  }

  static Action pay() {
    return Action(AccountRecyclePaybackAction.pay);
  }

  static Action switchPay(int index) {
    return Action(AccountRecyclePaybackAction.switchPay, payload: index);
  }
}
