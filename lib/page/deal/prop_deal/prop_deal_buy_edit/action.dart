import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PropDealBuyAction { action, buy }

class PropDealBuyActionCreator {
  static Action onAction() {
    return const Action(PropDealBuyAction.action);
  }

  static Action buy() {
    return const Action(PropDealBuyAction.buy);
  }
}
