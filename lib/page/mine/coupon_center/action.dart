import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';

//TODO replace with your own action
enum CouponCenterAction {
  action,
  getData,
  updateData,
  searchCoupon,
  obtainCoupon,
}

class CouponCenterActionCreator {
  static Action onAction() {
    return const Action(CouponCenterAction.action);
  }

  static Action getData(int page) {
    return Action(CouponCenterAction.getData, payload: page);
  }

  static Action updateData(List<CouponCenter> list) {
    return Action(CouponCenterAction.updateData, payload: list);
  }

  static Action searchCoupon() {
    return Action(CouponCenterAction.searchCoupon,);
  }

  static Action obtainCoupon(int couponId) {
    return Action(CouponCenterAction.obtainCoupon, payload: couponId);
  }
}
