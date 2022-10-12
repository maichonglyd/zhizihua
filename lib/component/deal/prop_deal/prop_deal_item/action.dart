import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PropDealItemAction { action, gotoDetails }

class PropDealItemActionCreator {
  static Action onAction() {
    return const Action(PropDealItemAction.action);
  }

  static Action gotoDetails() {
    return const Action(PropDealItemAction.gotoDetails);
  }
}
