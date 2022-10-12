import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CouponCenterState> buildReducer() {
  return asReducer(
    <Object, Reducer<CouponCenterState>>{
      CouponCenterAction.action: _onAction,
      CouponCenterAction.updateData: _updateData,
    },
  );
}

CouponCenterState _onAction(CouponCenterState state, Action action) {
  final CouponCenterState newState = state.clone();
  return newState;
}

CouponCenterState _updateData(CouponCenterState state, Action action) {
  final CouponCenterState newState = state.clone();
  newState.gameCouponList = action.payload;
  return newState;
}
