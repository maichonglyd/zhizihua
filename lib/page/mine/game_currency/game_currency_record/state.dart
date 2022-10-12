import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/record_list/state.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_list/state.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/record_list/state.dart'
    as coupon_state;

class MineCurrRecordState implements Cloneable<MineCurrRecordState> {
  CurrRecordListState couponUnUsedState;
  CurrRecordListState couponUsedState;

//  CouponListState couponExpiredState;
  int gameId;

  @override
  MineCurrRecordState clone() {
    return MineCurrRecordState()
      ..couponUnUsedState = couponUnUsedState
      ..couponUsedState = couponUsedState;
//      ..couponExpiredState = couponExpiredState;
  }
}

MineCurrRecordState initState(Map<String, dynamic> args) {
  return MineCurrRecordState()
    ..gameId = args["gameId"]
    ..couponUnUsedState = coupon_state.initState(1, args["gameId"])
    ..couponUsedState = coupon_state.initState(2, args["gameId"]);
//    ..couponExpiredState = coupon_state.initState(3);
}

class TakeRecordConnector
    extends ConnOp<MineCurrRecordState, CurrRecordListState> {
  @override
  void set(MineCurrRecordState state, CurrRecordListState subState) {
//    super.set(state, subState);
    state.couponUnUsedState = subState;
  }

  @override
  CurrRecordListState get(MineCurrRecordState state) {
    return state.couponUnUsedState;
  }
}

class UseRecordConnector
    extends ConnOp<MineCurrRecordState, CurrRecordListState> {
  @override
  void set(MineCurrRecordState state, CurrRecordListState subState) {
//    super.set(state, subState);
    state.couponUsedState = subState;
  }

  @override
  CurrRecordListState get(MineCurrRecordState state) {
    return state.couponUsedState;
  }
}

//class CouponExpiredConnector
//    extends ConnOp<MineCurrRecordState, CouponListState> {
//  @override
//  void set(MineCurrRecordState state, CouponListState subState) {
////    super.set(state, subState);
//    state.couponExpiredState = subState;
//  }
//
//  @override
//  CouponListState get(MineCurrRecordState state) {
//    return state.couponExpiredState;
//  }
//}
