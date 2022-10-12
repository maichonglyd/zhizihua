import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

//TODO replace with your own action
enum MyWalletAction {
  action,
  gotoExpensePage,
  gotoIncomePage,
  gotoRecharge,
  getUserInfo,
  updatePtbCnt,
}

class MyWalletActionCreator {
  static Action onAction() {
    return const Action(MyWalletAction.action);
  }

  static Action gotoExpensePage() {
    return const Action(MyWalletAction.gotoExpensePage);
  }

  static Action gotoIncomePage() {
    return const Action(MyWalletAction.gotoIncomePage);
  }

  static Action gotoRecharge() {
    return const Action(MyWalletAction.gotoRecharge);
  }

  static Action getUserInfo() {
    return const Action(MyWalletAction.getUserInfo);
  }

  static Action updateUserInfo(UserInfo userInfo) {
    return Action(MyWalletAction.updatePtbCnt, payload: userInfo);
  }
}
