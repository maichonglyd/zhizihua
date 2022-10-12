import 'package:fish_redux/fish_redux.dart';

enum MineTopTabAction {
  action,
  gotoMyGift,
  gotoIntegralShop,
  gotoRecharge,
  gotoDownload,
}

class MineTopTabActionCreator {
  static Action onAction() {
    return const Action(MineTopTabAction.action);
  }

  static Action gotoMyGift() {
    return const Action(MineTopTabAction.gotoMyGift);
  }

  static Action gotoIntegralShop() {
    return const Action(MineTopTabAction.gotoIntegralShop);
  }

  static Action gotoRecharge() {
    return const Action(MineTopTabAction.gotoRecharge);
  }

  static Action gotoDownload() {
    return const Action(MineTopTabAction.gotoDownload);
  }
}
