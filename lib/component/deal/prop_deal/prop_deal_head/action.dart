import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PropDealHeadAction {
  action,
  gotoLogin,
  gotoMyBuyPage,
  gotoMySellPage,
}

class PropDealHeadActionCreator {
  static Action onAction() {
    return const Action(PropDealHeadAction.action);
  }

  static Action gotoLogin() {
    return const Action(PropDealHeadAction.gotoLogin);
  }

  static Action gotoMyBuyPage() {
    return const Action(PropDealHeadAction.gotoMyBuyPage);
  }

  static Action gotoMySellPage(int index) {
    return Action(PropDealHeadAction.gotoMySellPage, payload: index);
  }
}
