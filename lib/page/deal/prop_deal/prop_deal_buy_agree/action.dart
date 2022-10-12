import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PropDealBuyAgreeAction { action, commit }

class PropDealBuyAgreeActionCreator {
  static Action onAction() {
    return const Action(PropDealBuyAgreeAction.action);
  }

  static Action commit() {
    return const Action(PropDealBuyAgreeAction.commit);
  }
}
