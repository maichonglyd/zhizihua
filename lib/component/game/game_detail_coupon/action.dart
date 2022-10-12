import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GameDetailCouponAction {
  action,
  getCoupon,
}

class GameDetailCouponActionCreator {
  static Action onAction() {
    return const Action(GameDetailCouponAction.action);
  }

  static Action getCoupon(int id) {
    return Action(GameDetailCouponAction.getCoupon, payload: id);
  }
}
