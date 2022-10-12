import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameDateilsRebateAction {
  action,
  gotoRebate,
  getCoupon,
}

class GameDateilsRebateActionCreator {
  static Action onAction() {
    return const Action(GameDateilsRebateAction.action);
  }

  static Action gotoRebate() {
    return const Action(GameDateilsRebateAction.gotoRebate);
  }

  static Action getCoupon(int id) {
    return Action(GameDateilsRebateAction.getCoupon, payload: id);
  }
}
