import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexDealHeadAction {
  action,
  gotoLogin,
  gotoMyBuyPage,
  gotoMySellPage,
}

class IndexDealHeadActionCreator {
  static Action onAction() {
    return const Action(IndexDealHeadAction.action);
  }

  static Action gotoLogin() {
    return const Action(IndexDealHeadAction.gotoLogin);
  }

  static Action gotoMyBuyPage() {
    return const Action(IndexDealHeadAction.gotoMyBuyPage);
  }

  static Action gotoMySellPage(int index) {
    return Action(IndexDealHeadAction.gotoMySellPage, payload: index);
  }
}
