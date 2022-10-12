import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GiftItemAction { action, gotoGiftDetails, addGift }

class GiftItemActionCreator {
  static Action onAction() {
    return const Action(GiftItemAction.action);
  }

  static Action gotoGiftDetails() {
    return const Action(GiftItemAction.gotoGiftDetails);
  }

  static Action addGift() {
    return const Action(GiftItemAction.addGift);
  }
}
