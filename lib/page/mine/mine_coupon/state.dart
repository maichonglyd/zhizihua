import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_list/state.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_list/state.dart'
    as coupon_state;

class MineCouponState implements Cloneable<MineCouponState> {
  CouponListState couponUnUsedState;
  CouponListState couponUsedState;
  CouponListState couponExpiredState;

  @override
  MineCouponState clone() {
    return MineCouponState()
      ..couponUnUsedState = couponUnUsedState
      ..couponUsedState = couponUsedState
      ..couponExpiredState = couponExpiredState;
  }
}

MineCouponState initState(Map<String, dynamic> args) {
  return MineCouponState()
    ..couponUnUsedState = coupon_state.initState(1)
    ..couponUsedState = coupon_state.initState(2)
    ..couponExpiredState = coupon_state.initState(3);
}

class CouponUnUsedConnector extends ConnOp<MineCouponState, CouponListState> {
  @override
  void set(MineCouponState state, CouponListState subState) {
//    super.set(state, subState);
    state.couponUnUsedState = subState;
  }

  @override
  CouponListState get(MineCouponState state) {
    return state.couponUnUsedState;
  }
}

class CouponUsedConnector extends ConnOp<MineCouponState, CouponListState> {
  @override
  void set(MineCouponState state, CouponListState subState) {
//    super.set(state, subState);
    state.couponUsedState = subState;
  }

  @override
  CouponListState get(MineCouponState state) {
    return state.couponUsedState;
  }
}

class CouponExpiredConnector extends ConnOp<MineCouponState, CouponListState> {
  @override
  void set(MineCouponState state, CouponListState subState) {
//    super.set(state, subState);
    state.couponExpiredState = subState;
  }

  @override
  CouponListState get(MineCouponState state) {
    return state.couponExpiredState;
  }
}
