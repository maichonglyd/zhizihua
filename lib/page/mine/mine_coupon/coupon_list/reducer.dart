import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CouponListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CouponListState>>{
      CouponListAction.action: _onAction,
      CouponListAction.updateCouponList: _updateCouponList,
    },
  );
}

CouponListState _onAction(CouponListState state, Action action) {
  final CouponListState newState = state.clone();
  return newState;
}

CouponListState _updateCouponList(CouponListState state, Action action) {
  final CouponListState newState = state.clone();
  newState.coupons = action.payload;
  return newState;
}
