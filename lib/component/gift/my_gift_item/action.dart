import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MyGiftItemAction { action, gotoGiftDetails, copy }

class MyGiftItemActionCreator {
  static Action onAction() {
    return const Action(MyGiftItemAction.action);
  }

  static Action gotoGiftDetails() {
    return const Action(MyGiftItemAction.gotoGiftDetails);
  }

  static Action copy() {
    return const Action(MyGiftItemAction.copy);
  }
}
