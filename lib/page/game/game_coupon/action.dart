import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';

//TODO replace with your own action
enum GameCouponAction {
  action,
  getData,
  updateData,
  getCoupon,
}

class GameCouponActionCreator {
  static Action onAction() {
    return const Action(GameCouponAction.action);
  }

  static Action getData(int page) {
    return Action(GameCouponAction.getData, payload: page);
  }

  static Action updateData(List<CvCouponBean> list) {
    return Action(GameCouponAction.updateData, payload: list);
  }

  static Action getCoupon(num id) {
    return Action(GameCouponAction.getCoupon, payload: id);
  }
}
